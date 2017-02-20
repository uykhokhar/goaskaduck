//
//  SearchResult.swift
//  Go Ask A Duck
//
//  Created by MouseHouseApp on 2/19/17.
//  Copyright © 2017 Umar Khokhar. All rights reserved.
//

import Foundation

class SearchResult {
    
    var searchString : String
    var firstURL : URL
    var text : String
    
    init(searchString: String, firstURL: URL, text: String){
        self.searchString = searchString
        self.firstURL = firstURL
        self.text = text
    }
    
    
}
