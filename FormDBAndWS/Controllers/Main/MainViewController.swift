//
//  MainViewController.swift
//  FormDBAndWS
//
//  Created by Leonardo Flores Lopez on 22/01/21.
//

import UIKit

class MainViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        
        delegate = self
        
        let vcForm = makeNavegationController(vienController: "FormViewController",
                                              title: "Formulario", icon: #imageLiteral(resourceName: "ic_form"))
        
        let vcPeoplesWSList = makeNavegationController(vienController: "PeopleListWSViewController",
                                                       title: "Lista WS", icon: #imageLiteral(resourceName: "ic_ws"))
        
        let vcPeoplesDBList = makeNavegationController(vienController: "PeopleListDBViewController",
                                                       title: "Lista DB", icon: #imageLiteral(resourceName: "ic_db"))
        
        let vcRequestList = makeNavegationController(vienController: "RequestListViewController",
                                                       title: "Peticiones", icon: #imageLiteral(resourceName: "ic_chart"))
        self.tabBar.tintColor = UIColor(named: "StrongBlue")
        viewControllers = [
            vcForm,
            vcPeoplesWSList,
            vcPeoplesDBList,
            vcRequestList
        ]
        
    }
    
    private func makeNavegationController(storiboard: String = "Main", vienController: String, title: String, icon: UIImage?) -> UINavigationController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: vienController)
        vc.title = title
        vc.tabBarItem.image = icon
        
        let uiNavegation = UINavigationController(rootViewController: vc)
        return uiNavegation
        
    }
    
}
