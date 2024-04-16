//
//  PostListViewController.swift
//  socialmedia
//
//  Created by Pran Kishore on 11/04/24.
//

import UIKit

class PostListViewController: UITableViewController {

    private var viewModel: PostListViewModel!
    
    // MARK: - view life cycle and setup
    override func viewDidLoad() {
        super.viewDidLoad()
        setuptitleNaivagtionBar()
        setupTableView()
        viewModel = PostListViewModel()
        viewModel.loadData()
    }
    
    func setuptitleNaivagtionBar() {
        title = "Posts"
        let profileButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(postButtonTapped))
        navigationItem.rightBarButtonItem = profileButton
    }
    
    @objc func postButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toPostViewController", sender: self)
    }
    
    
    func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedSectionHeaderHeight = 60.0
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        let tableViewCellNib = UINib(nibName: PostListTableViewCell.reuseIdentifer, bundle: Bundle.main)
        tableView.register(tableViewCellNib, forCellReuseIdentifier: PostListTableViewCell.reuseIdentifer)
        tableView.register(PostSelectionTableHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: PostSelectionTableHeaderView.reuseIdentifer)
        tableView.register(PostUserTableViewHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: PostUserTableViewHeaderView.reuseIdentifer)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostListTableViewCell.reuseIdentifer, for: indexPath)
        let cellInfo = viewModel.mediaPost(at: indexPath)
        if let postCell = cell as? PostListTableViewCell {
            postCell.setcell(with: cellInfo)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: PostSelectionTableHeaderView.reuseIdentifer) as? PostSelectionTableHeaderView else {
            return nil
        }
        header.delegate = self
        return header
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: PostUserTableViewHeaderView.reuseIdentifer) as? PostUserTableViewHeaderView else {
            return nil
        }
        footer.delegate = self
        return footer
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PostViewController {
            let imageManager = ImageManager()
            let viewModel = PostViewModel(author: viewModel.currentAuthor, imageManager: imageManager)
            vc.setupViewModel(viewModel)
            vc.completionHandler = { [weak self] post in
                self?.viewModel.addPost(post)
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - FormatTableHeaderViewDelegate
extension PostListViewController: PostSelectionTableHeaderViewDelegate {
    func didChange(to format: PostViewMode) {
        viewModel.selectedChangeFormat = format
        tableView.reloadData()
    }
}

extension PostListViewController: PostUserTableViewHeaderViewDelegate {
    func willSelectAuthor() {
        // Launch the picker view to select the list of authors.
        let pickerViewManager = PostPickerViewManager()
        pickerViewManager.setup(dataSource: self, delegate: self)
        pickerViewManager.presentPicker(over: self)
    }
}


extension PostListViewController: PostPickerDataSource {
    func itemAt(index: Int) -> String {
        viewModel.authorAt(index: index)
    }
    
    func itemsforRows(in component: Int) -> Int {
        viewModel.authorsforRows(in: component)
    }
}

extension PostListViewController: PostPickerDelegate {
    func didSelectItemAt(index: Int) {
        viewModel.setAuthor(index: index)
        if viewModel.selectedChangeFormat == .mine {
            tableView.reloadData()
        }
    }
}
