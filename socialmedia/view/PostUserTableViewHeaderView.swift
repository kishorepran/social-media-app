//
//  PostUserTableViewHeaderView.swift
//  socialmedia
//
//  Created by Pran Kishore on 15/04/24.
//

import Foundation

import UIKit

protocol PostUserTableViewHeaderViewDelegate: AnyObject {
    func willSelectAuthor()
}

class PostUserTableViewHeaderView: UITableViewHeaderFooterView {
    
    static let reuseIdentifer = "PostUserTableViewHeaderView"
    weak var delegate: PostUserTableViewHeaderViewDelegate?
    private let authorSelectionButton = UIButton(type: .system)
    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        authorSelectionButton.addTarget(self, action: #selector(didSelect(_:)), for: .touchUpInside)
        authorSelectionButton.setTitle("Select Author", for: .normal)
        authorSelectionButton.tintColor = .white
        authorSelectionButton.backgroundColor = .systemBlue
        authorSelectionButton.layer.cornerRadius = 10   
        authorSelectionButton.layer.masksToBounds = true
        contentView.backgroundColor = .white
        //Layout changes
        authorSelectionButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(authorSelectionButton)
        let margins = contentView.layoutMarginsGuide
        authorSelectionButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: 8).isActive = true
        authorSelectionButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -8).isActive = true
        authorSelectionButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -32).isActive = true
        authorSelectionButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 32).isActive = true
    }
    
    @objc func didSelect(_ button: UIButton) {
        delegate?.willSelectAuthor()
    }
}
