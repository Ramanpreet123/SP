//
//  ApiKeys.swift
//  SearchPoint
//
//  Created by "" on 10/10/2019.
//  ""
//

import Foundation
enum ApiKeys: String {
    case loginScreenSet = "v1/security/LoginScreenSet"
    case terms = "v1/apps/termsofservice"
    case animalByCustomer = "v1/Animals/animalsbyindex"
    case login = "v1/security/login"
    case logOut = "v1/security/logout"
    case getProviders = "v1/defaults/evaluationproviders"
    case getNominators = "v1/defaults/nominators"
    case getSampleType = "v1/defaults/sampletypes"
    case naabCodes =  "v1/defaults/naabcodes"
    case getSpecies = "v1/defaults/species"
    case contactSupport = "v1/apps/customersupport"
    case getMarkets = "v1/defaults/markets"
    case registerdevice = "v1/security/registerdevice"
    case validateDevice = "v1/security/validatedevice"
    case priorityBreeding = "v1/defaults/prioritybreedingprograms"
    case acceptterms = "v1/users/acceptterms"
    case getBreeds = "v1/defaults/breeds"
    case billingContacts = "v1/users/billtocustomer"
    case customerApi = "v1/users/customers"
    case ausNaabBull = "v1/defaults/australianbulls"

    case countryCode = "v1/defaults/countrycodes"
    case breedSoceities = "v1/defaults/breedassociations"
    case bornTypes = "v1/defaults/borntypes"
    case getProducts = "v1/defaults/products"
    case samplestatuses = "v1/defaults/samplestatuses"
    
    case actionRequiredDays = "v1/conflicts/actionsrequiredbypastdays"
    case ordersbypastdays = "v1/orders/ordersbypastdays"
    case ordersbydates = "v1/orders/ordersbydates"
    case blockYardSubmitOrder = "v1/orders/SubmitBlockyardOrder"

    
    //case getSpecies = "OrderDefaults/GetSpecies"
    case getDatabase = "OrderDefaults/GetDatabase"

  //  case getBreeds = "OrderDefaults/GetBreeds"
    //case getMarkets = "OrderDefaults/GetMarkets"
  //  case getProducts = "OrderDefaults/GetProducts"
    case getAddons = "OrderDefaults/GetAddons"
   // case getSampleType = "OrderDefaults/GetSampleTypes"
    //case contactSupport = "CustomerSupport/GetCustomerSupport"
   // case billingContacts = "BillingContact/GetBillingContacts"
    case animalPosting = "Animal/SaveMultiplePostingsSyncData"
    case productSave = "Product/SaveMultipleProductSyncData"
    case adonSave = "Product/SaveMultipleAddonSyncData"
  //  case termscondtion = "TermsAndCondition/SaveTermsAcceptance"
    case saveUserSetting = "Settings/SaveUserSetting"
    case orderSave = "v1/orders/submitorder"
    case emailSave = "v1/orders/emailorder"
    case breedCodes = "OrderDefaults/GetBreedCodes"
    //case naabCodes = "OrderDefaults/GetNaabCodes"
  //  case countryCode = "OrderDefaults/GetCountryCodes"
    //case priorityBreeding = "OrderDefaults/GetPriorityBreeding"
    case appVerisonAPI = "v1/apps/mobileversion/"
    case heartBeatAPI = "v1/apps/heartbeat/"
    case transulation = "v1/defaults/translations/"
    
    
    case doesListExist = "v1/Animals/doeslistexist"
    case deleteList = "v1/Animals/deletelist"
    case saveList = "v1/Animals/savelist"
    case saveUpdateLists =  "v1/Animals/savelists"
    case getListForCustomer = "v1/Animals/getlistsforcustomer"
    case emailMeList = "v1/Animals/emaillist"
    case savephoto = "v1/Animals/savephoto"
    case savenote = "v1/Animals/savenotes"
    case deletphoto = "v1/Animals/deletephoto"
    case getPhotoByAnimalId = "v1/Animals/photobyid" 
    case getnotes = "v1/Animals/notesbyid"
    case getAutopopulateAnimal = "v1/Animals/GetAnimalIdsByCustomer/"
    
  
    /// Result
    case resultMastrTemplate = "v1/defaults/ResultsMasterTemplate"
 
   

   
    case resultByPage  = "v1/results/bypage"
    case resultByindex  = "v1/results/byindex"
    case resultsByEarTagOrOfficial  = "v1/results/GetResultsByEarTagOrOfficial"
    case resultfilter  = "v1/results/filter"
    case resulttotalanimals = "v1/results/totalanimals"
    case resultbydate = "v1/results/bycustomer"
   
    // group
    case animalgroupsforcustomer = "v1/Groups/animalgroupsforcustomer"  //completed
    case deleteGroup = "v1/Groups/delete"      //completed
    case doesGroupExist = "v1/Groups/doesgroupexist"    //completed
    case emailMeGroup = "v1/Groups/emailgroup"     //completed
    case groupCreate  = "v1/Groups/create"        //completed
    case addAnimalGroup  = "v1/Groups/addanimals"
    case removeAnimalsGroup  = "v1/Groups/removeanimals"
    //i added
   // case savegroup = "v1/Groups/savegroup"
    case update = "v1/Groups/update"
  
  case orderSampleCollector = "v1/orders/samplecollectors"
  
    

}
