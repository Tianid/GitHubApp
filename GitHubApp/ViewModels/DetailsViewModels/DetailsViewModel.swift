//
//  DetailsViewModel.swift
//  GitHubApp
//
//  Created by Tianid on 26.10.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation


class DetailiewModel: DetailsViewModelType {
    var repoFile: RepoFiles
    var content: String?
    var updateTextView: (() -> ())?
    var currentBranch: String?
    
    init(repoFile: RepoFiles, currentBranch: String) {
        self.repoFile = repoFile
        self.currentBranch = currentBranch
    }
    
    func downloadRepoFileContent() {
        guard let url = getUrlRequest(string: repoFile.links.`self`) else { return }
        NetworkManage.shared.downloadRepoFileContent(url: url) { [weak self] (content, error) in
            if let content = content?.content {
                self?.content = content
                self?.updateTextView?()
            }
        }
    }
    
    private func getUrlRequest(string: String) -> URL? {
        var component = URLComponents(string: repoFile.links.`self`)
        component?.queryItems = [
            URLQueryItem(name: "access_token", value: "\(NetworkManage.shared.token!)"),
            URLQueryItem(name: "ref", value: currentBranch!),
        ]
        let urls = component?.url
        return urls
    }
}
