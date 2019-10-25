//
//  DetailsViewController.swift
//  GitHubApp
//
//  Created by Tianid on 25.10.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {

    private var myTableView: UITableView!
    private let cellIdentifier = "RepoCellIdent"

    var viewModel: RepoViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel?.updateTable = { [weak self] in
            DispatchQueue.main.async {
                self?.myTableView.reloadData()
            }
        }
        viewModel?.downloadRepoData()
        print("Details VC")
        // Do any additional setup after loading the view.
    }
    
    
   private func setup() {
    myTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
    myTableView?.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(myTableView)
    
    NSLayoutConstraint.activate([
        myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        myTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        myTableView.topAnchor.constraint(equalTo: view.topAnchor),
        myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    myTableView.dataSource = self
    myTableView.delegate = self
    myTableView.separatorStyle = .singleLine
    myTableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    
    // MARK: Dont forget about this:
    myTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    
    }
}

extension RepoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.repoFiles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as UITableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    
}
