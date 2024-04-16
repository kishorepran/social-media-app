//
//  PostSelectorTableHeaderView.swift
//  socialmedia
//
//  Created by Pran Kishore on 14/04/24.
//

import UIKit

protocol PostSelectionTableHeaderViewDelegate: AnyObject {
    func didChange(to format: PostViewMode)
}

class PostSelectionTableHeaderView: UITableViewHeaderFooterView {
    
    static let reuseIdentifer = "PostSelectionTableHeaderView"
    weak var delegate: PostSelectionTableHeaderViewDelegate?
    private let segmentControl = UISegmentedControl(items: [PostViewMode.mine.rawValue, PostViewMode.allPost.rawValue])
    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        segmentControl.addTarget(self, action: #selector(segmentControl(_:)), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 0 // Default to mine
        segmentControl.backgroundColor = .systemBlue
        backgroundConfiguration = .clear()
        //Layout changes
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(segmentControl)
        let margins = contentView.layoutMarginsGuide
        segmentControl.topAnchor.constraint(equalTo: margins.topAnchor, constant: 8).isActive = true
        segmentControl.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -8).isActive = true
        segmentControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -32).isActive = true
        segmentControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 32).isActive = true
    }
    
    @objc func segmentControl(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            delegate?.didChange(to: .mine)
        case 1:
            delegate?.didChange(to: .allPost)
        default:
            break
        }
    }
}
