//
//  MyTableViewCellModel.swift
//  GitHubApp
//
//  Created by Tianid on 24.10.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation


class MyTableViewCellViweModel: MyTableViewCellModelType {
    var repo: Repo
    
    init(singleRepo: Repo) {
        self.repo = singleRepo
    }
}
