//
//  PreguntasViewController.swift
//  IMCorrs
//
//  Created by Community Manager on 06/09/18.
//  Copyright © 2018 Expodiseno. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class PreguntasViewController: UIViewController {
    
  
    @IBOutlet weak var lblPregunta: UILabel!
    @IBOutlet weak var campoPregunta: UITextView!
    var ref: DatabaseReference!
    var idFirebase = "preguntas_val"
    var estatusPregunta = "0"
    var autorPregunta = ""
    let participanteNombre = UserDefaults.standard.string(forKey: "nombre")
    
    override func viewDidLoad() {
        
        self.autorPregunta = participanteNombre!
        print(autorPregunta)
        campoPregunta.layer.cornerRadius = campoPregunta.bounds.width / 50
       
        ref = Database.database().reference()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func switchAnonimo(_ sender: UISwitch) {
        if(sender.isOn == true){
            self.autorPregunta = "Áninimo"
            print(autorPregunta)
        }else{
            self.autorPregunta = participanteNombre!
            print(autorPregunta)
        }
        
    }
    
    
    
    @IBAction func enviarPregunta(_ sender: UIBarButtonItem){
        let id = ref.childByAutoId().key
        let preguntas_val = ["estatus": estatusPregunta,
                        "mensaje": campoPregunta.text,
                        "nombre": autorPregunta as String] as [String : Any]

        ref.child(idFirebase).child(id).setValue(preguntas_val)

        print("enviado")
        self.lblPregunta.text = campoPregunta.text
        self.campoPregunta.text = ""
        print(autorPregunta)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
