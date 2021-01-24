//
//  PersonTableViewCell.swift
//  FormDBAndWS
//
//  Created by Leonardo Flores Lopez on 23/01/21.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblNSS: UILabel!
    @IBOutlet weak var lblIMC: UILabel!
    @IBOutlet weak var lblResultIMC: UILabel!
    
    
    

    public func setupUI(person: Person){

        lblId.text = "\(person.getId())"
        lblLastName.text = person.getLastName()
        lblEmail.text = person.getEmail()
        lblAge.text = "\(person.getAge())"
        lblGender.text = person.getGenderText()
        lblWeight.text = "\(person.getWeight())"
        lblHeight.text = "\(person.getHeight())"
        lblNSS.text = person.getNSS()
        lblIMC.text = "\(person.getIMC())"
        lblResultIMC.text = person.getResultIMC()
        
    }
    
}
