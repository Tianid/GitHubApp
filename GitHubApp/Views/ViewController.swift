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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMyTableView()
        myTableViewModel = TableViewModel()
        myTableViewModel.updateTable = { [weak self] in
            self?.updateTable()
        }
        let oAuthVC = OAuthViewController(tableViewModel: myTableViewModel)
        present(oAuthVC, animated: false, completion: nil)
        // Do any additional setup after loading the view.
    }
    
    func setUpMyTableView() {
        myTableView = UITableView()
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
        myTableView.register(MyTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
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
        let cell = myTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
}




