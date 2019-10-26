//
//  DetailsViewController.swift
//  GitHubApp
//
//  Created by Tianid on 25.10.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController, ScreenType {

    private var myTableView: UITableView!
    private let cellIdentifier = "RepoCellIdent"

    var viewModel: RepoViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMyTableView()
        viewModel?.updateTable = { [weak self] in
            DispatchQueue.main.async {
                self?.myTableView.reloadData()
            }
        }
        viewModel?.downloadRepoData()
        // Do any additional setup after loading the view.
    }
    
    
   private func setupMyTableView() {
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
//    myTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    myTableView.register(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)

    
    }
}

extension RepoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.repoFiles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = myTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RepoTableViewCell else { return UITableViewCell() }
        cell.viewModel = viewModel?.getCellViewModel(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let newRepoVC = prepareForShowNextScreen(indexPath: indexPath) else { return }
        navigationController?.pushViewController(newRepoVC as! UIViewController, animated: true)
    }
    
    
    private func prepareForShowNextScreen(indexPath: IndexPath) -> ScreenType?  {
        guard let repoFile = viewModel?.repoFiles?[indexPath.row] else { return nil }
        if repoFile.type == RepoEntityType.dir.rawValue {
            let newRepoVC = RepoViewController()
            newRepoVC.title = repoFile.name
            let url = repoFile.links.`self`
            newRepoVC.viewModel = RepoViewModel(path: repoFile.name, contentUrl: url)
            return newRepoVC
        } else if repoFile.type == RepoEntityType.file.rawValue {
            let newDetailsVC = DetailsViewController()
            newDetailsVC.title = repoFile.name
            newDetailsVC.viewModel = DetailiewModel(repoFile: repoFile)
            return newDetailsVC
        }
        return nil
    }
}
