//
//  MyTableViewCell.swift
//  GitHubApp
//
//  Created by Tianid on 17.10.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    var viewModel: MyTableViewCellModelType? {
        didSet {
            setupCellData()
        }
    }

    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var languageColorView: UIView!
    @IBOutlet weak var languageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupCellData() {
//        repoNameLabel.minimumScaleFactor = 30
//        repoNameLabel.adjustsFontSizeToFitWidth = true
//        layoutIfNeeded()
        self.repoNameLabel.text = viewModel?.repo.fullName
        guard let language = viewModel?.repo.language else {
            self.languageColorView.isHidden = true
            self.languageLabel.isHidden = true
            return
        }
        self.languageColorView.isHidden = false
        self.languageLabel.isHidden = false
        self.languageColorView.layer.cornerRadius = self.languageColorView.frame.width / 2
        self.languageColorView.layer.borderWidth = 1
        
        switch language {
        case Colors.black.rawValue:
            self.languageColorView.backgroundColor = .black
        case Colors.blue.rawValue:
            self.languageColorView.backgroundColor = .blue
        case Colors.brown.rawValue:
            self.languageColorView.backgroundColor = .brown
        case Colors.yellow.rawValue:
            self.languageColorView.backgroundColor = .yellow
        case Colors.orange.rawValue:
            self.languageColorView.backgroundColor = .orange
        default:
            self.languageColorView.backgroundColor = .green
        }
        self.languageLabel.text = viewModel?.repo.language
    }
}
