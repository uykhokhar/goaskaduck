//
//  DetailBookmarkDelegate.swift
//  Go Ask A Duck
//
//  Created by MouseHouseApp on 2/20/17.
//  Copyright © 2017 Umar Khokhar. All rights reserved.
//

import Foundation


protocol DetailBookmarkDelegate: class {
    func bookmarkPassedURL(url: String) -> Void
}
