//
//  Constants.swift
//  FormDBAndWS
//
//  Created by Leonardo Flores Lopez on 22/01/21.
//
/*
 
 "Apellidos": "Valencia",
 "Correo_Electronico": "juanaperezmmm1@hotmail.com",
 "Edad": "39",
 "Estatura": "1.8",
 "Genero_ID": "1",
 "IMC": "0",
 "Nombre": "Usnavy Marina",
 "Nombre_Usuario": "Juanamm1",
 "Peso": "60",
 */


import UIKit

class Constants {
    
    private static let production:  Bool = false
    private static let urlDev:      String = "http://187.188.122.85:8091/"
    private static let urlProd:     String = "http://187.188.122.85:8091/"
    
    public static func getUrl() -> String {
        if production {
            return urlDev
        }
        return urlProd
    }

}
