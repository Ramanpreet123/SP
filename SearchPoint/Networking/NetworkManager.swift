//
//  NetworkManager.swift
//  SearchPoint
//
//  Created by "" on 07/10/2019.
//  ""
//

import Foundation
import Alamofire

class NetworkManager {
    
    let progressQueue = DispatchQueue(label: "com.alamofire.progressQueue", qos: .utility)
    var delegate:ResponseDelegate!
    var header :HTTPHeaders!
    
    @IBOutlet var progressView: UIProgressView!
    
    func CallApi(packet:NetwrokPackets){
      let manager = AF
      manager.session.configuration.timeoutIntervalForRequest = 180
      manager.session.configuration.timeoutIntervalForResource = 180
        header = HTTPHeaders(packet.Headers ?? [LocalizedStrings.contentType: LocalizedStrings.formURLEncoded,"Accept": LocalizedStrings.appJson])
     
      manager.request(packet.Url, method: packet.Method, parameters: packet.bodyParams, encoding: JSONEncoding.default, headers: header, interceptor: nil)
        .response
        { response in
            print("URL ---------> \(String(describing: packet.Url))")
            print("Body Params ---------> \(String(describing: packet.bodyParams))")
            print("Headers ---------> \(String(describing: self.header))")
            print("Response ----------> \(String(describing: response.data?.toJsonString)) ")
   
            if response.error != nil {
                self.delegate.responseRecieved(nil, status: false)
            }else{
                if response.response?.statusCode == 400 ||  response.response?.statusCode == 401 {
                NotificationCenter.default.post(name: Notification.Name(LocalizedStrings.sessionExpiredStr), object: nil, userInfo: [LocalizedStrings.statusCodeText:"\(String(describing: response.response?.statusCode ?? 0))"])
                }
                if response.response?.statusCode == 200 {
                    self.delegate.responseRecieved(response.data, status: true)
                    Date().saveCurrentDate()
                   
                }

                else
                {
                    self.delegate.responseRecieved(response.data, status: false)
                }
            }
        }
    }
}



