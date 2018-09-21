//
//  ConferenciaViewController.swift
//  IMCorrs
//
//  Created by Rockyto Sánchez on 20/9/18.
//  Copyright © 2018 Expodiseno. All rights reserved.
//

import UIKit

class ConferenciaViewController: UIViewController {
   
    
    @IBOutlet weak var lblDescripcion: UILabel!
    @IBOutlet weak var lblAutor: UILabel!
    @IBOutlet weak var lblEmpresa: UILabel!
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    let status = UIImageView(image: UIImage(named: "banner"))
    let label = UILabel()
    var descrpTemp = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.frame = CGRect(x: -20.0, y:6.0, width:20.0, height:20.0)
        spinner.startAnimating()
        spinner.alpha = 0.0
        
        status.isHidden = true
        view.addSubview(status)
        status.addSubview(label)
        
        conferenciaEnCurso()
          //let item: DetallePrograma = feedItems[indexPath.row] as! DetallePrograma

        // Do any additional setup after loading the view.
    }
    
    func conferenciaEnCurso(){
        
        let spinningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        spinningActivity.label.text = "Cargando"
        spinningActivity.detailsLabel.text = "Espere por favor"
        
        
        let enCurso = "1"
        let myURL = URL(string: "http://imcorrs.com/imcorrs-app/iOS/services/Conferencia.php")!
        let request = NSMutableURLRequest(url:myURL as URL)
        request.httpMethod = "POST"
        let postString = "enCurso=\(enCurso)"
        
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler:{ (data, response, error) in
            DispatchQueue.main.async{
                spinningActivity.hide(animated: true)
                let _:NSError?
                let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                if let parseJSON = json{
                
                UserDefaults.standard.set(parseJSON?["descripcion"], forKey: "descripcion")
                UserDefaults.standard.set(parseJSON?["autores"], forKey: "autores")
                UserDefaults.standard.set(parseJSON?["empresa_universidad"], forKey: "empresa_universidad")
                UserDefaults.standard.set(parseJSON?["descrpcion_ingles"], forKey: "descrpcion_ingles")
                UserDefaults.standard.synchronize()
                let descripcion = UserDefaults.standard.string(forKey: "descripcion")
                let autores = UserDefaults.standard.string(forKey: "autores")
                let empresa_universidad = UserDefaults.standard.string(forKey: "empresa_universidad")
                self.descrpTemp = descripcion!
                self.lblDescripcion.text = descripcion
                self.lblEmpresa.text = empresa_universidad
                self.lblAutor.text = autores
               
            }
            }
            }).resume()
    }
    
    @IBAction func btnRefresh(_ sender: Any) {
    
        conferenciaEnCurso()
    }
    override func viewWillAppear(_ animated: Bool) {

            conferenciaEnCurso()
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
