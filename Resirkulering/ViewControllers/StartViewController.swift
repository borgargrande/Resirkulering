//
//  ShowInfoViewController.swift
//  Resirkulering
//
//  Created by Borgar Grande on 06/03/2020.
//  Copyright © 2020 Borgar Grande. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    private var localData: UserDefaults
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var newUserButtonOutlet: UIButton!
    
    
    required init?(coder aDecoder: NSCoder) {
        localData = UserDefaults()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButtonOutlet.layer.cornerRadius = 5
        newUserButtonOutlet.layer.cornerRadius = 5
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let telefon = localData.string(forKey: "telefon") ?? "Missing"
        print(telefon)
        if (telefon == "Missing"){
            
        }else {
            print("segue")
            performSegue(withIdentifier: "segueShowMain", sender: self)
        }
    
}

@IBAction func loginButtonAction(_ sender: Any) {
    performSegue(withIdentifier: "segueLoggInn", sender: self)
}

@IBAction func newUserButtonAction(_ sender: Any) {
    performSegue(withIdentifier: "segueNewUser", sender: self)
    
}

@IBAction func lureknapp(_ sender: Any) {
    performSegue(withIdentifier: "segueShowMain", sender: self)
}

@IBAction func unwindToStart(_ sernder: UIStoryboardSegue){
    //localData.set("81549300", forKey: "telefon")
    print(sernder.identifier)
}

@IBAction func unwindToStartLogin(_ sernder: UIStoryboardSegue){
     
    print(sernder.identifier)
}

@IBAction func unwindToStartRegister(_ sernder: UIStoryboardSegue){
    print(sernder.identifier)
}

}
