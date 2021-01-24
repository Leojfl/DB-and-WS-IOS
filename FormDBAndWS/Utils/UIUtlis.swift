//
//  UIUtlis.swift
//  FormDBAndWS
//
//  Created by Leonardo Flores Lopez on 22/01/21.
//

import UIKit

class UIUtils{
    private static var vc: UIViewController?
    
    public static func showDialog(controller: UIViewController){
        if vc == nil {
            let storyboard = UIStoryboard(name: "Commons", bundle: nil)
            vc = storyboard.instantiateViewController(withIdentifier: "ProgressDialogViewController")
            controller.navigationController?.present(vc!, animated: true)
        }
    }
    
    public static func hidenDialog(){
        vc?.dismiss(animated: true)
    }
   
    public static func showAlert(controller: UIViewController, title: String, message: String, btnOKString: String = "Aceptar", handler: ((UIAlertAction) -> Void)? = nil){
    
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btnOKString, style: UIAlertAction.Style.default, handler: handler))
        controller.navigationController?.present(alert, animated: true, completion: nil)
        
    }
    public static func showAlert(controller: UIViewController, title: String, message: String , btnOKString: String = "Aceptar", btnCancelString: String = "Cancelar", handlerOK: @escaping ((UIAlertAction) -> Void)){
    
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btnOKString, style: UIAlertAction.Style.default, handler: handlerOK))
        alert.addAction(UIAlertAction(title: btnCancelString, style: UIAlertAction.Style.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
        
    }
    
    public static func setupNavigationBar(_ navigationBar: UINavigationBar) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        if #available(iOS 11.0, *) {
            navigationBar.backgroundColor =  UIColor(named: "Purple")!
        } else {
            navigationBar.backgroundColor =  #colorLiteral(red: 0.4791333079, green: 0.2467545271, blue: 0.9959545732, alpha: 1)
        }
            
    }
    
    static func setupStatusBar(color: UIColor = UIColor.clear){
        if #available(iOS 13.0, *) {
            let tag = 3848245
            let keyWindow = UIApplication.shared.connectedScenes
              .map({$0 as? UIWindowScene})
              .compactMap({$0})
              .first?.windows.first

            if let statusBar = keyWindow?.viewWithTag(tag) {
                statusBar.backgroundColor = color
            } else {
                let height = keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
                let statusBarView = UIView(frame: height)
                statusBarView.tag = tag
                statusBarView.layer.zPosition = 999999

                keyWindow?.addSubview(statusBarView)
                statusBarView.backgroundColor = color
            }
        } else {
           let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            statusBar.backgroundColor = color
        }
    }
    
}
