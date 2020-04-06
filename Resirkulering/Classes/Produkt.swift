//
//  Produkt.swift
//  Resirkulering
//
//  Created by Borgar Grande on 21/03/2020.
//  Copyright © 2020 Borgar Grande. All rights reserved.
//

import Foundation

class Produkt: Codable{
    
    
    private let strekkode: String
    private let produktnavn: String
    private let produkttype: String
    private let produsent: String
    private let avfallstype: Avfallstype?

    private let leveringsoversikt: [Leveringsoversikt]?
    
    public func getStrekkode() -> String {
        return self.strekkode
    }
    
    public func getProduktnavn() -> String {
        return self.produktnavn
    }
    
    public func getProdukttype() -> String {
        return self.produkttype
    }
    
    public func getAvfallstype() -> Avfallstype {
        return self.avfallstype!
    }
    
    public func getProdusent() -> String {
        return self.produsent
    }
}
