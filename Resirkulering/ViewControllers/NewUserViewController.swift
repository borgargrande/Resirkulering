//
//  NewUserViewController.swift
//  Resirkulering
//
//  Created by Borgar Grande on 23/03/2020.
//  Copyright © 2020 Borgar Grande. All rights reserved.
//

import UIKit

class NewUserViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var fornavnTextOutlet: UITextField!
    @IBOutlet weak var etternavnTextOutlet: UITextField!
    @IBOutlet weak var mobilnrTextOutlet: UITextField!
    @IBOutlet weak var passordTextOutlet: UITextField!
    @IBOutlet weak var passordRepeatTextOutlet: UITextField!
    @IBOutlet weak var registerNewUserButtonOutlet: UIButton!
    @IBOutlet weak var backButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fornavnTextOutlet.delegate = self
        etternavnTextOutlet.delegate = self
        mobilnrTextOutlet.delegate = self
        passordRepeatTextOutlet.delegate = self
        passordRepeatTextOutlet.delegate = self
        registerNewUserButtonOutlet.layer.cornerRadius = 5
        backButtonOutlet.layer.cornerRadius = 5
    }
    
    
    
    private func getSchema() -> Void {
        if(fornavnTextOutlet.text!.count < 1 || etternavnTextOutlet.text!.count < 1 ||  mobilnrTextOutlet.text!.count < 1 || passordTextOutlet.text!.count < 1 || passordRepeatTextOutlet.text!.count < 1){
            visFeilmelding(feilmelding: "Fyll ut naudsynt informasjon")
        }
        print(fornavnTextOutlet.text!)
        print(etternavnTextOutlet.text!)
        print(mobilnrTextOutlet.text!)
        print(passordTextOutlet.text!)
        print(passordRepeatTextOutlet.text!)
    }
    
    
    @IBAction func registerUserButtonAction(_ sender: Any) {
//         visFeilmelding()
        let httpRequest = HTTPRequestHelper()

        let newUser: Brukar = Brukar();

        newUser.setFornavn(fornavn: fornavnTextOutlet.text!)
        newUser.setEtternavn(etternavn: etternavnTextOutlet.text!)
        newUser.setTelefon(telefon: mobilnrTextOutlet.text!)
        newUser.setPassord(passord: passordTextOutlet.text!)
        
        httpRequest.newUser(brukar: newUser, repeatedPassword: passordRepeatTextOutlet.text!, completionhandler: {(melding) in

            if (melding?.getMeldingstype() == "RegistreringOK"){
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "segueNewUserStartRegister", sender: self)
                }
                let userDefault = UserDefaults()
                userDefault.setValue(newUser.getTelefon(), forKey: "telefon")
                userDefault.setValue(newUser.getPassord(), forKey: "passord")
                
            }else {
                self.visFeilmelding(feilmelding: (melding?.getMeldingstype())!)
            }
//            print(melding?.getMeldingstype())

        })
        
                
        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
       
        performSegue(withIdentifier: "segueNewUserStart", sender: self)
        
    }
    
    private func visFeilmelding(feilmelding: String) -> Void {
        var errorCode: String = ""
        switch feilmelding {
        case "BrukarFinst":
            errorCode = "Brukaren finnes frå før"
            break
        default:
            "Fyll inn informasjon"
            break
        }
        
        let alert = UIAlertController(title:"Manglande input", message: errorCode, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            
            self.present(alert, animated: true)
        }
        
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
}
