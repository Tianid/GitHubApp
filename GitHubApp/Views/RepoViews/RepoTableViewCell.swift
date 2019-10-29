//
//  RepoTableViewCell.swift
//  GitHubApp
//
//  Created by Tianid on 26.10.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    @IBOutlet weak var entityTypeImageView: UIImageView!
    @IBOutlet weak var entityNameLabel: UILabel!
    
    var viewModel: RepoCellViewModelType? {
        didSet {
            setupCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupCell() {
        guard let repo = viewModel?.repoFile else { return }
        switch repo.type {
        case RepoEntityType.file.rawValue:
            self.imageView?.image = UIImage(named: EntityIconsName.fileIconName.rawValue )
        case RepoEntityType.dir.rawValue:
            self.imageView?.image = UIImage(named: EntityIconsName.folderIconName.rawValue)
        default:
            break
        }
        self.entityNameLabel.text = repo.name
        self.selectionStyle = .none
    }
}
