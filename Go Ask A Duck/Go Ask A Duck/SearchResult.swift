//
//  SearchResult.swift
//  Go Ask A Duck
//
//  Created by MouseHouseApp on 2/19/17.
//  Copyright © 2017 Umar Khokhar. All rights reserved.
//

import Foundation

class SearchResult : NSObject, NSCoding{
    
    var searchString : String
    var firstURL : URL
    var text : String
    var favorite: Bool = false 
    
    init(searchString: String, firstURL: URL, text: String){
        self.searchString = searchString
        self.firstURL = firstURL
        self.text = text
    }
    
    
    required init(coder aDecoder: NSCoder) {
        searchString = aDecoder.decodeObject(forKey: "searchString") as! String
        firstURL = aDecoder.decodeObject(forKey: "firstURL") as! URL
        text = aDecoder.decodeObject(forKey: "text") as! String
        favorite = aDecoder.decodeBool(forKey: "favorite") 
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(searchString, forKey: "searchString")
        aCoder.encode(firstURL, forKey: "firstURL")
        aCoder.encode(text, forKey: "text")
        aCoder.encode(favorite, forKey: "favorite")
    }
    
    
    
}
