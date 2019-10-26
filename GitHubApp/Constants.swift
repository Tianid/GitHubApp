//
//  Constants.swift
//  GitHubApp
//
//  Created by Tianid on 17.10.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation


public let OAUTH_ACCESS_TOKEN_URL_CONST = "https://github.com/login/oauth/access_token"
public let OAUTH_AUTHORIZE_URL_CONST = "https://github.com/login/oauth/authorize"
public let GISTS_URL_CONST = "https://api.github.com/gists"
public let CLIENT_ID_CONST = "a067162b6a4797097cff"
public let CLIENT_SECRET_CONST = "83e4d3612d9e1ece7c5b675ff52d1650c17f2b10"
public let SCHEME_CONST = "login"
public let REPOS_URL_CONST = "https://api.github.com/users/Tianid/repos"


enum RepoEntityType: String {
    case file = "file"
    case dir = "dir"
}

enum EntityIconsName: String {
    case fileIconName = "file_icon_1.png"
    case folderIconName = "folder_icon_1.png"
}

enum Colors: String {
    case brown = "Java"
    case blue = "Python"
    case orange = "Swift"
    case black = "C"
    case yellow = "JavaScript"
    
}
