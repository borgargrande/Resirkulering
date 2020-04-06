//
//  ShowInfoViewController.swift
//  Resirkulering
//
//  Created by Borgar Grande on 06/03/2020.
//  Copyright © 2020 Borgar Grande. All rights reserved.
//

import UIKit
import MapKit
class ShowInfoViewController: UIViewController {
    
    
    @IBOutlet weak var backButtonOutlet: UIButton!
    @IBOutlet weak var registerButtonOutlet: UIButton!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var productOutlet: UILabel!
    @IBOutlet weak var typeOutlet: UILabel!
    @IBOutlet weak var embalasjeOutlet: UILabel!
    @IBOutlet weak var deliverOutlet: UILabel!
    var produkt: Produkt!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonOutlet.layer.cornerRadius = 5
        registerButtonOutlet.layer.cornerRadius = 5
        map.layer.cornerRadius = 5
        productOutlet.text = produkt.getProduktnavn()
        typeOutlet.text = produkt.getProdukttype()
        embalasjeOutlet.text = produkt.getAvfallstype().getTypenavn()
        deliverOutlet.text = produkt.getProdusent()
        
        let gpsUtil: GPSUtil = GPSUtil()
        gpsUtil.getLocation(completion: {(lat, long) in
            if lat.count > 0 && long.count > 0{
                let location = CLLocationCoordinate2D(latitude: Double(lat)!, longitude:Double(long)!)
                
                
                let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                
                let region = MKCoordinateRegion(center: location, span: span)
                
                self.map.setRegion(region, animated: true)
            }
            for element in self.produkt.getAvfallstype().getAvfallsplass(){
                var recycleLocation = MKPointAnnotation()
                recycleLocation.coordinate.latitude = element.getLatitude()
                recycleLocation.coordinate.longitude = element.getLongitude()
                recycleLocation.title = element.getNavn()
                self.map.addAnnotation(recycleLocation)
            }
            
        })
        if(produkt.getProduktnavn().count > 27){
//          startAnimation()
        }
//        startAnimation()
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "segueShowBackToMain", sender: self)
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        
        let httpRequest = HTTPRequestHelper()
        
        httpRequest.registerProductDelivery(barcode: produkt.getStrekkode(), completionhandler: {(melding) in
            
            print(melding)
        })
    }
    
    
    
    
    func startAnimation()
    {
        //Animating the label automatically change as per your requirement

        DispatchQueue.main.async(execute: {

            UIView.animate(withDuration: 10.0, delay: 1, options: ([.curveLinear, .repeat]), animations: {
                () -> Void in
                
                self.productOutlet.center = CGPoint(x: 30, y: self.productOutlet.center.y)
            }, completion:  nil)
        })
    }
    
    
    
    
}
