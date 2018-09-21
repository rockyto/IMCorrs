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
    var descrpcion_ingles: String?
    var conferencia: String?
    var estado: String?
    var dia: String?

    
    override init() {
        
    }
    init(horario: String, descripcion: String, descrpcion_ingles: String, autores: String, empresa_universidad: String, conferencia: String, estado: String, dia: String) {
        
        self.horario = horario
        self.descripcion = descripcion
        self.autores = autores
        self.descrpcion_ingles = descrpcion_ingles
        self.empresa_universidad = empresa_universidad
        self.conferencia = conferencia
        self.estado = estado
        self.dia = dia
        
    }
    
    override var description: String{
        
        return "horario: \(horario), descripcion: \(descripcion), autores:\(autores), empresa_universidad: \(empresa_universidad), descrpcion_ingles: \(descrpcion_ingles), conferencia: \(conferencia), estado: \(estado), dia: \(dia)"
    }
    
}
