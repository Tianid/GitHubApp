//
//  OAuthViewController.swift
//  GitHubApp
//
//  Created by Tianid on 17.10.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import UIKit
import WebKit

class OAuthViewController: UIViewController {
    
    private let webView = WKWebView()
    private var oAuthCode = String()
    var tableViewModel: TableViewViewModelType!
    
    
    init(tableViewModel: TableViewViewModelType) {
        self.tableViewModel = tableViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        let request = prepareRequestForAuthorize()
        webView.load(request)
        webView.navigationDelegate = self
    }
    
    private func setupWebView() {
           webView.backgroundColor = .red
           webView.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(webView)
           
           NSLayoutConstraint.activate([
               webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               webView.topAnchor.constraint(equalTo: view.topAnchor),
               webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
           ])
       }

    private func prepareRequestForAuthorize() -> URLRequest {
        var urlComponents = URLComponents(string: OAUTH_AUTHORIZE_URL_CONST)
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: "\(CLIENT_ID_CONST)"),
            URLQueryItem(name: "scope", value: "repo,gist,user"),
            
        ]
        let request = URLRequest(url: urlComponents!.url!)
        
        return request
    }
    
    private var getRequestForToken: URLRequest? {
        guard var urlComponents = URLComponents(string: OAUTH_ACCESS_TOKEN_URL_CONST) else { return nil }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "\(CLIENT_ID_CONST)"),
            URLQueryItem(name: "client_secret", value: "\(CLIENT_SECRET_CONST)"),
            URLQueryItem(name: "code", value: "\(oAuthCode)")
        ]
        guard let url = urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        
        return request
    }
}

extension OAuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url, url.scheme == SCHEME_CONST {
            let targetString = url.absoluteString.replacingOccurrences(of: "#", with: "?")
            guard let components = URLComponents(string: targetString) else { return }
            if let code = components.queryItems?.first(where: {$0.name == "code"})?.value {
                oAuthCode = code
                guard let request = getRequestForToken else { return }
                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    guard let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] else { return }
                    guard let token = json["access_token"] as? String else { return }
                    NetworkManage.shared.token = token
                    self.tableViewModel.downloadRepos(token: token)
                }.resume()
            }
            dismiss(animated: true, completion: nil)
        }
        do {
            decisionHandler(.allow)
        }
    }
}
