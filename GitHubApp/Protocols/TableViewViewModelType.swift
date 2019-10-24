//
//  TableViewViewModelType.swift
//  GitHubApp
//
//  Created by Tianid on 17.10.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation


protocol TableViewViewModelType {
    func numberOfRows() -> Int?
    var repos: [Repo]? { get set }
    var token: String? { get set }
    func downloadRepos(token: String?)
    func getRepos() -> [Repo]?
    func getCellViewModel(indexpath: IndexPath) -> MyTableViewCellModelType
    
    var updateTable: (() -> ())? { get set }
    
}
