//
//  File.swift
//  SearchPoint
//
//  Created by "" on 15/10/2019.
//  ""
//

import Foundation
import UIKit
import Alamofire


let appID = "9EF36AD9-CF10-49E0-BD20-9740E2885E3B"

class CommonClass {
    static func showAlertMessage(_ vc: UIViewController, titleStr:String, messageStr:String) -> Void {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)

    }
}

let kColor_ContollersCellSelected : UIColor = UIColor(red: 109.0/255, green: 201.0/255.0, blue: 218.0/255.0, alpha: 1.0)
let kColor_ContollersCellUnSelected : UIColor = UIColor(red: 230.0/255, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)


class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}


@IBDesignable class RoundedCornerView: UILabel {

    @IBInspectable var borderWidth: CGFloat = 0.0{
      didSet {
        self.layer.borderWidth = self.borderWidth
      }
    }
    @IBInspectable var corner: Int = 10 {
      didSet {
      self.layer.cornerRadius = self.bounds.size.height/2
      }
    }
}

func getDateString(date: String, inputformatter: String, outputformatter: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: LocalizedStrings.en_US_POSIXStr) // set locale to reliable US_POSIX
    dateFormatter.dateFormat = inputformatter
  
    let date = dateFormatter.date(from: date)
   
    return date?.string(format: outputformatter) ?? ""
}

func getOrderedDateStringFrom(date: Date, inputformatter: String, outputformatter: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: LocalizedStrings.en_US_POSIXStr) // set locale to reliable US_POSIX
    dateFormatter.dateFormat = outputformatter
 
    let date = dateFormatter.string(from: date)
   
    return date
}


//MARK :- Checking If barcode ending with number and Getting Incremented Barcode
func isBarCodeEndsWithNumber_GetIncrementedBarCode(_ barcode: String) -> (isBarCodeEndsWithNumber: Bool, incrementedBarCode: String) {
    var digits = ""
    var incrementedBarCode = ""
    
    for letter in String(barcode.reversed()).unicodeScalars {
        if 48...57 ~= letter.value {
            digits.append(String(letter))
        } else {
            break
        }
    }
    
    digits = String(digits.reversed())
    let numberAsInt = Int(digits)

    
    if digits.isEmpty == false {
        
        let barcodeWithouDigit =  barcode.prefix(barcode.count - digits.count)
        var number = Int(digits) ?? 0
        number += 1
      
        
        let digitCount = digits.count
        let numberCount = String(numberAsInt!).count
        let countCheck = digitCount - numberCount
        var zeroCount = String()
        
        if countCheck > 0  {
            for _ in 0...countCheck - 1{
                zeroCount = "0" + zeroCount
            }
        }
        
       if barcodeWithouDigit == "" {
            incrementedBarCode = barcodeWithouDigit + "\(number)"
            
        } else {
            
            incrementedBarCode = barcodeWithouDigit + zeroCount + "\(number)"
        }
        
        
        
    } else {
        incrementedBarCode = barcode
    }
    
    return (isBarCodeEndsWithNumber: !digits.isEmpty, incrementedBarCode: incrementedBarCode)
}
