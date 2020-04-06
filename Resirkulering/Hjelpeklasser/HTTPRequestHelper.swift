//
//  HTTPRequestHelper.swift
//  Resirkulering
//
//  Created by Borgar Grande on 21/03/2020.
//  Copyright © 2020 Borgar Grande. All rights reserved.
//

import Foundation

class HTTPRequestHelper{
            private var url: String = "https://dat109.westeurope.cloudapp.azure.com/DAT109Oblig3/"
//    private var url: String = "http://192.168.80.120:8080/DAT109Oblig3/"
    
    
    
    func getProduct(barcode: String, completionhandler: @escaping (Melding?) -> Void){
        url = url +  "hentProdukt?barcode=" + barcode
        print(url)
        guard let url = URL(string: url) else{
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "get"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let jData = data else {return}
            let decoder = JSONDecoder()
            
            let melding = try! decoder.decode(Melding.self, from: jData)
            
            completionhandler(melding)
            
        }.resume()
        
    }
    
    func newUser(brukar: Brukar, repeatedPassword: String, completionhandler: @escaping (Melding?) -> Void){
        url = url +  "nybruker"
        print(url)
        guard let url = URL(string: url) else{
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "post"
        
        var postString = "fornavn=" + brukar.getFornavn()
        postString = postString + "&etternavn=" + brukar.getEtternavn()
        postString = postString + "&telefon=" + brukar.getTelefon()
        postString = postString + "&passord=" + brukar.getPassord()
        postString = postString + "&passordRepetert=" + repeatedPassword
        
        request.httpBody = postString.data(using: .utf8);
        
        
        
        
        
        
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let jData = data else {return}
            let decoder = JSONDecoder()
            
            let melding = try! decoder.decode(Melding.self, from: jData)
            
            completionhandler(melding)
            
        }.resume()
        
        
    }
    
    func registerProductDelivery(barcode: String, completionhandler: @escaping (Melding?) -> Void){
        url = url +  "registrerProduktForLevering"
        print(url)
        guard let url = URL(string: url) else{
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "post"
        let userDefault = UserDefaults()
        var postString = "strekkode=" + barcode
        postString = postString + "&telefon=" + userDefault.string(forKey: "telefon")!
        
        request.httpBody = postString.data(using: .utf8);
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let jData = data else {return}
            let decoder = JSONDecoder()
            
            let melding = try! decoder.decode(Melding.self, from: jData)
            
            completionhandler(melding)
            
        }.resume()
        
    }
    
    
    
    func loginUser(user: Brukar, completionhandler: @escaping (Melding?) -> Void){
        url = url +  "login"
        print(url)
        guard let url = URL(string: url) else{
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "post"
        let userDefault = UserDefaults()
        var postString = "telefon=" + user.getTelefon()
        postString = postString + "&passord=" + user.getPassord()
        
        request.httpBody = postString.data(using: .utf8);
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let jData = data else {return}
            let decoder = JSONDecoder()
            
            let melding = try! decoder.decode(Melding.self, from: jData)
            
            completionhandler(melding)
            
        }.resume()
        
    }
    
    
    func autoLogin(completionhandler: @escaping (Melding?) -> Void){
        url = url +  "login"
        print(url)
        guard let url = URL(string: url) else{
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "post"
        let userDefault = UserDefaults()
        var postString = "telefon=" + UserDefaults.init().string(forKey: "telefon")!
        postString = postString + "&passord=" + UserDefaults.init().string(forKey: "passord")!
        
        request.httpBody = postString.data(using: .utf8);
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let jData = data else {return}
            let decoder = JSONDecoder()
            
            let melding = try! decoder.decode(Melding.self, from: jData)
            
            completionhandler(melding)
            
        }.resume()
        
    }
    
    func getProductForDelivery(placeID: Int, completionhandler: @escaping (Melding?) -> Void){
        let userDefaults = UserDefaults()
        
        url = url +  "levering?avfallsplassID=" + String(placeID) + "&telefonnr=" + userDefaults.string(forKey: "telefon")!
        print(url)
        guard let url = URL(string: url) else{
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "get"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let jData = data else {return}
            let decoder = JSONDecoder()
            
            let melding = try! decoder.decode(Melding.self, from: jData)
            
            completionhandler(melding)
            
        }.resume()
        
    }
    
    func getHistory(completionhandler: @escaping (Melding?) -> Void){
        let userDefaults = UserDefaults()
        
        url = url +  "hentHistorikk?telefon=" + userDefaults.string(forKey: "telefon")!
        print(url)
        guard let url = URL(string: url) else{
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "get"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let jData = data else {return}
            let decoder = JSONDecoder()
            
            let melding = try! decoder.decode(Melding.self, from: jData)
            
            completionhandler(melding)
            
        }.resume()
        
    }
    
    
    
    
    func getDeliveryPlaces(lat: String, long: String, completionhandler: @escaping (Melding?) -> Void){
        let userDefaults = UserDefaults()
        
        url = url +  "nermasteLeveringsstad?latitude=" + lat + "&longitude=" + long
        print(url)
        guard let url = URL(string: url) else{
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "get"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let jData = data else {return}
            let decoder = JSONDecoder()
            
            let melding = try! decoder.decode(Melding.self, from: jData)
            
            completionhandler(melding)
            
        }.resume()
        
    }
    
    
    
    func deliverProducts(toDeliver:[Leveringsoversikt], completionhandler: @escaping (Melding?) -> Void){
        url = url +  "levering"
        print(url)
        guard let url = URL(string: url) else{
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "post"
        let userDefault = UserDefaults()

        var postString = ""
        for element in toDeliver{
            postString += "leveringsoversiktId=" + String(element.id!) + "&"
        }
        if(postString.count > 1){
             postString.removeLast()
        }
       
        
        request.httpBody = postString.data(using: .utf8);
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let jData = data else {return}
            let decoder = JSONDecoder()
            
            let melding = try! decoder.decode(Melding.self, from: jData)
            
            completionhandler(melding)
            
        }.resume()
        
    }
    
    
    
    
    
    
}
