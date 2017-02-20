//
//  MasterViewController.swift
//  Go Ask A Duck
//
//  Created by MouseHouseApp on 2/19/17.
//  Copyright © 2017 Umar Khokhar. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [SearchResult]()
    var searchQuery : String = ""

    
    
    @IBOutlet weak var SearchBar: UISearchBar! {
        didSet { SearchBar.delegate = self}
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let defaults = UserDefaults.standard
        
        if let savedFavorites = defaults.object(forKey: "SavedArray") as? Data {
            Favorites.favorites = NSKeyedUnarchiver.unarchiveObject(with: savedFavorites) as! [SearchResult]
        }
        
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
      
        applyColor()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func insertNewObject(_ sender: Any) {
//        objects.insert(NSDate(), at: 0)
//        let indexPath = IndexPath(row: 0, section: 0)
//        self.tableView.insertRows(at: [indexPath], with: .automatic)
//    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultTableViewCell
        
        cell.title.text = objects[indexPath.row].firstURL.path
        cell.result.text = objects[indexPath.row].text

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    
    
    
    
    // MARK: - Appearance
    func applyColor(){
        //navigationbar tint color, table view background color
        navigationController?.navigationBar.barTintColor = UIColor.appBlue
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.appPurple]
        self.view.backgroundColor = UIColor.appBackground
        SearchBar.tintColor = UIColor.appBlue
        SearchBar.backgroundColor = UIColor.appBackground
        
        
        //tint color to whole application
        let sharedApplication = UIApplication.shared
        sharedApplication.delegate?.window??.tintColor = UIColor.appPurple
    }
    
    
    // MARK: - Search and fetch results
     
    func search(term: String){
        
        let convertedQuery = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        do {

            try SharedNetworking.sharedInstance.getDataFromURL(urlString: "https://api.duckduckgo.com/?q=" + convertedQuery! + "&format=json&pretty=1") {(response) in
        
            DispatchQueue.main.async {
                self.objects = SharedNetworking.sharedInstance.allResults
                self.tableView.reloadData()
                }
            }
        } catch {
            let alert = UIAlertController(title: "Connection Error", message: "Could not retrieve data from Duck Duck Go", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false

  
    }

    
    
}

// MARK: - SearchBar functions
extension MasterViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchQuery = SearchBar.text!
        search(term: searchQuery)

    }

}

