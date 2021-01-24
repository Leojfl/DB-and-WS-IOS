//
//  Person.swift
//  FormDBAndWS
//
//  Created by Leonardo Flores Lopez on 22/01/21.
//

import UIKit
import ObjectMapper
import RealmSwift

class Person: Object, Mappable {
    
    @objc dynamic private var id:             Int64  = 0
    @objc dynamic private var name:           String = ""
    @objc dynamic private var lastName:       String = ""
    @objc dynamic private var email:          String = ""
    @objc dynamic private var age:            Int16  = 0
    @objc dynamic private var nss:            String?
    @objc dynamic private var gender:               Int = 1
    @objc dynamic private var weight:         Double = 0.0
    @objc dynamic private var height:         Double = 0.0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    
    init(name: String, lastName: String, email: String, age: Int16, gender: Int, weight: Double, height: Double) {
        
        self.name = name
        self.lastName = lastName
        self.email = email
        self.age = age
        self.gender = gender
        self.weight = weight
        self.height = height
        self.nss = Self.generateNSS()
        super.init()
    }
    
    required  override init() {
       super.init()
   }
    
    public func toJson() -> [String: Any]{
        return [
            "Nombre" : self.name,
            "Apellidos" : self.lastName,
            "Correo_Electronico" : self.email,
            "Edad" : self.age,
            "Genero_ID" : self.gender,
            "Peso" : self.weight,
            "Estatura" : self.height,
            "Nombre_Usuario" : self.nss!,
            "IMC": self.getIMC(),
            "Contraseña": self.nss!,
        ]
    }

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.id   <- map["Cliente_ID"]
        self.name <- map["Nombre"]
        self.lastName <- map["Apellidos"]
        self.email <- map["Correo_Electronico"]
        self.age <- map["Edad"]
        self.gender <- map["Genero_ID"]
        self.weight <- map["Peso"]
        self.height <- map["Estatura"]
        self.nss <- map["Nombre_Usuario"]
        self.nss <- map["Contraseña"]
    }
    
    //MARK: - getters and setters
    public func getId() -> Int64{
        return id
    }
    
    public func setId(id: Int64){
        self.id = id
    }
    public func getName() -> String{
        return name
    }
    
    public func setName(name: String){
        self.name = name
    }
    
    public func getLastName() -> String{
        return lastName
    }
    
    public func setLastName(lastName: String){
        self.lastName = lastName
    }
    
    public func getEmail() -> String{
        return email
    }
    
    public func setEmail(email: String){
        self.email = email
    }
    
    
    public func getAge() -> Int16 {
        return age
    }
    
    
    public func setAge(age: Int16) {
        self.age = age
    }
    
    public func getNSS() -> String? {
        return self.nss
    }
    
    public func getGender() -> Int{
        return gender
    }
    
    public func getGenderText() -> String{
        var gender = ""
        
        switch self.gender {
        case Gender.male:
            gender = "Hombre"
        case Gender.female:
            gender = "Mujer"
        default:
            print("Gender not support \(gender)")
        }
        
        return gender
    }
    
    
    public func setGender( gender: Int){
        self.gender = gender
    }
    
    
    public func getWeight() -> Double{
        return weight
    }
    
    public func setWeight( weight: Double) {
        self.weight = weight
    }
    
    public func getHeight() -> Double{
        return height
    }
    
    public func setHeight(height: Double) {
        self.height = height
    }
    
    //MARK: - Funtions
    public func getIMC() -> Double{
       return self.weight / pow(height, 2)
    }
    
    
    public func isAdult() -> Bool {
        return self.age >= 18
    }
    
    public static func generateNSS()-> String{
        return String.randomString(size: 8)
    }
    
    public func calculeIMC() -> Int {
        
        let imc = getIMC()
        
        var minWeight: Double = 0
        var maxWeight: Double = 0
        
        switch gender {
        case Gender.male:
            minWeight = 20
            maxWeight = 25
            break
        case Gender.female:
            minWeight = 19
            maxWeight = 24
            break
        default:
            print("Error gender no support \(gender) ")
        }
        
        var result = -1
        
        if imc < minWeight {
            result = -1
        }
        
        if imc >= minWeight && imc <= maxWeight {
            result = 0
        }
        
        if imc > maxWeight {
            result = 1
        }
        
        return result
    }
    
    public func isCorrectGender (gender: Int
    ) -> Bool{
        return self.gender == gender
    }
    
    public func getResultIMC() -> String {
        
        let result = calculeIMC()
        var resultText = ""
        
        if result < 0 {
            resultText = "Falta de peso "
        }
        
        if result == 0 {
            resultText = "Peso normal"
        }
        if result > 0 {
            resultText = "Sobrepeso"
        }
        return resultText
    }
    
    
    // MARK: -WS
    
    public static func saveWS(person: Person, completion: @escaping (_ result: GenericResult?) -> Void){
        Api.savePersonWS(person: person, completion: completion)
    }
    
    
    public static func getPeopleWS(completion: @escaping (_ result: [Person]?) -> Void){
        Api.getPeople(completion: completion)
    }
    
    public static func updateWS(person: Person, completion: @escaping (_ result: GenericResult?) -> Void){
        Api.updatePersonWS(person: person, completion: completion)
    }
    
    
    // MARK: -DB
    public static func saveDB(person: Person, completion: @escaping (_ result: GenericResult?) -> Void){
        let realm = try! Realm()
        let genericResult: GenericResult = GenericResult(JSON: [
            "Cve_Mensaje": -1,
            "Mensaje": ""
        ])!
        
        do {
            try realm.write {
                realm.add(person)
                genericResult.code = 1
                completion(genericResult)
                return
            }
        } catch {
            NSLog("DB error: \(String(describing: error))")
            completion(genericResult)
        }
    }
    
    
    public static func getPeopleDB(completion: @escaping (_ result: [Person]?) -> Void){
        let realm = try! Realm()
        let people = realm.objects(Person.self).toArray(ofType: Person.self)
        completion(people)
    }
}


