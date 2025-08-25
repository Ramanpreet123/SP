//
//  ADHAnimalModel.swift
//  SearchPoint
//
//  Created by Rajni Raswant on 13/06/22.
//

import Foundation

//MARK: ADH ANIMAL MODEL
struct ADHAnimalModel {
    var addonName : String?
    var adhDataServer : Int?
    var adonId : Int?
    var animalId : Int?
    var animalName : String?
    var animalTag : String
    var animalbarCodeTag : String?
    var breedAssocation : String?
    var breedId : Int?
    var breedName : Int?
    var breedRegNumber : Int?
    var custId : String?
    var custmerId : Int64?
    var date : String?
    var eT : String?
    var earTag: String?
    var editFlagSave : String?
    var emailId : String?
    var farmId: String?
    var gender : String?
    var girlandoID : String?
    var isDataEmailed : String?
    var isSync : Bool?
    var isSyncServer : Int?
    var listId : Int?
    var mkdId : String?
    var nationHerdAU : String?
    var offDamId : String?
    var offPermanentId : String?
    var offsireId : String?
    var orderId : Int?
    var orderstatus : Bool?
    var productId : Int?
    var productName : String?
    var providerId : String?
    var selectedBornTypeId : Int?
    var serverAnimalId : String?
    var serverOrderId : String?
    var serverStatus : String?
    var sireIDAU : String?
    var specisType : String?
    var tertiaryGeno : String?
    var status : Bool?
    var tissuId : Int?
    var tissuName : String?
    var udid : String?
    var userId : Int?
    var showTextField : Bool
    var isADHSelected: Bool?
    init(farmId: String, animalTag: String, barCode: String = "", custmerId: Int64, showTextField: Bool = false, adhSelection: Bool = false) {
        self.farmId = farmId
        self.animalTag = animalTag
        self.animalbarCodeTag = barCode
        self.custmerId = custmerId
        self.showTextField = showTextField
        self.isADHSelected = adhSelection
    }
}


