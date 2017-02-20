//
//  Favorites.swift
//  Go Ask A Duck
//
//  Created by MouseHouseApp on 2/20/17.
//  Copyright © 2017 Umar Khokhar. All rights reserved.
//

import Foundation

class Favorites {
    
    static var favorites : [SearchResult] = []
    let defaults = UserDefaults.standard
    
    private init(){
    }
    
    static let shared : Favorites = Favorites()
    
    func add(new: SearchResult){
        Favorites.favorites.append(new)
        let savedData = NSKeyedArchiver.archivedData(withRootObject: Favorites.favorites)
        defaults.set(savedData, forKey: "SavedArray")
        print(defaults.dictionaryRepresentation())
        
        print(" **********      SAVED ITEMS************")
        for favorite in Favorites.favorites {
            print("item: \(favorite.searchString)")
        }
    }
    
    func remove(item: Int){
        print(" **********      Remove Item ************")
        for favorite in Favorites.favorites {
            print("item: \(favorite.searchString)")
        }
        
        Favorites.favorites.remove(at: item )
        let savedData = NSKeyedArchiver.archivedData(withRootObject: Favorites.favorites)
        defaults.set(savedData, forKey: "SavedArray")
        print(defaults.dictionaryRepresentation())
    }
    
}
