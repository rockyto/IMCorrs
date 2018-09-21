//
//  perfildelParticipante.swift
//  IMCorrs
//
//  Created by Community Manager on 30/08/18.
//  Copyright © 2018 Expodiseno. All rights reserved.
//

import UIKit

class perfildelParticipante: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate {

    @IBOutlet weak var folioParticipanteLabel: UILabel!
    @IBOutlet weak var nombreParticipanteLabel: UILabel!
    @IBOutlet weak var empresaParticipanteLabel: UILabel!
    @IBOutlet weak var cargoParticipanteLabel: UILabel!
    @IBOutlet weak var imagenFolioParticipante: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    super.viewWillDisappear(animated)
    let participanteFolio = UserDefaults.standard.string(forKey: "folio")
    let participanteNombre = UserDefaults.standard.string(forKey: "nombre")
    let participanteEmpresa = UserDefaults.standard.string(forKey: "empresa_universidad")
    let participanteCargo = UserDefaults.standard.string(forKey: "cargo_area")
    
    nombreParticipanteLabel.text = participanteNombre
    empresaParticipanteLabel.text = participanteEmpresa
    cargoParticipanteLabel.text = participanteCargo
    folioParticipanteLabel.text = participanteFolio
    
    
        
    //let FolioQR = participanteFolio.data(using: .ascii, allowLossyConversion: false)
    
    let datoFolio = participanteFolio?.data(using: .ascii, allowLossyConversion: false)
    
    let filter = CIFilter(name: "CIQRCodeGenerator")
    filter?.setValue(datoFolio, forKey: "inputMessage")
        
    let transform = CGAffineTransform(scaleX: 10, y: 10)
    let imagen = UIImage(ciImage: (filter?.outputImage!.transformed(by: transform))!)
    imagenFolioParticipante.image = imagen
    
    }
    @IBAction func botonSalir(_ sender: Any) {
    
    UserDefaults.standard.removeObject(forKey: "folio")
    UserDefaults.standard.removeObject(forKey: "nombre")
    UserDefaults.standard.removeObject(forKey: "empresa_universidad")
    UserDefaults.standard.removeObject(forKey: "cargo_area")
    UserDefaults.standard.removeObject(forKey: "estatus")
    
    let signInPage = (self.storyboard?.instantiateViewController(withIdentifier: "signInViewController") as? UINavigationController)
    
 
    let appDelegado = UIApplication.shared.delegate
        appDelegado?.window??.rootViewController = signInPage
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
