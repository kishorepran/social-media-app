//
//  PostListTableViewCell.swift
//  socialmedia
//
//  Created by Pran Kishore on 14/04/24.
//

import UIKit
import Kingfisher

class PostListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblPostAuthor: UILabel!
    @IBOutlet weak var lblPostMessage: UILabel!
    @IBOutlet weak var imageViewPostAuthor: UIImageView!
    @IBOutlet weak var imageviewPostImage: UIImageView!
    static let reuseIdentifer = "PostListTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageViewPostAuthor.layer.cornerRadius = 25.0
        imageViewPostAuthor.layer.masksToBounds = true
    }

    func setcell(with viewModel: PostCellViewModel) {
        lblPostAuthor.text = viewModel.postHeaderText
        lblPostMessage.text = viewModel.postSubheader
        let authorPlaceholderImage = UIImage(named: "sampleAuthor")
        let messagePlaceHolderImage = UIImage(named: "sample")
        imageviewPostImage.kf.setImage(with: viewModel.postMessageImagePath, placeholder: messagePlaceHolderImage)
        imageViewPostAuthor.kf.setImage(with: viewModel.postAuthorImagePath, placeholder: authorPlaceholderImage)
    }
}
