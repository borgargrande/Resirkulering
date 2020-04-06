//
//  Melding.swift
//  Resirkulering
//
//  Created by Borgar Grande on 25/03/2020.
//  Copyright © 2020 Borgar Grande. All rights reserved.
//

import Foundation


class Melding: Codable{
    private var meldingstype: String
    private var produkt: Produkt?
    private var avfallsplass: Avfallsplass?
    private var avfallsype: Avfallstype?
    private var brukar: Brukar?
    private var produktTilLevering: [Leveringsoversikt]?
    private var avfallsplasser: [Avfallsplass]?
    private var leveringsoversikt: [Leveringsoversikt]?
    
    internal func getMeldingstype() -> String{
        return meldingstype
    }
    
    internal func getProdukt() -> Produkt{
        return self.produkt!
    }
        
    internal func getAvfallsplass() -> Avfallsplass{
        return self.avfallsplass!
    }
    
    internal func getAvfallstype() -> Avfallstype{
        return self.avfallsype!
    }
    
    internal func getBrukar() -> Brukar{
        return self.brukar!
    }
    
    internal func getProductForDelivery() -> [Leveringsoversikt]{
        return self.produktTilLevering!
    }
    
    internal func getAvfallsplasser() -> [Avfallsplass]{
        return self.avfallsplasser!
    }
    
    internal func getLeveringsoversikt() -> [Leveringsoversikt]{
        return self.leveringsoversikt!
    }
}
