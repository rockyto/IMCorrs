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
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        self.autorPregunta = participanteNombre!
        print(autorPregunta)
        campoPregunta.layer.cornerRadius = campoPregunta.bounds.width / 50
       
        ref = Database.database().reference()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func switchAnonimo(_ sender: UISwitch) {
        if(sender.isOn == true){
            self.autorPregunta = "Anónimo"
            print(autorPregunta)
        }else{
            self.autorPregunta = participanteNombre!
            print(autorPregunta)
        }
        
    }
    
    
    @objc func teclado(notificacion: Notification){
        guard let tecladoUp = (notificacion.userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        if notificacion.name == Notification.Name.UIKeyboardWillShow{
            self.view.frame.origin.y = -100
        }else{
            self.view.frame.origin.y = 0
        }
    }
    
    
    @IBAction func enviarPregunta(_ sender: UIBarButtonItem){
        //let Pregunta = campoPregunta.text
        
        
        if (campoPregunta.text?.isEmpty)!{
            let myAlert = UIAlertController(title: "Atención", message: "Favor de llenar el campo requerido",  preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
            return
        }
        
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        print("ejecutar accion")
        return true
    }

}
