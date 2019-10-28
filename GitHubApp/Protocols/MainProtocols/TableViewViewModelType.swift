//
//  TableViewViewModelType.swift
//  GitHubApp
//
//  Created by Tianid on 17.10.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation


protocol TableViewViewModelType {
    var repos: [Repo]? { get set }
    var token: String? { get set }
    var updateTable: (() -> ())? { get set }

    func downloadRepos(token: String?)
    func getRepos() -> [Repo]?
    func getCellViewModel(indexpath: IndexPath) -> MyTableViewCellModelType
    func numberOfRows() -> Int?

    
    
}
