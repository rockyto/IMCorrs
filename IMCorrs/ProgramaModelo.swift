//
//  ProgramaModelo.swift
//  IMCorrs
//
//  Created by Rockyto Sánchez on 15/9/18.
//  Copyright © 2018 Rockyto Sánchez. All rights reserved.
//

import UIKit
protocol ProgramaModeloProtocol: class {
    func itemsDownloaded (items: NSArray)
}

class ProgramaModelo: NSObject {
    
    weak var delegate: ProgramaModeloProtocol!
    let urlPath = "http://imcorrs.com/imcorrs-app/iOS/services/loadProgram.php?idioma=es"
    func downloadItems() {
        let url: URL = URL (string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url){
            (data, response, error) in
            if error != nil{
                print("Error al descargar datos")
            }else{
                print("Datos descargados")
                self.parseJSON(data!)
            }
        }
        task.resume()
    }
    func parseJSON(_ data:Data){
        var jsonResult = NSArray()
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        }catch let error as NSError{
            print(error)
        }
        var jsonElement = NSDictionary()
        let detalles = NSMutableArray()
        for i in 0 ..< jsonResult.count
        {
            jsonElement = jsonResult[i] as! NSDictionary
            let detalle = DetallePrograma()
            
/*
            var horario: String?
            var descripcion: String?
            var autores: String?
            var empresa_universidad: String?
            var descrpcion_ingles: String?
            var conferencia: String?
            var estado: String?
            var dia: String?
            UserDefaults.standard.set(jsonElement["horario"], forKey: "horario")
            UserDefaults.standard.set(jsonElement["descripcion"], forKey: "descripcion")
            UserDefaults.standard.set(jsonElement["autores"], forKey: "autores")
            UserDefaults.standard.set(jsonElement["empresa_universidad"], forKey: "empresa_universidad")
           UserDefaults.standard.synchronize()
*/


            let horario = jsonElement["horario"]
            let descripcion = jsonElement["descripcion"]
            let autores = jsonElement["autores"]
            let empresa_universidad = jsonElement["empresa_universidad"]
            let descrpcion_ingles = jsonElement["descrpcion_ingles"]
            let conferencia = jsonElement["conferencia"]
            let estado = jsonElement["estado"]
            let dia = jsonElement["dia"]
            
            
            detalle.horario = horario as? String
            detalle.descripcion = descripcion as? String
            detalle.descrpcion_ingles = descrpcion_ingles as? String
            detalle.autores = autores as? String
            detalle.empresa_universidad = empresa_universidad as? String
            detalle.conferencia = conferencia as? String
            detalle.estado = estado as? String
            detalle.dia = dia as? String
            
            detalles.add(detalle)
        }
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: detalles)
            
        })
    }
}
