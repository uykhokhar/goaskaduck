//
//  SharedNetworking.swift
//  Go Ask A Duck
//
//  Created by MouseHouseApp on 2/19/17.
//  Copyright © 2017 Umar Khokhar. All rights reserved.
//

import Foundation

enum connectionError : Error {
    case noData(message : String)
}

class SharedNetworking {
    
    private init(){
    }
    
    static let sharedInstance : SharedNetworking = SharedNetworking()
    
    var allResults : [SearchResult] = []
    
    
    // Attribution: - https://thatthinginswift.com/completion-handlers/
    func getDataFromURL(urlString: String, completion: @escaping ([SearchResult]) -> Void) throws {
        
        
        guard let url = NSURL(string: urlString) else {
            throw connectionError.noData(message: "Unable to create NSURL from string")
            //fatalError("Unable to create NSURL from string")
        }
        
        // Create a vanilla url session
        let session = URLSession.shared
        
        // Create a data task
        let task = session.dataTask(with: url as URL, completionHandler: { (data, response, error) -> Void in
            
            // Print out the response
            print("Response: \(response)")
            
            // Ensure there were no errors returned from the request
            guard error == nil else {
                print("error: \(error!.localizedDescription)")
                //throw connectionError.noData(message: "Error: \(error!.localizedDescription)")
                fatalError("Error: \(error!.localizedDescription)")
            }
            
            // Ensure there is data and unwrap it
            guard let data = data else {
                fatalError("Data is nil")
            }
            
            // We received data but it needs to be processed
            print("Raw data: \(data)")
            
            // Serialize the raw data into JSON using `NSJSONSerialization`.  The "do-try" is
            // part of an error handling feature of Swift that will be disccused in the future.
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(json)
                
                // Cast JSON as an array of dictionaries
                guard let results = json as? [String: AnyObject] else {
                    fatalError("We couldn't cast the JSON to an array of dictionaries")
                }
                
                // Parse the array of dictionaries to get the important information that you
                // need to present to the user
                
                // Do some parsing here
                
                print("*****        BEGIN PARSING     ********")
                var tempResultsArray : [SearchResult] = []
                
                let searchString = results["Heading"] as? String
                let relatedTopics = results["RelatedTopics"] as? [[String: Any]]
                
                for topic in relatedTopics! {
                    let text = topic["Text"] as? String
                    if text == nil {
                        break
                    }
                    print(text ?? "no Text found")
                    let stringURL = topic["FirstURL"] as? String
                    let firstURL = NSURL(string: stringURL!)
                    
                    let tempResult = SearchResult(searchString: searchString!, firstURL: firstURL! as URL, text: text!)
                    tempResultsArray.append(tempResult)
                    
                }

                
                self.allResults = tempResultsArray
                
                completion(self.allResults)
                
                
                
                
            } catch {
                print("error serializing JSON: \(error)")
            }
        })
        
        // Tasks start off in suspended state, we need to kick it off
        task.resume()
    }

    
    
    
}
