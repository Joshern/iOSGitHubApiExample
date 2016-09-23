//
//  Respository.swift
//  Assignment GitHub
//
//  Created by Josh on 9/23/16.
//  Copyright © 2016 Josh. All rights reserved.
//

import UIKit

let KeyId = "id"
let KeyRepoName = "name"
let KeyLanguage = "language"
let KeyCreatedAt = "created_at"
let KeyDescription = "description"
let KeyOwner = "owner"
let KeyLogin = "login"

class Repository {
    var id: Int?
    var name: String?
    var language: String?
    var createdAt: String?
    var owner: String?
    var repoDescription: String?
    
    
    
    init(id: Int?, name: String?, language: String?, createdAt: String?, owner: String?, repoDescription: String?) {
        self.id = id
        self.name = name
        self.language = language
        self.createdAt = createdAt
        self.owner = owner
        self.repoDescription = repoDescription
    }
    
   class func parseRepository(json: [String : AnyObject?]) -> Repository{
    
        let id = json[KeyId] as? Int
        let name = json[KeyRepoName] as? String
        let language = json[KeyLanguage] as? String
        let createdAt = json[KeyCreatedAt] as? String
        let owner = json[KeyOwner] as? [String : AnyObject]
        let user =  owner![KeyLogin] as? String
        var repoDescription = json[KeyDescription] as? String
    
        if let _ = repoDescription where repoDescription!.isEmpty {
            repoDescription = "No Description"
        }

       return Repository(id: id, name: name, language: language, createdAt: createdAt, owner: user, repoDescription: repoDescription)
    }
}
