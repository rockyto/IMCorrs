//
//  DetallesPrograma.swift
//  IMCorrs
//
//  Created by Community Manager on 18/09/18.
//  Copyright © 2018 Expodiseno. All rights reserved.
//

import UIKit
class DetallePrograma: NSObject {
    
    
    var horario: String?
    var descripcion: String?
    var autores: String?
    var empresa_universidad: String?
    override init() {
        
    }
    init(horario: String, descripcion: String, autores: String, empresa_universidad: String) {
        
        self.horario = horario
        self.descripcion = descripcion
        self.autores = autores
        self.empresa_universidad = empresa_universidad
        
        
    }
    
    override var description: String{
        
        //return "descripcion: \(descripcion), horario: \(horario), empresa_universidad: \(empresa_universidad), autores:\(autores)"
        return "horario: \(horario), descripcion: \(descripcion), autores:\(autores), empresa_universidad: \(empresa_universidad)"
    }
    
}
