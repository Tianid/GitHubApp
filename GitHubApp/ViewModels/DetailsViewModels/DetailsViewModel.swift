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
    
    init(repoFile: RepoFiles) {
        self.repoFile = repoFile
    }
    
    func downloadRepoFileContent() {
        guard let url = URL(string: repoFile.links.`self`) else { return }
        NetworkManage.shared.downloadRepoFileContent(url: url) { [weak self] (content, error) in
            if let content = content?.content {
                self?.content = content
                self?.updateTextView?()
            }
        }
    }
}
