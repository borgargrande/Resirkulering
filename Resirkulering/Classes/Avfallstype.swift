//
//  Avfallstype.swift
//  Resirkulering
//
//  Created by Borgar Grande on 21/03/2020.
//  Copyright © 2020 Borgar Grande. All rights reserved.
//

import Foundation


class Avfallstype: Codable{
    private let typenavn: String
    private let avfallsbeskrivelse: String
    private let avfallsplass: [Avfallsplass]?
    
    
    
    public func getTypenavn() -> String {
        return self.typenavn
    }
    
    public func getAvfallsplass() -> [Avfallsplass]{
        return self.avfallsplass!
    }
}
