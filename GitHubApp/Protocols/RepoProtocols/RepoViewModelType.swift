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
    var repoFullName: String? { get set }
    var repoName: String? { get set }
    var path: String { get set }
    var contentUrl: String { get set }
    var updateTable: (() -> ())? { get set }
    
    func downloadRepoData()
    func getCellViewModel(indexPath: IndexPath) -> RepoCellViewModelType?

    
}
