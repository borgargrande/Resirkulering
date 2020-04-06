//
//  DeliverViewController.swift
//  Resirkulering
//
//  Created by Borgar Grande on 20/03/2020.
//  Copyright © 2020 Borgar Grande. All rights reserved.
//

import UIKit
struct cellData {
    var type: String
    var opened: Bool
    var leverinsoversikt: [Leveringsoversikt]
}
class DeliverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableviewOutlet: UITableView!
    @IBOutlet weak var backButtonOutlet: UIButton!
    @IBOutlet weak var deliverButtonOutlet: UIButton!
    @IBOutlet weak var avfallsplassNavnOutlet: UILabel!
    var avfallsplass: Avfallsplass!
    var leveringsoversikt: [Leveringsoversikt]?
    var tableviewData: [cellData] = []
    var plast: [Leveringsoversikt]!
    var papir: [Leveringsoversikt]!
    var glass: [Leveringsoversikt]!
    var metall: [Leveringsoversikt]!
    var restavfall: [Leveringsoversikt]!
    var tilLevering: [Leveringsoversikt] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deliverButtonOutlet.layer.cornerRadius = 5
        backButtonOutlet.layer.cornerRadius = 5
        tableviewOutlet.delegate = self
        tableviewOutlet.dataSource = self
        avfallsplassNavnOutlet.text = avfallsplass.getNavn()
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableviewData.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableviewData[section].opened){
            return tableviewData[section].leverinsoversikt.count + 1
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableviewOutlet.dequeueReusableCell(withIdentifier: "typeCell") as! typeCellTableViewCell
            cell.typeLabelOutlet.text = tableviewData[indexPath.section].type
            cell.selectAllButtonOutlet.isHidden = true
            cell.selectAllButtonOutlet.isEnabled = false
            
            return cell
        }else {
            let cell = tableviewOutlet.dequeueReusableCell(withIdentifier: "productCell") as! ProduktViewTableViewCell
            
            cell.buttonOutlet.tag = tableviewData[indexPath.section].leverinsoversikt[indexPath.row - 1].id!
            
            
            cell.produktNameOutlet.text = tableviewData[indexPath.section].leverinsoversikt[indexPath.row - 1].produkt?.getProduktnavn()
            return cell
        }
        
    }
    
    
    @IBAction func produktButtonPressed(_ sender: UISwitch) {
        tilLevering.append((leveringsoversikt?.first(where: {$0.id == sender.tag})!)!)
        
        print(leveringsoversikt?.first(where: {$0.id == sender.tag})?.produkt?.getProduktnavn())
        
    }
    
    @IBAction func deliverButtonAction(_ sender: Any) {
        
        
        if(tilLevering.count > 0){
            let request: HTTPRequestHelper = HTTPRequestHelper()
            
            
            request.deliverProducts(toDeliver: tilLevering, completionhandler: {(melding) in
                if let currentMelding = melding {
                    if(currentMelding.getMeldingstype() == "IngenProdukt"){
                        
                    }
                    
                    
                    if(currentMelding.getMeldingstype() == "ProduktLevert"){
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "segueDeliverBackToMain", sender: self)
                        }
                    }
                }
            })
            
            
        }else {
            //vis feilmelding
        }
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableviewData[indexPath.section].opened == true){
            tableviewData[indexPath.section].opened = false
            let sections = IndexSet(integer: indexPath.section)
            tableviewOutlet.reloadSections(sections, with: .none)
        }else {
            tableviewData[indexPath.section].opened = true
            let sections = IndexSet(integer: indexPath.section)
            tableviewOutlet.reloadSections(sections, with: .none)
        }
    }
    
    
    
    
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        performSegue(withIdentifier: "segueDeliverBackToMain", sender: self)
    }
    
    
}
