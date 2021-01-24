//
//  Api.swift
//  FormDBAndWS
//
//  Created by Leonardo Flores Lopez on 22/01/21.
//

import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class Api {
    
    
    public static func savePersonWS(person: Person, completion: @escaping (_ result: GenericResult?) -> Void){
        let url = "\(Constants.getUrl())/NutriNET/Cliente"
        Api.requestPost(url: url, object: person.toJson(), completion: completion)
    }
    
    public static func getPeople(completion: @escaping (_ result: [Person]?) -> Void){
        let url = "\(Constants.getUrl())/NutriNET/Cliente"
        Api.requestGet(url: url,  completion: completion)
    }
    
    public static func updatePersonWS(person: Person, completion: @escaping (_ result: GenericResult?) -> Void){
        let url = "\(Constants.getUrl())/NutriNET/Cliente/\(person.getId())"
        Api.requestPut(url: url, object: person.toJson(), completion: completion)
    }
    
    
    // MARK: Request functions
    private static func requestGet<T>(url: String, completion: @escaping (_ data: [T]?) -> Void) where T: Mappable {
        AF.request(url, method: .get).responseArray { (response: DataResponse<[T], AFError>) in
            
            var result = response.description
            
            if response.error != nil {
                NSLog("API error: \(String(describing: response.error))")
                completion(nil)
            } else {
                result = "\(result) \n \(String(describing: response.value!.toJSONString()))"
                completion(response.value!)
            }
            RequestDB.saveDB(url: url, body: "", type: "GET", result: response.description)
        }
    }
    private static func requestPost<T>(url: String, object: [String: Any]?, completion: @escaping (_ response: T?) -> Void) where T: Mappable {
        AF.request(url, method: .post, parameters: object, encoding: JSONEncoding.default,
                   headers: [
                   "Content-Type": "text/plain"
                   ]).responseArray { (response: DataResponse<[T], AFError>) in
                    
                    var result = response.description
                    
                   
                    
                    if response.error != nil {
                        NSLog("API error: \(String(describing: response.error))")
                        completion(nil)
                    } else {
                        result = "\(result) \n \(String(describing: response.value!.toJSONString()))"
                        completion(response.value![0])
                    }
                    
                    RequestDB.saveDB(url: url, body: object?.description ?? "", type: "POST", result: result )
                }
            
    }
    
    private static func requestPut<T>(url: String, object: [String: Any]?, completion: @escaping (_ response: T?) -> Void) where T: Mappable {
        AF.request(url, method: .put, parameters: object, encoding: JSONEncoding.default,
                   headers: [
                   "Content-Type": "text/plain"
                   ]).responseArray { (response: DataResponse<[T], AFError>) in
                    
                    var result = response.description
                    
                   
                    
                    if response.error != nil {
                        NSLog("API error: \(String(describing: response.error))")
                        completion(nil)
                    } else {
                        result = "\(result) \n \(String(describing: response.value![0].toJSONString()))"
                        completion(response.value![0])
                    }
                    
                    RequestDB.saveDB(url: url, body: object?.description ?? "", type: "PUT", result: result )
                }
            
    }
    
}
