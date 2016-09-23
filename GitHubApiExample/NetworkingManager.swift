//
//  NetworkingManager.swift
//  GitHubApi
//
//  Created by Josh on 9/23/16.
//  Copyright © 2016 Josh. All rights reserved.
//

import UIKit

let UrlStringRepositories = "https://api.github.com/users/%@/repos"
let UrlStringUser = "https://api.github.com/users/%@"

class NetworkingManager {
    
    static let sharedInstance = NetworkingManager()
    
    func downloadRepositories(user: String, completion:(data: Repository?)-> Void) {
        let session = NSURLSession.sharedSession()
        
        let url = NSURL(string: String(format: UrlStringRepositories, user))
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            if error != nil {
                print(error!.localizedDescription)
            }
            else {
                if data != nil {
                    do {
                        let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? [[String:AnyObject]]
                        
                        if let jsonData = jsonData{
                            for json in jsonData {
                                // let item = json as? [String:AnyObject]
                                let repo = Repository.parseRepository(json)
                                
                                completion(data: repo)
                            }
                        } else{
                            completion(data: nil)

                        }
                        
                    } catch {
                        // Handle exception
                    }

                } else {
                    completion(data: nil)
                    print("No Data")
                }
            }
        }
        
        task.resume()
    }
    
    
    func downloadUserData(user: String, completion:(data: User?)-> Void) {
        let session = NSURLSession.sharedSession()
        
        let url = NSURL(string: String(format: UrlStringUser, user))
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            if error != nil {
                print(error!.localizedDescription)
            }
            else {
                if data != nil {
                    do {
                        let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? [String:AnyObject]
                        
                        let user = User.parseUser(jsonData!)
                        completion(data: user)
                    } catch {
                        print(error)
                    }
                    
                } else {
                    completion(data: nil)
                    print("No Data")
                }
            }
        }
        task.resume()
    }

    
}
