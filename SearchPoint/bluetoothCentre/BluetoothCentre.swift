//
//  bluetoothCentre.swift
//  BluetoothDemo
//
//  Created by "" on 14/10/2019.
//  Copyright © 2019 "". All rights reserved.
//

import Foundation
import Toast_Swift
import CoreBluetooth

protocol RFID {
    func rfidCode(rfid : String)
}
protocol nearByDevice {
    func deviceNear(deviceName : [CBPeripheral])
}
class BluetoothCentre :NSObject{
    
    var nearByDeviceDelegate :nearByDevice?
    var cbPerpgerialArray = [CBPeripheral]()
    var abc = [Character]()
    var manager = CBCentralManager()
    var navController = UIViewController()
    var smartBowPeripheral : CBPeripheral?
    var rfid = String()
    var delegateRFID : RFID?
    static var shared = BluetoothCentre()
    private override init() {
        super.init()
        manager.delegate = self
    }
}
extension BluetoothCentre : CBCentralManagerDelegate,CBPeripheralDelegate{
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        switch central.state {
        case .poweredOff:
            if let vc = navController as? OrderingAnimalVC{
                if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue {

                }else {
                vc.bleBttn.setImage(UIImage(named: ImageNames.scanIconActiveImg), for: .normal)
                vc.view.makeToast(NSLocalizedString(AlertMessagesStrings.bluetoothOffText, comment: "") )
                }
            }
            if let vc = navController as? MyHerdResultsViewController
            {
                if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue {

                }else {
                vc.blebttn1.setBackgroundImage(UIImage(named: ImageNames.scanIconActiveImg), for: .normal)
                vc.view.makeToast(NSLocalizedString(AlertMessagesStrings.bluetoothOffText, comment: "") )
                }
            }
            if let vc = navController as? GroupDetailsViewController
            {
                if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue {

                }else {
                vc.blebttn1.setBackgroundImage(UIImage(named: ImageNames.scanIconActiveImg), for: .normal)
                vc.view.makeToast(NSLocalizedString(AlertMessagesStrings.bluetoothOffText, comment: "") )
                }
            }
        case .unsupported:
            print( "This device does not support Bluetooth Low Energy.")
        case .unauthorized:
            print( "This app is not authorized to use Bluetooth Low Energy.")
        case .resetting:
            print("The BLE Manager is resetting; a state update is pending.")
        case .unknown:
            print("The state of the BLE Manager is unknown.")
        case .poweredOn:
            print( "Bluetooth LE is turned on and ready for communication.")
            //Initiate Scan for Peripherals
            //Option 1: Scan for all devices
            //manager.scanForPeripherals(withServices: nil, options: nil)
            //Option 2: Scan for devices that have the service you're interested in...
            let sensorTagAdvertisingUUID = CBUUID(string: "00001101-0000-1000-8000-00805F9B34FB")//"725F8937-7F98-96E5-C54F-B48A18AD68B9")
            print("Scanning for SensorTag adverstising with UUID: \(sensorTagAdvertisingUUID)")
            manager.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        var pName = peripheral.name ?? ""
        let peripheralName = pName.prefix(3)
       // print(peripheralName)
        cbPerpgerialArray.append(peripheral)
        cbPerpgerialArray = cbPerpgerialArray.removeDuplicates()
        nearByDeviceDelegate?.deviceNear(deviceName: cbPerpgerialArray)
//        if peripheralName == "ELD"{
//            manager.connect(peripheral, options: [:])
//            smartBowPeripheral = peripheral
//        }
    }
    
    func ConnectArgument(peripheral :CBPeripheral){
        
        manager.connect(peripheral, options: [:])
        smartBowPeripheral = peripheral

    }
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue {

        } else {
        smartBowPeripheral = peripheral
      //  print("connected van")
        manager.stopScan()
        smartBowPeripheral?.delegate = self
        smartBowPeripheral?.discoverServices(nil)
        if let vc = navController as? OrderingAnimalVC{
        if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue {

        } else {

        vc.view.makeToast(NSLocalizedString("Bluetooth device paired successfully.", comment: ""))
        vc.bleBttn.setImage(UIImage(named: ImageNames.forma1Copy2Img), for: .normal)
        vc.blebttn1.setImage(UIImage(named: ImageNames.forma1Copy2Img), for: .normal)
        }
        }
         if let vc = navController as? MyHerdResultsViewController
         {
            if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue {

            } else {

            vc.view.makeToast(NSLocalizedString("Bluetooth device paired successfully.", comment: ""))
            //vc.bleBttn.setImage(UIImage(named: ImageNames.forma1Copy2Img), for: .normal)
            vc.blebttn1.setBackgroundImage(UIImage(named: ImageNames.forma1Copy2Img), for: .normal)
            }
         }
            if let vc = navController as? GroupDetailsViewController
            {
               if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue {

               } else {

               vc.view.makeToast(NSLocalizedString("Bluetooth device paired successfully.", comment: ""))
               //vc.bleBttn.setImage(UIImage(named: ImageNames.forma1Copy2Img), for: .normal)
               vc.blebttn1.setBackgroundImage(UIImage(named: ImageNames.forma1Copy2Img), for: .normal)
               }
            }
            
        }
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
       // print("disconnect")
        var pName = peripheral.name ?? ""
        let peripheralName = pName.prefix(3)
      //  print(peripheralName)
        
        if peripheralName != ""{
            if let vc = navController as? OrderingAnimalVC{
               if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue {

               }else {

                vc.bleBttn.setImage(UIImage(named: ImageNames.scanIconActiveImg), for: .normal)
                vc.blebttn1.setImage(UIImage(named: ImageNames.scanIconActiveImg), for: .normal)

                vc.view.makeToast(NSLocalizedString("Bluetooth device disconnected.", comment: ""))
                manager.cancelPeripheralConnection(peripheral)
                manager.scanForPeripherals(withServices: nil, options: nil)
                }
                
            }
            if let vc = navController as? MyHerdResultsViewController
            {
                if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue {

                }else {

                // vc.bleBttn.setImage(UIImage(named: ImageNames.scanIconActiveImg), for: .normal)
                 vc.blebttn1.setBackgroundImage(UIImage(named: ImageNames.scanIconActiveImg), for: .normal)

                 vc.view.makeToast(NSLocalizedString("Bluetooth device disconnected.", comment: ""))
                 manager.cancelPeripheralConnection(peripheral)
                 manager.scanForPeripherals(withServices: nil, options: nil)
                 }
            }
            if let vc = navController as? GroupDetailsViewController
            {
                if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue {

                }else {

                // vc.bleBttn.setImage(UIImage(named: ImageNames.scanIconActiveImg), for: .normal)
                 vc.blebttn1.setBackgroundImage(UIImage(named: ImageNames.scanIconActiveImg), for: .normal)

                 vc.view.makeToast(NSLocalizedString("Bluetooth device disconnected.", comment: ""))
                 manager.cancelPeripheralConnection(peripheral)
                 manager.scanForPeripherals(withServices: nil, options: nil)
                 }
            }
            
        }
        
        
    }
    //Peripheral delegates
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        if let services = peripheral.services {
            for service in services {
                smartBowPeripheral?.discoverCharacteristics(nil, for: service)
            }
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            // 1
            for characteristic in characteristics {
                smartBowPeripheral?.setNotifyValue(true, for: characteristic)
            }
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        if characteristic.uuid == CBUUID(string:"FF01"){
            for i in characteristic.value! {
                let char = Character(UnicodeScalar(i))
                abc.append(char)
               // print(abc)
            }
            rfid = ""
            rfid.removeAll()
            let str = String(abc)
            let demo1 =  str.replacingOccurrences(of: "[-?*%]", with: "", options: .regularExpression, range: nil)


            rfid = String(demo1)
            abc.removeAll()
           // print(rfid)
            
            delegateRFID?.rfidCode(rfid: rfid)
        }
    }
    
    
}






extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}







////
////  bluetoothCentre.swift
////  BluetoothDemo
////
////  Created by "" on 14/10/2019.
////  Copyright © 2019 "". All rights reserved.
////
//
//import Foundation
//import Toast_Swift
//import CoreBluetooth
//
//protocol RFID {
//    func rfidCode(rfid : String)
//    func deviceScanning(deviceName : [CBPeripheral])
//
//}
//class BluetoothCentre :NSObject{
//
//    var manager = CBCentralManager()
//    var myPeripheral : CBPeripheral?
//    var arrperi = [CBPeripheral]()
//    var delegate : RFID?
//    var abc = [Character]()
//    var rfid = String()
//    var navController = UIViewController()
//
//    static var shared = BluetoothCentre()
//    private override init() {
//        super.init()
//        manager.delegate = self
//    }
//}
//extension BluetoothCentre : CBCentralManagerDelegate,CBPeripheralDelegate{
//    func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        switch central.state {
//        case .poweredOff:
//           print("Powered  OFF")
//            if let vc = navController as? OrderingAnimalVC{
//
//                // vc.bleBttn.backgroundColor = UIColor.clear
//                 vc.bleBttn.setImage(UIImage(named: ImageNames.scanIconActiveImg), for: .normal)
//                 vc.view.makeToast(NSLocalizedString(AlertMessagesStrings.bluetoothOffText, comment: "") )
//
//             }
//        case .unsupported:
//            print( "This device does not support Bluetooth Low Energy.")
//        case .unauthorized:
//            print( "This app is not authorized to use Bluetooth Low Energy.")
//        case .resetting:
//            print("The BLE Manager is resetting; a state update is pending.")
//        case .unknown:
//            print("The state of the BLE Manager is unknown.")
//        case .poweredOn:
//            print( "Bluetooth LE is turned on and ready for communication.")
//            //Initiate Scan for Peripherals
//            //Option 1: Scan for all devices
//            //manager.scanForPeripherals(withServices: nil, options: nil)
//            //Option 2: Scan for devices that have the service you're interested in...
//            let sensorTagAdvertisingUUID = CBUUID(string: "00001101-0000-1000-8000-00805F9B34FB")//"725F8937-7F98-96E5-C54F-B48A18AD68B9")
//            print("Scanning for SensorTag adverstising with UUID: \(sensorTagAdvertisingUUID)")
//            manager.scanForPeripherals(withServices: nil, options: nil)
//        }
//    }
//    func connectPeripheral(peripheral : CBPeripheral){
//        manager.connect(peripheral, options: [:])
//        myPeripheral = peripheral
//    }
//    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//        let myVC = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.orderingAnimalVC) as? OrderingAnimalVC
//
//           print(peripheral.name)
//           arrperi.append(peripheral)
//           arrperi = arrperi.removeDuplicates()
//          // delegate?.rfidCode(rfid: arrperi)
//
//
//    }
//    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
//          myPeripheral = peripheral
//          print("connected van")
//          manager.stopScan()
//          myPeripheral?.delegate = self
//          myPeripheral?.discoverServices(nil)
//        if let vc = navController as? OrderingAnimalVC{
//
//         vc.view.makeToast(NSLocalizedString("Bluetooth device paired successfully.", comment: ""))
//         vc.bleBttn.setImage(UIImage(named: ImageNames.forma1Copy2Img), for: .normal)
//         vc.blebttn1.setImage(UIImage(named: ImageNames.forma1Copy2Img), for: .normal)
//
//         }
//
//
//      }
//    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
//
//           if let services = peripheral.services {
//               for service in services {
//                   myPeripheral?.discoverCharacteristics(nil, for: service)
//               }
//           }
//       }
//       func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
//           if let characteristics = service.characteristics {
//               // 1
//               for characteristic in characteristics {
//                   myPeripheral?.setNotifyValue(true, for: characteristic)
//               }
//           }
//       }
//    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
//
//
//               for i in characteristic.value! {
//                   let char = Character(UnicodeScalar(i))
//                   abc.append(char)
//                   print(abc)
//
//               }
//             rfid = ""
//             rfid.removeAll()
//             let str = String(abc)
//             let demo1 =  str.replacingOccurrences(of: "[-?*%]", with: "", options: .regularExpression, range: nil)
//
//            rfid = String(demo1)
//             abc.removeAll()
//             delegate?.rfidCode(rfid: rfid)
//
//       }
//}
//extension Array where Element:Equatable {
//    func removeDuplicates() -> [Element] {
//        var result = [Element]()
//
//        for value in self {
//            if result.contains(value) == false {
//                result.append(value)
//            }
//        }
//
//        return result
//    }
//}
//
