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
    
    var token: String?
    
    func downloadRepos(token: String?, complitionHandler: @escaping ([Repo]?, Error?) -> ()) {
        guard let url = getUrl() else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
                let repos = try JSONDecoder().decode([Repo].self, from: data)
                complitionHandler(repos, nil)
            } catch {
                print(#function)
                complitionHandler(nil, error)
            }
        }.resume()
    }
    
    func downloadRepoDataByUrl(url: URL, complitionHandler: @escaping (([RepoFiles]?, Error?) -> ())) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
                let repoFiles = try JSONDecoder().decode([RepoFiles].self, from: data)
                complitionHandler(repoFiles, nil)
                
            } catch {
                print(#function)
                print(error)
                complitionHandler(nil, error)
            }
        }.resume()
    }
    
    func downloadRepoFileContent(url: URL, complitionHandler: @escaping ((RepoFiles?, Error?) -> ())) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let repoFiles = try JSONDecoder().decode(RepoFiles.self, from: data)
                complitionHandler(repoFiles,nil)
                
            } catch {
                print(#function)
                print(error)
                complitionHandler(nil, error)
            }
        }.resume()
    }
    
    func downloadRepoBranches(url: URL, complitionHandler: @escaping (([Branch]?, Error?) -> ())) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
                let branches = try JSONDecoder().decode([Branch].self, from: data)
                complitionHandler(branches,nil)
            } catch {
                print(#function)
                print(error)
                complitionHandler(nil,error)
            }
        }.resume()
    }
    
    private func getUrl() -> URL? {
        var component = URLComponents(string: REPOS_URL_CONST)
        component?.queryItems = [
            URLQueryItem(name: "visibility", value: "all"),
            URLQueryItem(name: "access_token", value: "\(token!)"),
        ]
        return component?.url
    }
}
