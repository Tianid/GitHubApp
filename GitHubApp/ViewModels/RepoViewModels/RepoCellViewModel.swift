//
//  RepoCellViewModel.swift
//  GitHubApp
//
//  Created by Tianid on 26.10.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation

class RepoCellViewModel: RepoCellViewModelType {
    var repoFile: RepoFiles?
    
    init(repoFile: RepoFiles) {
        self.repoFile = repoFile
    }
}
