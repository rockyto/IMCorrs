//
//  programaDetallesViewController.swift
//  IMCorrs
//
//  Created by Community Manager on 21/09/18.
//  Copyright © 2018 Expodiseno. All rights reserved.
//

import UIKit

class programaDetallesViewController: UIViewController {

    @IBOutlet weak var lblHorarioSelect: UILabel!
    @IBOutlet weak var lblDescrpSelect: UILabel!
    @IBOutlet weak var lblAutorSelect: UILabel!
    @IBOutlet weak var textDescrpCompleta: UITextView!
    
    var selectHorario = ""
    var selectAutor = ""
    var selectDescrp = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        lblHorarioSelect.text = selectHorario
        lblAutorSelect.text = selectAutor
        lblDescrpSelect.text = selectDescrp
     
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        /*
        var poiCoodinates = CLLocationCoordinate2D()
        
        poiCoodinates.latitude = CDouble(self.selectedLocation!.latitude!)!
        poiCoodinates.longitude = CDouble(self.selectedLocation!.longitude!)!
  
        let viewRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(poiCoodinates, 750, 750)
        self.mapView.setRegion(viewRegion, animated: true)
     
        let pin: MKPointAnnotation = MKPointAnnotation()
        pin.coordinate = poiCoodinates
        self.mapView.addAnnotation(pin)
     
        pin.title = selectedLocation!.name
        */
        
        
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
