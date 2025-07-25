//
//  OrderingDataListViewModel.swift
//  SearchPoint
//
//  Created by Rajni Raswant on 02/03/23.
//

import Foundation
import Alamofire

struct OrderingDataListViewModel {
  
  func makeListName(custmerId:Int, providerID: Int)-> String{
      var fullStr = String()
      let cartlist = "CartList"
    let customer_ID = String(custmerId )
      let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    if let userNameStr = UserDefaults.standard.value(forKey:keyValue.userName.rawValue) {
        if let speciesType = UserDefaults.standard.object(forKey: "name") {
         let species = speciesType as! String
          fullStr = String(customer_ID) + "_" + (userNameStr as? String ?? "")  + "_" + cartlist + "_" + species.lowercased()
        }
      }
      return fullStr
      
    }
  
  func hideInternalDataList(tempImportListArray:[DataEntryList]) -> [DataEntryList]{
    var importListArray = [DataEntryList]()
    var cartListName = "CartList"
    let speciesType = UserDefaults.standard.object(forKey: "name") as? String ?? ""
    cartListName = "_" + cartListName + "_" + speciesType
    for i in 0 ..< tempImportListArray.count {
      let listName = tempImportListArray[i].listName?.lowercased()
      if let emails = listName?.getEmails() {
        if emails.count > 0 {
          cartListName = emails[0] + "_" + cartListName + "_" + speciesType
          if (listName?.contains(cartListName.lowercased()) ?? false) {
            
          }
        } else {
          importListArray.append(tempImportListArray[i])
        }
      }
      
    }
    return importListArray
  }
 
func doesListExist(listName:String,customerId:Int64,completionHandler: @escaping CompletionHandler){
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    //let accessToken = appDelegate?.keychain_valueForKey(keyValue.accessToken.rawValue) as? String
   let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
    let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
    var header = HTTPHeaders(headerDict ?? [LocalizedStrings.contentType: LocalizedStrings.formURLEncoded,"Accept": LocalizedStrings.appJson])

    let urlString = Configuration.Dev(packet: ApiKeys.doesListExist.rawValue).getUrl()
    let parameters : [String: Any] = [keyValue.customerId.rawValue: customerId,keyValue.listName.rawValue:listName]

    var request = URLRequest(url: URL(string: urlString)! )
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = headerDict
    request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
    } catch let error {
        print(error.localizedDescription)
    }

    AF.request(request as URLRequestConvertible).responseJSON { response in
        let statusCode =  response.response?.statusCode
        if statusCode == 200 {
            
            switch response.result {
            case let .success(value):
               
                if value as! Int == 0 {
                    return completionHandler(true)
                } else {
                    return completionHandler(false)
                }
            case let .failure(error):
                print(error)
            }
           
        } else {
            //self.hideIndicator()
        }
    }
    return
}

}
