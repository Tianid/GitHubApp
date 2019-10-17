//
//  NetworkManager.swift
//  GitHubApp
//
//  Created by Tianid on 17.10.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation


class NetworkManage {
    static let shared: NetworkManage = NetworkManage()
    
    
    func downloadRepos(token: String?, complitionHandler: @escaping ([Repo]?, Error?) -> ()) {
        let component = URLComponents(string: REPOS_URL_CONST)
        let url = component?.url
        var urlRequest = URLRequest(url: url!)
        guard let token = token else { return }
        urlRequest.setValue("token \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
                let repos = try JSONDecoder().decode([Repo].self, from: data)
                complitionHandler(repos, nil)
            } catch {
                complitionHandler(nil, error)
            }
        }.resume()
    }
}
