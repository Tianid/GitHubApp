//
//  DetailsViewModel.swift
//  GitHubApp
//
//  Created by Tianid on 25.10.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation


class RepoViewModel: RepoViewModelType {
    var branchesArray: [Branch]?
    var repoFiles: [RepoFiles]?
    var updateTable: (() -> ())?
    
    var contentUrl: String
    var currentBranch: String?
    var defaultBranch: String?
    var branchesUrl: String?
    
    init(currentBranch: String, defaultBranch: String, contentUrl: String, branchesUrl: String, branchesArray: [Branch]? = nil ) {
        self.contentUrl = contentUrl
        self.currentBranch = currentBranch
        self.defaultBranch = defaultBranch
        self.branchesUrl = branchesUrl
        self.branchesArray = branchesArray
    }
    
    func downloadRepoData() {
        guard let url = getUrlRequest(string:self.contentUrl) else { return }
        NetworkManage.shared.downloadRepoDataByUrl(url: url) { [weak self] ( repoFiles, error ) in
            guard let repoFiles = repoFiles else {
                self?.repoFiles = nil
                self?.updateTable?()
                return
            }
            self?.repoFiles = repoFiles
            guard (self?.branchesArray) == nil else { self?.updateTable?(); return }
            guard let url = self?.getUrlRequest(string: (self?.branchesUrl!)!) else { return }
            NetworkManage.shared.downloadRepoBranches(url: url) { [weak self] (branches, error) in
                guard let branches = branches else { return }
                self?.branchesArray = branches
                self?.updateTable?()
            }
        }
    }
    
    func getCellViewModel(indexPath: IndexPath) -> RepoCellViewModelType? {
        guard let singleRepoFile = repoFiles?[indexPath.row] else { return nil }
        let cellViewModel = RepoCellViewModel(repoFile: singleRepoFile)
        return cellViewModel
    }
    
    func setContentUrl(url: String) {
        self.contentUrl = url
    }
    
    private func getUrlRequest(string: String) -> URL? {
        var component = URLComponents(string: string)
        component?.queryItems = [
            URLQueryItem(name: "access_token", value: "\(NetworkManage.shared.token!)"),
            URLQueryItem(name: "ref", value: currentBranch!),
        ]
        let urls = component?.url
        return urls
    }
}
