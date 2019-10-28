//
//  DetailsViewModel.swift
//  GitHubApp
//
//  Created by Tianid on 25.10.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation

protocol RepoViewModelType {
    var repoFiles: [RepoFiles]? { get set }
    var contentUrl: String { get set }
    var updateTable: (() -> ())? { get set }
    var currentBranch: String? { get set }
    var defaultBranch: String? { get set }
    var branchesUrl: String? { get set }
    var branchesArray: [Branch]? { get set }
    
    
    func downloadRepoData()
    func getCellViewModel(indexPath: IndexPath) -> RepoCellViewModelType?
    func setContentUrl(url: String)

    
}
