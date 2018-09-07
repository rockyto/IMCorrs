//
//  enviarQRViewController.swift
//  IMCorrs
//
//  Created by Community Manager on 05/09/18.
//  Copyright © 2018 Expodiseno. All rights reserved.
//

import UIKit

class enviarQRViewController: UIViewController {
var resFolioUser : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let spiningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        spiningActivity.label.text = "Verificando"
        spiningActivity.detailsLabel.text = "Espere por favor"
        
        let myURL = URL(string: "http://expodiseno.com/imcorrs/iOS/services/login.php")!
        let request = NSMutableURLRequest(url: myURL as URL)
        request.httpMethod = "POST"
        let postString = "folio=\(resFolioUser!)"
        //let postString = "folio=\(folioParticipante!)"
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            DispatchQueue.main.async {
                spiningActivity.hide(animated: true)
                if (error != nil){
                    let myAlert = UIAlertController(title: "Atención", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true, completion: nil)
                    return
                }
                let _:NSError?
                let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                if let parseJSON = json
                {
                    let userFolio = parseJSON?["folio"] as? String
                    if(userFolio != nil){
                        
                        UserDefaults.standard.set(parseJSON?["nombre"], forKey: "nombre")
                        UserDefaults.standard.set(parseJSON?["empresa_universidad"], forKey: "empresa_universidad")
                        UserDefaults.standard.set(parseJSON?["cargo_area"], forKey: "cargo_area")
                        UserDefaults.standard.set(parseJSON?["estatus"], forKey: "estatus")
                        UserDefaults.standard.set(parseJSON?["folio"], forKey: "folio")
                        UserDefaults.standard.synchronize()
                        let Perfil = (self.storyboard?.instantiateViewController(withIdentifier: "tabsRoot") as? UITabBarController)
                        let appDelegate = UIApplication.shared.delegate
                        
                        appDelegate?.window??.rootViewController = Perfil
                        
                    }else{
                        let userMessage = parseJSON? ["message"] as? String
                        let myAlert = UIAlertController(title: "Atención", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
                        myAlert.addAction(okAction)
                        self.present(myAlert, animated:true, completion:nil)
                        return
                    }
                    
                }
            }
        }).resume()
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
