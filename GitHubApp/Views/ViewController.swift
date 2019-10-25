//
//  ViewController.swift
//  GitHubApp
//
//  Created by Tianid on 17.10.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var myTableView: UITableView!
    private let cellIdentifier = "CellIdent"
    private var myTableViewModel: TableViewViewModelType!
    private var isFirstStart: Bool = true
    private var oAuthVC: OAuthViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMyTableView()
        myTableViewModel = TableViewModel()
        myTableViewModel.updateTable = { [weak self] in
            self?.updateTable()
        }
        oAuthVC = OAuthViewController(tableViewModel: myTableViewModel)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard isFirstStart else { return }
        isFirstStart = !isFirstStart
        present(oAuthVC!, animated: false, completion: nil)
        
    }
    

    
    func setUpMyTableView() {
        myTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(myTableView)
        NSLayoutConstraint.activate([
            myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            myTableView.topAnchor.constraint(equalTo: view.topAnchor),
            myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: self.cellIdentifier)
        myTableView.separatorStyle = .singleLine
        myTableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func updateTable() {
        DispatchQueue.main.async { [weak self] in
            self?.myTableView.reloadSections(IndexSet(integer: .zero), with: .fade)
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTableViewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MyTableViewCell
        cell?.selectionStyle = .none
        cell?.viewModel = myTableViewModel.getCellViewModel(indexpath: indexPath)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let repoVC = prepareForOpenRepoScreen(indexPath: indexPath) else { return }

        navigationController?.pushViewController(repoVC, animated: true)
    }
    
    func prepareForOpenRepoScreen(indexPath: IndexPath) -> RepoViewController? {
        guard let repo = myTableViewModel.repos?[indexPath.row] else { return nil }
        let repoVC = RepoViewController()
        repoVC.title = repo.name
        let url = repo.contentsUrl
        let contentUrl = url.prefix(url.count - 7)
        repoVC.viewModel = RepoViewModel(path: repo.name, contentUrl: String(contentUrl))
        return repoVC
    }
}





