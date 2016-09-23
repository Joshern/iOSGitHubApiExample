//
//  RepoIssues.swift
//  Assignment GitHub
//
//  Created by Josh on 9/23/16.
//  Copyright © 2016 Josh. All rights reserved.
//

import UIKit


let KeyAvatarUrl = "avatar_url"
let KeyName = "name"
let KeyLocation = "location"
let KeyEmail = "email"

class User {

    var name: String?
    var avatarUrl: String?
    var email: String?
    var location: String?
    var avatarImage: UIImage?
    
    
    init(name: String?, avatarUrl: String?, email: String?, location: String?) {
        self.name = name
        self.avatarUrl = avatarUrl
        self.email = email
        self.location = location
    }

    class func parseUser(json: [String: AnyObject?]) -> User{
        
        let name = json[KeyName] as? String
        let url = json[KeyAvatarUrl] as? String
        let location = json[KeyLocation] as? String
        let email = json[KeyEmail] as? String
        
        return User(name: name, avatarUrl: url, email: email, location: location)
    }
    
    
    func downloadImage(completion:(img: UIImage?)-> Void) {
        let session = NSURLSession.sharedSession()
        if let avatarUrl = self.avatarUrl{
            let url = NSURL(string: avatarUrl)
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "GET"
            
            let task = session.dataTaskWithRequest(request) {
                (data, response, error) -> Void in
                if error != nil {
                    print(error!.localizedDescription)
                }
                else {
                    if let data = data {
                        let img = UIImage(data: data)
                        completion(img: img)
                        
                    } else {
                        completion(img: nil)
                        print("No Data")
                    }
                }
            }
            task.resume()
        }
    }
    

    
    
}
