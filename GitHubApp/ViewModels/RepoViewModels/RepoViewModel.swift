//
//  DetailsViewModel.swift
//  GitHubApp
//
//  Created by Tianid on 25.10.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation


class RepoViewModel: RepoViewModelType {
    var repoFullName: String?
    var repoName: String?
    var repoFiles: [RepoFiles]?
    var path: String
    var contentUrl: String
    var updateTable: (() -> ())?
    
    init(path: String, contentUrl:String) {
        self.path = path
        self.contentUrl = contentUrl
    }
    
    func downloadRepoData() {
        NetworkManage.shared.downloadRepoDataByUrl(url: URL(string:self.contentUrl)!) { [weak self] ( repoFiles) in
            self?.repoFiles = repoFiles
            self?.updateTable?()
        }
    }
    
    func getCellViewModel(indexPath: IndexPath) -> RepoCellViewModelType? {
        guard let singleRepoFile = repoFiles?[indexPath.row] else { return nil }
        let cellViewModel = RepoCellViewModel(repoFile: singleRepoFile)
        return cellViewModel
    }

    
    
}
