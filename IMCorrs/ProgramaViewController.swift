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
        
        if (item.autores != nil){
            cell.selectionStyle = .default
            cell.lblHorario!.text = item.horario
            cell.lblDescripcion!.text = item.descripcion
            cell.lblAutores!.text = item.autores
        }else{
            cell.selectionStyle = .none
            cell.lblHorario!.text = item.horario
            cell.lblDescripcion!.text = item.descripcion
            cell.lblAutores!.text = item.autores
        }
        
        return cell
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
