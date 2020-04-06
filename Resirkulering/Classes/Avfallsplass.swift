//
//  Avfallsplass.swift
//  Resirkulering
//
//  Created by Borgar Grande on 21/03/2020.
//  Copyright © 2020 Borgar Grande. All rights reserved.
//

import Foundation


class Avfallsplass: Codable{
    let plassid: Int
    private let navn: String
    private let latitude: Double
    private let longitude: Double
//    private let avfallstype: [Avfallstype]
    
    
    public func getLatitude() -> Double{
        return self.latitude
    }
    
    public func getLongitude() -> Double {
        return self.longitude
    }
    
    public func getNavn() -> String {
        return self.navn
    }
}
