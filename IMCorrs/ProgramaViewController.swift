//
//  ProgramaViewController.swift
//  
//
//  Created by Community Manager on 18/09/18.
//

import UIKit

class ProgramaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ProgramaModeloProtocol {
    
    var feedItems: NSArray = NSArray()
    var selectTema : DetallePrograma = DetallePrograma()
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet var lblIdioma: UILabel!
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    let status = UIImageView(image: UIImage(named: "banner"))
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.frame = CGRect(x: -20.0, y:6.0, width:20.0, height:20.0)
        spinner.startAnimating()
        spinner.alpha = 0.0
        status.isHidden = true
        view.addSubview(status)
        status.addSubview(label)
        
        
        let spinningActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        spinningActivity.label.text = "Cargando Programa"
        spinningActivity.detailsLabel.text = "Espere por favor"
        
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let programaModelo = ProgramaModelo()
        programaModelo.delegate = self
        programaModelo.downloadItems()
        
  
        if(ProgramaTableViewCell.self != nil){
            
            spinningActivity.hide(animated: true)
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let programaModelo = ProgramaModelo()
        programaModelo.delegate = self
        programaModelo.downloadItems()
        
    }
    
  
    
    func itemsDownloaded(items: NSArray) {
        feedItems = items
        self.listTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProgramaTableViewCell
        let item: DetallePrograma = feedItems[indexPath.row] as! DetallePrograma
        
        if (lblIdioma.text == "Español"){
            if (item.autores != nil){
                
                cell.lblHorario!.text = item.horario
                cell.lblDescripcion!.text = item.descripcion
                cell.lblAutores!.text = item.autores
            
            }else if (item.autores == nil){
                
              
                cell.isUserInteractionEnabled = false
                cell.lblHorario!.text = item.horario
                cell.lblDescripcion!.text = item.descripcion
                cell.lblAutores!.text = item.autores
            
            }
        }else if (lblIdioma.text == "English"){
            if (item.autores != nil){
                
                cell.lblHorario!.text = item.horario
                cell.lblDescripcion!.text = item.descrpcion_ingles
                cell.lblAutores!.text = item.autores
                
            }else if (item.autores == nil){
                
             
                cell.isUserInteractionEnabled = false
                cell.lblHorario!.text = item.horario
                cell.lblDescripcion!.text = item.descrpcion_ingles
                cell.lblAutores!.text = item.autores
                
            }
        }
        
        /*
        if (lblIdioma.text == "Español"){
            TituloProgress = "Verificando"
            subProgress = "Espere por favor"
        }else if (lblIdioma.text == "English"){
            TituloProgress = "Verifying"
            subProgress = "Wait please"
        }
        */
        
        
//        if (item.autores != nil){
//            cell.selectionStyle = .default
//            cell.lblHorario!.text = item.horario
//            cell.lblDescripcion!.text = item.descripcion
//            cell.lblAutores!.text = item.autores
//        }else{
//            cell.selectionStyle = .none
//
//            cell.isUserInteractionEnabled = false
//            cell.lblHorario!.text = item.horario
//            cell.lblDescripcion!.text = item.descripcion
//            cell.lblAutores!.text = item.autores
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
       // let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProgramaTableViewCell
        let detail:programaDetallesViewController = self.storyboard?.instantiateViewController(withIdentifier: "detallesPrograma") as! programaDetallesViewController
        let item: DetallePrograma = feedItems[indexPath.row] as! DetallePrograma
       
        
        
        
        if (lblIdioma.text == "Español"){
            detail.selectHorario = item.horario!
            detail.selectDescrp = item.descripcion!
            detail.selectAutor = item.autores!
            self.navigationController?.pushViewController(detail, animated: true)
        }else if (lblIdioma.text == "English"){
            detail.selectHorario = item.horario!
            detail.selectDescrp = item.descrpcion_ingles!
            detail.selectAutor = item.autores!
            self.navigationController?.pushViewController(detail, animated: true)
        }
      
        

        
      
        
        
        
    
    }
    
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Set selected location to var
     
        selectedLocation = feedItems[indexPath.row] as! LocationModel
     
        // Manually call segue to detail view controller
        self.performSegue(withIdentifier: "detailSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get reference to the destination view controller
        let detailVC  = segue.destination as! DetailViewController
        // Set the property to the selected location so when the view for
        // detail view controller loads, it can access that property to get the feeditem obj
        detailVC.selectedLocation = selectedLocation
    }
     */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
