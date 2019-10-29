//
//  DetailsViewController.swift
//  GitHubApp
//
//  Created by Tianid on 26.10.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, ScreenType {
    
    private var myTextView: UITextView!
    var viewModel: DetailsViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMyTextView()
        viewModel?.updateTextView = { [weak self] in
            self?.prepareUpdateFunc()
        }
        viewModel?.downloadRepoFileContent()
        // Do any additional setup after loading the view.
    }

    private func setupMyTextView() {
        myTextView = UITextView()
        myTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(myTextView)
        NSLayoutConstraint.activate([
            myTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            myTextView.topAnchor.constraint(equalTo: view.topAnchor),
            myTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        myTextView.isSelectable = false
        myTextView.isEditable = false
    }
    
    private func prepareUpdateFunc() {
        DispatchQueue.main.async {
            let result = Base64EncoderDecoder.base64Decoded(string: (self.viewModel?.content)!)
            guard let textFile = result else { return }
            self.myTextView.text = textFile
        }
    }
}
