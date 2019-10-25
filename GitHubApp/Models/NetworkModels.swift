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
    let contentsUrl: String
    
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
        case contentsUrl = "contents_url"
        
    }
}

struct RepoFiles: Codable {
    let name: String
    let path: String
    let size: Int
    let type: String
    let links: Links
    let content: String?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case path
        case size
        case type
        case links = "_links"
        case content
    }
}

struct Links: Codable {
    let `self`: String
}
