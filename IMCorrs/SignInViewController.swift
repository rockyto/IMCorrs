//
//  SignInViewController.swift
//  IMCorrs
//
//  Created by Community Manager on 25/08/18.
//  Copyright © 2018 Expodiseno. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var folioTextField: UITextField!
    @IBOutlet weak var acceso: UIButton!
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    let status = UIImageView(image: UIImage(named: "banner"))
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NavBarImage()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(teclado(notificacion:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        spinner.frame = CGRect(x: -20.0, y:6.0, width:20.0, height:20.0)
        spinner.startAnimating()
        spinner.alpha = 0.0
        
        status.isHidden = true
        view.addSubview(status)
        status.addSubview(label)
        
        self.acceso.layer.cornerRadius = 5
   
    
         // campoPregunta.layer.cornerRadius = campoPregunta.bounds.width / 50
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func NavBarImage(){
        let navController = navigationController
        let image = #imageLiteral(resourceName: "logo_imcorrs.png")
        let imageView = UIImageView(image: image)
        let bannerWidth = navController?.navigationBar.frame.size.width
        let bannerHeight = navController?.navigationBar.frame.size.height
        let bannerX = bannerWidth! / 3 - image.size.width / 3
        let bannerY = bannerHeight! / 3 - image.size.width / 3
        imageView.frame = CGRect(x: bannerX, y:bannerY, width: bannerWidth!, height: bannerHeight!)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    
//    @objc func teclado(notificacion: Notification){
//
//        guard let tecladoUp = (notificacion.userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//            return
//        }
//
//        if notificacion.name == Notification.Name.UIKeyboardWillShow {
//            self.view.frame.origin.y = -100
//        }else{
//            self.view.frame.origin.y = 0
//        }
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func signInButtonTapped(sender: AnyObject){
        
        let folioParticipante = folioTextField.text
        
        if (folioParticipante?.isEmpty)! {
            
            let myAlert = UIAlertController(title: "Atención", message: "Favor de llenar campo requerido", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
            
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
            return
        }
        let spinningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        spinningActivity.label.text = "Verificando"
        spinningActivity.detailsLabel.text = "Espere por favor"
        
        //SEND HTTP POST
        let myURL = URL(string: "http://expodiseno.com/imcorrs/iOS/services/login.php")!
        let request = NSMutableURLRequest(url:myURL as URL)
        request.httpMethod = "POST"
        let postString = "folio=\(folioParticipante!)"
        
        //var request = NSMutableURLRequest (url: myURL)
        request.httpBody = postString.data(using: .utf8)
        

        URLSession.shared.dataTask(with: request as URLRequest, completionHandler:{ (data, response, error) in
        DispatchQueue.main.async{
       
        spinningActivity.hide(animated: true)
        
        if (error != nil)
        {
            let myAlert = UIAlertController(title: "Atención", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
            myAlert.addAction(okAction)
            self.present(myAlert, animated:true, completion:nil)
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
            
        }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        print("ejecutar accion")
        return true
    }

    }
