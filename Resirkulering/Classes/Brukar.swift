//
//  Bruker.swift
//  Resirkulering
//
//  Created by Borgar Grande on 21/03/2020.
//  Copyright © 2020 Borgar Grande. All rights reserved.
//

import Foundation


class Brukar: Codable{
    
    private var fornavn: String
    private var etternavn: String
    private var telefon: String
    private var leveringsoversikt: [Leveringsoversikt]?
    private var passord: String
    
    init(){
        fornavn = ""
        etternavn = ""
        telefon = ""
        passord = ""
    }
    
    internal func getFornavn() -> String {
        return self.fornavn
    }
    
    internal func getEtternavn() -> String {
        return self.etternavn
    }
    
    internal func getTelefon() -> String {
        return self.telefon
    }
    
    internal func getPassord() -> String {
        return self.passord
    }
    internal func setFornavn(fornavn: String) -> Void {
        self.fornavn = fornavn
    }
    
    internal func setEtternavn(etternavn: String) -> Void {
         self.etternavn = etternavn
    }
    
    internal func setTelefon(telefon: String) -> Void {
         self.telefon = telefon
    }
    
    internal func setPassord(passord: String) -> Void {
         self.passord = passord
    }
    
    
}
