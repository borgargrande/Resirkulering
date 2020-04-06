//
//  ShowHistoryViewController.swift
//  Resirkulering
//
//  Created by Borgar Grande on 02/04/2020.
//  Copyright © 2020 Borgar Grande. All rights reserved.
//

import UIKit

class ShowHistoryViewController: UIViewController {
    
    @IBOutlet weak var backButtonOutlet: UIButton!
    var leveringsoversikter: [Leveringsoversikt]!
    
    
    @IBOutlet weak var totalOutlet: UILabel!
    
    @IBOutlet weak var papirOutlet: UILabel!
    @IBOutlet weak var plastOutlet: UILabel!
    @IBOutlet weak var metallOutlet: UILabel!
    @IBOutlet weak var restavfallOutlet: UILabel!
    @IBOutlet weak var glassOutlet: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonOutlet.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
        totalOutlet.text = String(leveringsoversikter.count)
        
        var papirAntall: Int = 0
        var plastAntall: Int = 0
        var metallAntall: Int = 0
        var restavfallAntall: Int = 0
        var glassAntall: Int = 0
        
        
        for element in leveringsoversikter{
            switch element.produkt?.getAvfallstype().getTypenavn() {
            case "Papir":
                papirAntall += 1
                break
            case "Plast":
                plastAntall += 1
                break
            case "Metall":
                metallAntall += 1
                break
            case "Restavfall":
                restavfallAntall += 1
                break
            case "Glass":
                glassAntall += 1
                break
            default:
                break
            }
        }
        
        
         papirOutlet.text = String(papirAntall)
         plastOutlet.text = String(plastAntall)
         metallOutlet.text = String(metallAntall)
         restavfallOutlet.text = String(restavfallAntall)
         glassOutlet.text = String(glassAntall)
        
        
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func backButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "sequqBackToMainFromHistory", sender: self)
    }
}
