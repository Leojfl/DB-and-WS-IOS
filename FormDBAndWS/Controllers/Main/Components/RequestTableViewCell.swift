//
//  RequestTableViewCell.swift
//  FormDBAndWS
//
//  Created by Leonardo Flores Lopez on 23/01/21.
//

import UIKit

class RequestTableViewCell: UITableViewCell {

    @IBOutlet weak var lblUrl: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblBody: UILabel!
    @IBOutlet weak var lblResult: UILabel!

    public func setupUI(request: RequestDB){
        lblUrl.text = request.url
        lblType.text = request.type
        lblBody.text = request.body
        lblResult.text = request.result
        
    }
    
    
}
