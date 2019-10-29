//
//  DetailsViewModelType.swift
//  GitHubApp
//
//  Created by Tianid on 26.10.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation

protocol DetailsViewModelType {
    var repoFile: RepoFiles { get set }
    var content: String? { get set }
    var updateTextView: (() -> ())? { get set }
    var currentBranch: String? { get set }
    
    func downloadRepoFileContent()
}
