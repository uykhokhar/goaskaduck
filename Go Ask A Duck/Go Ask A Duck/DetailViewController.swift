//
//  DetailViewController.swift
//  Go Ask A Duck
//
//  Created by MouseHouseApp on 2/19/17.
//  Copyright © 2017 Umar Khokhar. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate, DetailBookmarkDelegate {
    

    @IBOutlet weak var toolBar: UIToolbar!
    
    var webView: WKWebView!
    
    
    // MARK: - Master View item
    var detailItem: SearchResult? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    

    func configureView() {

        // Update the user interface for the detail item.
            if let detail = self.detailItem {
                webView = WKWebView()
                webView.navigationDelegate = self
                view = webView
                webView.load(URLRequest(url: detail.firstURL))
                webView.allowsBackForwardNavigationGestures = true
            }

    }
    
    
    // MARK: - View Lifecycle
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        let url = URL(string: "https://www.apple.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        navigationController?.navigationBar.barTintColor = UIColor.appBlue
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.appPurple]
        


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func saveToFavorites(_ sender: Any) {
        
        detailItem?.favorite = true
        Favorites.shared.add(new: detailItem!)
        
        print(" **********      SAVED ITEMS************")
        for favorite in Favorites.favorites {
            print("item: \(favorite.searchString)")
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToBookmarks" {
            let bvc = segue.destination as! PopoverTableViewController
            bvc.bookmarkDelegate = self
        }
    }
    
    
    
    func bookmarkPassedURL(url: String) {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        let requestURL : URL = NSURL(string: url) as! URL
        
        webView.load(URLRequest(url: requestURL))
        webView.allowsBackForwardNavigationGestures = true
    }



}

