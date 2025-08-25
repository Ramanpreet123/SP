//
//  TermsConditionViewModel.swift
//  SearchPoint
//
//  Created by "" on 11/12/19.
//

import Foundation
import UIKit
import Alamofire
import CoreData

class  TermsConditionViewModel {
    
    var dependency: Terms_ConditionsVC?
    var modalObject: TermsAcceptanceModel?
    weak var delegate: TermsConditionViewModelDelegate?
    
    var completion:()->()?
    
    init(ref:Terms_ConditionsVC,callBack:@escaping ()->()) {
        dependency = ref
        completion = callBack
    }
    /*********************************************************************************/
    
    func callTermsApi(accepted: Bool){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict :[String:String] = [LocalizedStrings.authorizationHeader:"" + " " + (accessToken ?? "")]
        let Network = NetworkManager()
        Network.delegate = self
        Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.post, Headers: headerDict, bodyParams: nil, Url: Configuration.Dev(packet: ApiKeys.acceptterms.rawValue+"/\(accepted)").getUrl()))
    }
}


extension TermsConditionViewModel: ResponseDelegate {
    func responseRecieved(_ data: Data?, status: Bool) {
        if !status {
            delegate?.responseRecieved(status: status)
        } else {
            let decoder = JSONDecoder()
            modalObject = try! decoder.decode(TermsAcceptanceModel.self, from: data!)
            DispatchQueue.main.async {
                self.completion()
            }
        }
    }
}
