//
//  RequestDB.swift
//  FormDBAndWS
//
//  Created by Leonardo Flores Lopez on 22/01/21.
//

import UIKit
import RealmSwift

class RequestDB: Object {
    @objc dynamic public var url :String = ""
    @objc dynamic public var body:String = ""
    @objc dynamic public var type:String = ""
    @objc dynamic public var result:String = ""
    
    // MARK: -DB
    public static func saveDB(url :String, body:String, type:String, result: String ){
        let realm = try! Realm()
        let requestDB = RequestDB()
        
        requestDB.type = type
        requestDB.url = url
        requestDB.body = body
        requestDB.result = result
        
        do {
            try realm.write {
                realm.add(requestDB)
            }
        } catch {
            NSLog("DB error: \(String(describing: error))")
        }
    }
    
    
    public static func getRequestsDB(completion: @escaping (_ result: [RequestDB]?) -> Void){
        let realm = try! Realm()
        let requests = realm.objects(RequestDB.self).toArray(ofType: RequestDB.self)
        completion(requests)
    }
}
