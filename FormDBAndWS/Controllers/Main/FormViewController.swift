//
//  FormViewController.swift
//  FormDBAndWS
//
//  Created by Leonardo Flores Lopez on 22/01/21.
//

import UIKit

class FormViewController: UIViewController {

    @IBOutlet weak var tfName: MDCTextFieldCustom!
    @IBOutlet weak var tfLastName: MDCTextFieldCustom!
    @IBOutlet weak var tfEmail: MDCTextFieldCustom!
    @IBOutlet weak var tfAge: MDCTextFieldCustom!
    @IBOutlet weak var scGender: UISegmentedControl!
    @IBOutlet weak var tfWeight: MDCTextFieldCustom!
    @IBOutlet weak var tfHeight: MDCTextFieldCustom!
    
    public var person: Person?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
    @IBAction func onClickSave(_ sender: Any) {
        if isValid() {
            UIUtils.showDialog(controller: self)
            
            if person == nil {
                saveNewPerson()
            }else{
                updatePerson()
            }
            
            
        }
    }
    
    private func setupUI(){
        tfName.setLeftIcon(#imageLiteral(resourceName: "ic_user"))
        tfLastName.setLeftIcon(#imageLiteral(resourceName: "ic_user"))
        tfEmail.setLeftIcon(#imageLiteral(resourceName: "ic_email"))
        tfAge.setLeftIcon(#imageLiteral(resourceName: "ic_calendar"))
        tfWeight.setLeftIcon(#imageLiteral(resourceName: "ic_person"))
        tfHeight.setLeftIcon(#imageLiteral(resourceName: "ic_height"))
        
        if let person = person {
            tfName.text = person.getName()
            tfLastName.text = person.getLastName()
            tfEmail.text = person.getEmail()
            tfAge.text = "\(person.getAge())"
            tfWeight.text = "\(person.getWeight())"
            tfHeight.text = "\(person.getHeight())"
        }
        
    }
    
    private func isValid() -> Bool{
        var isValid: Bool = true
        isValid = tfName.required(error: "El nombre es requerido") && isValid
        isValid = tfLastName.required(error: "El apellido paterno es requerido") && isValid
        isValid = tfEmail.required(error: "El correo es requerido") && isValid
        isValid = tfEmail.email(error: "Correo no válido") && isValid
        isValid = tfAge.required(error: "La edad es requerido") && isValid
        isValid = tfAge.int(error: "Edad no válida") && isValid
        isValid = tfWeight.required(error: "El peso es requerido") && isValid
        isValid = tfWeight.double(error: "Peso no válido") && isValid
        isValid = tfHeight.required(error: "La altura es requerido") && isValid
        isValid = tfHeight.double(error: "Altura no válida") && isValid
        return isValid
    }
    
    private func clearTextFields(){
        tfName.text = ""
        tfLastName.text = ""
        tfEmail.text = ""
        tfAge.text = ""
        tfWeight.text = ""
        tfHeight.text = ""
    }
    
    private func saveNewPerson(){
        
        let selectSegment = scGender.selectedSegmentIndex + 1
        
        let person = Person(
            name: tfName.text!,
            lastName: tfLastName.text!,
            email: tfEmail.text!,
            age: Int16(tfAge.text!)!,
            gender: selectSegment,
            weight: Double(tfWeight.text!)!,
            height: Double(tfHeight.text!)!
        )
        
        
        Person.saveWS(person: person) { (result) in
            
            if result == nil{
                UIUtils.hidenDialog()
                UIUtils.showAlert(controller: self, title: "Error", message: "Por el momento no se puede conectar con el servidor, intente más tarde")
                return
            }
            
            if result!.code < 0{
                UIUtils.hidenDialog()
                UIUtils.showAlert(controller: self, title: "Error", message: result!.message)
                return
            }
            person.setId(id: result!.code)
            
            Person.saveDB(person: person) { (result) in
                UIUtils.hidenDialog()
                if result == nil || result!.code < 0{
                    UIUtils.showAlert(controller: self, title: "Error", message: "Por el momento no se puede guardar la información de manera local")
                    return
                }
                self.clearTextFields()
                UIUtils.showAlert(controller: self, title: "Correcto", message: "Información guardada con exito")
            }
            
        }
    }
    
    
    private func updatePerson(){
        
        let selectSegment = scGender.selectedSegmentIndex + 1
        
        person!.setName( name: tfName.text!)
        person!.setLastName( lastName: tfLastName.text!)
        person!.setEmail( email: tfEmail.text!)
        person!.setAge( age: Int16(tfAge.text!)!)
        person!.setGender( gender: selectSegment)
        person!.setWeight( weight: Double(tfWeight.text!)!)
        person!.setHeight( height: Double(tfHeight.text!)!)
        
        
        Person.updateWS(person: person!) { (result) in
            
            if result == nil{
                UIUtils.hidenDialog()
                UIUtils.showAlert(controller: self, title: "Error", message: "Por el momento no se puede conectar con el servidor, intente más tarde")
                return
            }
            
            if result!.code < 0 {
                UIUtils.hidenDialog()
                UIUtils.showAlert(controller: self, title: "Error", message: result!.message)
                return
            }
            
            UIUtils.showAlert(controller: self, title: "Correcto", message: "Información guardada con exito"){ _ in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
}
