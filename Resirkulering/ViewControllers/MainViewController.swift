//
//  MainViewController.swift
//  Resirkulering
//
//  Created by Borgar Grande on 06/03/2020.
//  Copyright © 2020 Borgar Grande. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var barcodeText: UITextField!
    @IBOutlet weak var scanButtonOutlet: UIButton!
    @IBOutlet weak var hentButtonOoutlet: UIButton!
    @IBOutlet weak var historyButtonOutlet: UIButton!
    @IBOutlet weak var deliverButtonOutlet: UIButton!
    private var produkt: Produkt?
    private var leveringsoversikt: [Leveringsoversikt]?
    private var leveringsplasser: [Avfallsplass]?
    @IBOutlet weak var viewActivityIndicatior: UIView!
    @IBOutlet weak var activityIndicatorOutlet: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barcodeText.delegate = self
        scanButtonOutlet.layer.cornerRadius = 5
        hentButtonOoutlet.layer.cornerRadius = 5
        historyButtonOutlet.layer.cornerRadius = 5
        deliverButtonOutlet.layer.cornerRadius = 5

        
        
        viewActivityIndicatior.isHidden = true
        activityIndicatorOutlet.stopAnimating()
        activityIndicatorOutlet.isHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewActivityIndicatior.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueShowDetail"){
            let info = segue.destination as! ShowInfoViewController
            info.produkt = self.produkt
        }
        
        if (segue.identifier == "segueMainToSelectPlace"){
            let places = segue.destination as! SelectDeliveryPlaceViewController
            places.deliveryPlaces = self.leveringsplasser
        }
        if (segue.identifier == "segueMainToShowHistory"){
            let history = segue.destination as! ShowHistoryViewController
            history.leveringsoversikter = self.leveringsoversikt
        }
        
        
        
        
        
    }
    
    @IBAction func hentButtonAction(_ sender: Any) {
        showWaiting()
        
        searchProductSegueToShow()
        
    }
    
    @IBAction func deliverButtonAction(_ sender: Any) {
        let request: HTTPRequestHelper = HTTPRequestHelper()
        self.showWaiting()
        
        let gpsUtil = GPSUtil()
        gpsUtil.getLocation(completion: {(lat, long) in
            
            request.getDeliveryPlaces(lat: lat, long: long, completionhandler: {(melding) in
                if let currentMelding = melding {
                    if(currentMelding.getMeldingstype() == "FEIL"){
                        self.HideShowWaiting()
                        
                        self.visFeilmelding()
                    }
                    
                    
                    if(currentMelding.getMeldingstype() == "OK"){
                       
                        DispatchQueue.main.async {
                            self.leveringsplasser = currentMelding.getAvfallsplasser()
                            
                            self.performSegue(withIdentifier: "segueMainToSelectPlace", sender: self)
                        }
                    }
                    
                    
                }
            })
        })
        
        
    }
    
    @IBAction func scanButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "segueBarcodeScanner", sender: self)
    }
    @IBAction func unwindToMain(_ sernder: UIStoryboardSegue){
        viewActivityIndicatior.isHidden = true
        activityIndicatorOutlet.stopAnimating()
        
        if(sernder.identifier == "backToMain"){
            
            let scanner = sernder.source as! ScannerViewController
            barcodeText.text = scanner.barcode
            
            
            searchProductSegueToShow()
        }
        
        if(sernder.identifier == "segueDeliverBackToMain"){
            showHistory()
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func historyButtonAction(_ sender: Any) {
        showHistory()
        
        
        
    }
    
    func showHistory() -> Void {
        DispatchQueue.main.async {
            let request: HTTPRequestHelper = HTTPRequestHelper()
            
            
            request.getHistory(completionhandler: {(melding) in
                if let currentMelding = melding {
                    if(currentMelding.getMeldingstype() == "TomHistorikk"){
                        DispatchQueue.main.async {
                            self.viewActivityIndicatior.isHidden = true
                            self.activityIndicatorOutlet.stopAnimating()
                            self.activityIndicatorOutlet.isHidden = true
                        }
                        
                        self.visFeilmelding()
                    }
                    
                    
                    if(currentMelding.getMeldingstype() == "HistorikkOK"){
                        DispatchQueue.main.async {
                            self.leveringsoversikt = currentMelding.getLeveringsoversikt()
                            
                            self.performSegue(withIdentifier: "segueMainToShowHistory", sender: self)
                        }
                    }
                    
                    
                }
            })
            
        }
    }
    
    func searchProductSegueToShow() -> Void {
        
        
        let request: HTTPRequestHelper = HTTPRequestHelper()
        viewActivityIndicatior.isHidden = false
        activityIndicatorOutlet.startAnimating()
        self.activityIndicatorOutlet.isHidden = false
        request.getProduct(barcode: barcodeText.text!, completionhandler: {(melding) in
            if let currentMelding = melding {
                if(currentMelding.getMeldingstype() == "ProduktFinnastIkkje"){
                    DispatchQueue.main.async {
                        self.viewActivityIndicatior.isHidden = true
                        self.activityIndicatorOutlet.stopAnimating()
                        self.activityIndicatorOutlet.isHidden = true
                    }
                    
                    self.visFeilmelding()
                }else {
                    
                    self.produkt = currentMelding.getProdukt()
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "segueShowDetail", sender: self)
                    }
                    
                    
                }
            }
        })
    }
    
    private func visFeilmelding() -> Void {
        
        
        let alert = UIAlertController(title:"Manglande produkt", message: "Produktet du leitar etter eksisterar ikkje i databasen. Prøv med eit anna produkt", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            
            self.present(alert, animated: true)
        }
        
        
        
    }
    
    private func showWaiting() -> Void {
        DispatchQueue.main.async {
            self.viewActivityIndicatior.isHidden = false
            self.activityIndicatorOutlet.startAnimating()
            self.activityIndicatorOutlet.isHidden = false
        }
        
    }
    
    private func HideShowWaiting() -> Void {
        
        
        
        DispatchQueue.main.async {
            self.viewActivityIndicatior.isHidden = true
            self.activityIndicatorOutlet.stopAnimating()
            self.activityIndicatorOutlet.isHidden = false
            
            
        }
    }
    
}
