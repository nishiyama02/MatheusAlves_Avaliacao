//
//  Location.swift
//  MatheusAlves_Avaliacao_Gol
//
//  Created by matheus.n.alves on 01/07/2018.
//  Copyright © 2018 matheus.n.alves. All rights reserved.
//

import Foundation
class Location: NSObject, NSCoding {
    
    var title: String
    var locationType: String
    var woeId: Int
    var lattLong: String
    var weathers: [Weather]?
    var savedDate: Date?
    
    init(_ title: String, locationType: String, woeId: Int, lattLong: String) {
        self.title = title
        self.locationType = locationType
        self.woeId = woeId
        self.lattLong = lattLong
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: "title") as! String
        let woeId = aDecoder.decodeInteger(forKey: "woeId")
        let locationType = aDecoder.decodeObject(forKey: "locationType") as! String
        let lattLong = aDecoder.decodeObject(forKey: "lattLong") as! String
        let savedDate = (aDecoder.decodeObject(forKey: "savedDate") as! Date)
        self.init(title, locationType: locationType, woeId: woeId, lattLong: lattLong)
        self.savedDate = savedDate
    }
    
    func getTodayWeather() -> Weather?{
        if let weathers = self.weathers,
            weathers.count > 0{
            return weathers[0]
        }
        else{
            return nil
        }
    }
    
    func isTitleStarted(withText text: String) -> Bool{
        let lowerCasedTitle = self.title.lowercased()
        let lowerCasedText = text.lowercased()
        if lowerCasedTitle.starts(with: lowerCasedText){
            return true
        }
        else{
            return false
        }
    }
    
    override var description: String {
        return self.title
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        return self.woeId == (object as? Location)?.woeId
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.woeId, forKey: "woeId")
        aCoder.encode(self.lattLong, forKey: "lattLong")
        aCoder.encode(self.locationType, forKey: "locationType")
        aCoder.encode(self.savedDate!, forKey: "savedDate")
    }
    
}
