//
//  TableViewModel.swift
//  GitHubApp
//
//  Created by Tianid on 17.10.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation

class TableViewModel: TableViewViewModelType {
    
    var updateTable: (() -> ())?
    var repos: [Repo]?
    var token: String?
   
    
    func numberOfRows() -> Int? {
        return repos?.count
    }
    
    func getRepos() -> [Repo]? {
        return repos
    }
    
    func downloadRepos(token: String?) {
        print("start downloading")
        NetworkManage.shared.downloadRepos(token: token) { [weak self] (repo, error) in
            guard let repo = repo else { return }
            self?.repos = repo
            self?.updateTable!()
            print("Downloading is ended succesfully")
        }
    }
    
    func getCellViewModel(indexpath: IndexPath) -> MyTableViewCellModelType {
        let singleRepo = (self.repos?[indexpath.row])!
        let cellViewModel = MyTableViewCellViweModel(singleRepo: singleRepo)
        return cellViewModel
        
    }
}
