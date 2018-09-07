//
//  ScanQRViewController.swift
//  IMCorrs
//
//  Created by Rockyto Sánchez on 5/9/18.
//  Copyright © 2018 Expodiseno. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class ScanQRViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var scaneoQR: UIView!
    var stringFolio = String()
    let sesion = AVCaptureSession()
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    // var player: AVAudioPlayer = AVAudioPlayer()
    var player: AVAudioPlayer?


    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.frame = CGRect(x: -20.0, y:6.0, width:20.0, height:20.0)
        spinner.startAnimating()
        spinner.alpha = 0.0
        
        scanner()
        // Do any additional setup after loading the view.
    }
    func scanner(){
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return}
        
        guard let input = try? AVCaptureDeviceInput(device: device) else { return }
        
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        sesion.addInput(input)
        sesion.addOutput(output)
        
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        let preview = AVCaptureVideoPreviewLayer(session: sesion)
        preview.videoGravity = AVLayerVideoGravity.resizeAspectFill
        preview.frame = scaneoQR.bounds
        scaneoQR.layer.addSublayer(preview)
        sesion.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        sesion.stopRunning()
        if metadataObjects.count > 0 {
            let machine = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            if machine.type == AVMetadataObject.ObjectType.qr {
                
                stringFolio = machine.stringValue!
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            
                //AudioServicesPlaySystemSound(SystemSoundID(1057))
                
                
                //intenta reproducir sonido
                let audioPath = Bundle.main.path(forResource: "touchID.mp3", ofType: nil)
                let urlMP3 = URL(fileURLWithPath: audioPath!)
                do{
                    player = try AVAudioPlayer(contentsOf: urlMP3)
                    player?.play()
                }catch{
                    
                }
                
                
                
                performSegue(withIdentifier: "enviar", sender: self)
                /*
                let spiningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
                spiningActivity.label.text = "Verificando"
                spiningActivity.detailsLabel.text = "Espere por favor"
                
                let myURL = URL(string: "http://expodiseno.com/imcorrs/iOS/services/login.php")!
                let request = NSMutableURLRequest(url: myURL as URL)
                request.httpMethod = "POST"
                let postString = "folio\(stringFolio)"
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
                }).resume()*/
                // performSegue(withIdentifier: "enviar", sender: self)
            }
        }
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enviar" {
            let destino = segue.destination as! enviarQRViewController
            destino.resFolioUser = stringFolio
            //destino.resString = stringURL
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if sesion.isRunning == false{
            sesion.startRunning()
        }
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
