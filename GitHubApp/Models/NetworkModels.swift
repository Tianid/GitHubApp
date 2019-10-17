//
//  NetworkModels.swift
//  GitHubApp
//
//  Created by Tianid on 17.10.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation

struct Repo: Codable {
    let id: Int
    let name: String
    let fullName: String
    let language: String
    let openIssuesCount: Int
    let forks: Int
    let watchers: Int
    let creationDate: String
    let updatingDate: String
    let pushingDate: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case language
        case openIssuesCount = "open_issues_count"
        case forks
        case watchers
        case creationDate = "created_at"
        case updatingDate = "updated_at"
        case pushingDate = "pushed_at"
        
    }
}
