//
//  Location.swift
//
//  Created by Borgar Grande on 12/03/2020.
//  Copyright © 2020 Borgar Grande. All rights reserved.
//

import Foundation
class Location{
    
    private var latitude: String
    private var longitude: String
    private var navn: String
    
    init(latitude: String, longitude: String, navn: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.navn = navn
    }
    
    public func getLatitude() -> String{
        return self.latitude
    }
    
    public func getLongitude() -> String{
        return self.longitude
    }
    
    public func getNavn() -> String{
        return self.navn
    }
    
}
