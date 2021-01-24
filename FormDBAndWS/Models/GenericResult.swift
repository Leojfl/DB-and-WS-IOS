//
//  GenericResult.swift
//  FormDBAndWS
//
//  Created by Leonardo Flores Lopez on 22/01/21.
//

import ObjectMapper

class GenericResult: Mappable {
    var code              : Int64    = 0
    var message           : String   = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        code              <- map["Cve_Mensaje"]
        message           <- map["Mensaje"]
    }

}
