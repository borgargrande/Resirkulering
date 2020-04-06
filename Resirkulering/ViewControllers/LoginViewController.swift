//
//  LoginViewController.swift
//  Resirkulering
//
//  Created by Borgar Grande on 23/03/2020.
//  Copyright © 2020 Borgar Grande. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var mobilNrTextOutlet: UITextField!
    @IBOutlet weak var passordTextOutlet: UITextField!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var backButtonOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        mobilNrTextOutlet.delegate = self
        passordTextOutlet.delegate = self
        loginButtonOutlet.layer.cornerRadius = 5
        backButtonOutlet.layer.cornerRadius = 5
    }
    
    private func getSchema() -> Void {
        if (mobilNrTextOutlet.text == nil || mobilNrTextOutlet.text!.count < 1){
            visFeilmelding()
        }
        print(mobilNrTextOutlet.text!)
        print(passordTextOutlet.text!)
    }
    
    
    @IBAction func loginButtonAction(_ sender: Any) {
        //        visFeilmelding()
        
        let httpRequest = HTTPRequestHelper()
        let user: Brukar = Brukar()
        user.setTelefon(telefon: mobilNrTextOutlet.text!)
        user.setPassord(passord: passordTextOutlet.text!)
        
        httpRequest.loginUser(user: user, completionhandler: {(melding) in
            
            if (melding?.getMeldingstype() == "LoginOK"){
                
                let userDefault = UserDefaults()
                userDefault.set(user.getTelefon(), forKey: "telefon")
                userDefault.set(user.getPassord(), forKey: "passord")
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "segueLogginnStartLogin", sender: self)
                }

                
            }else {
                
            }
            //            print(melding?.getMeldingstype())
            
        })
        
        
        
        //        performSegue(withIdentifier: "segueLogginnStartLogin", sender: self)
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "segueLogginnStart", sender: self)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
    private func visFeilmelding() -> Void {
        
        
        let alert = UIAlertController(title:"Manglande input", message: "Fyll ut informasjonen", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            
            self.present(alert, animated: true)
        }
        
        
        
    }
    
}
