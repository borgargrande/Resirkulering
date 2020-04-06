//
//  SelectDeliveryPlaceViewController.swift
//  Resirkulering
//
//  Created by Borgar Grande on 01/04/2020.
//  Copyright © 2020 Borgar Grande. All rights reserved.
//

import UIKit

class SelectDeliveryPlaceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveryPlaces.count
    }
    
    
    @IBOutlet weak var pickLocationButtonOutlet: UIButton!
    @IBOutlet weak var backButtonOutlet: UIButton!
    private var leveringsoversikt: [Leveringsoversikt]?
    var deliveryPlaces: [Avfallsplass]!
    private var selectedPlace: Int?
    private var selectedAvfallsplass: Avfallsplass?
    @IBOutlet weak var tableviewOutlet: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableviewOutlet.delegate = self
        tableviewOutlet.dataSource = self
        pickLocationButtonOutlet.layer.cornerRadius = 10
        backButtonOutlet.layer.cornerRadius = 10
        tableviewOutlet.layer.cornerRadius = 10

    }
    
    
    
    
    
    
    @IBAction func selectPlaceAction(_ sender: Any) {
        
        let request: HTTPRequestHelper = HTTPRequestHelper()
        
        
        request.getProductForDelivery(placeID: selectedPlace ?? 1, completionhandler: {(melding) in
            if let currentMelding = melding {
                if(currentMelding.getMeldingstype() == "FEIL"){
                    //Vis feilmelding
                }
                
                
                if(currentMelding.getMeldingstype() == "ProduktForLeveringOK"){
                    DispatchQueue.main.async {
                        self.leveringsoversikt = currentMelding.getProductForDelivery()
                        self.performSegue(withIdentifier: "segueShowDeliver", sender: self)
                    }
                }
                
                
            }
        })
        
        
        
    }
    
    
    
    
    @IBAction func backToMainButtonAction(_ sender: Any) {
        
        performSegue(withIdentifier: "segueBackToMainFromSelect", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueShowDeliver"){
            
            var plast: [Leveringsoversikt] = []
            var papir: [Leveringsoversikt] = []
            var glass: [Leveringsoversikt] = []
            var metall: [Leveringsoversikt] = []
            var restavfall: [Leveringsoversikt] = []
            
            for element in leveringsoversikt!{
                
                switch element.produkt?.getAvfallstype().getTypenavn() {
                case "Papir":
                    print("heisann")
                    papir.append(element)
                    break;
                case "Plast":
                    plast.append(element)
                    break;
                case "Restavfall":
                    restavfall.append(element)
                    break;
                case "Glass":
                    glass.append(element)
                    break;
                case "Metall":
                    metall.append(element)
                    break;
                default:
                    break;
                }
            }
            
            
            let deliver = segue.destination as! DeliverViewController
            if(papir.count > 0){
                deliver.tableviewData.append(cellData(type: "Papir", opened: false, leverinsoversikt: papir))
            }
            if(plast.count > 0){
                deliver.tableviewData.append(cellData(type: "Plast",opened: false, leverinsoversikt: plast))
            }
            if(restavfall.count > 0){
                deliver.tableviewData.append(cellData(type: "Restavfall",opened: false, leverinsoversikt: restavfall))
            }
            if(glass.count > 0){
                deliver.tableviewData.append(cellData(type: "Glass",opened: false, leverinsoversikt: glass))
            }
            if(metall.count > 0){
                deliver.tableviewData.append(cellData(type: "Metall",opened: false, leverinsoversikt: metall))
            }
            deliver.avfallsplass =  selectedAvfallsplass
            deliver.leveringsoversikt = self.leveringsoversikt
        }
    }
    
    
    
    
    
  

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableviewOutlet.dequeueReusableCell(withIdentifier: "selectPlaceCell") as! DeliveryPlaceTableViewCell
        cell.placeNameOutlet.text = deliveryPlaces[indexPath.row].getNavn()
     
        
      
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedPlace = deliveryPlaces[indexPath.row].plassid
        selectedAvfallsplass = deliveryPlaces[indexPath.row]
    }
    
}
