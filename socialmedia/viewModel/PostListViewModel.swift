//
//  PostListViewModel.swift
//  socialmedia
//
//  Created by Pran Kishore on 14/04/24.
//

import Foundation

class PostListViewModel {
    
    internal init(author: Author? = nil, postList: [MediaPost] = []) {
        self.author = author ?? Author(authorName: "test", authorUserName: "check", authorImagePath: nil)
        self.postList = postList
    }
    
    private var author: Author
    private var postList: [MediaPost]
    private var authorsList: [Author] = []
    var selectedChangeFormat = PostViewMode.mine // Default to mine
    
    // MARK: - table view methods
    func mediaPost(at indexPath: IndexPath) -> PostCellViewModel {
        let stock = updatePostList[indexPath.row]
        return stock
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return updatePostList.count
    }
    
    func addPost(_ post: MediaPost) {
        postList.append(post)
        setAuthorList()
    }

    func authorsforRows(in component: Int) -> Int {
        authorsList.count
    }
    
    func authorAt(index: Int) -> String {
        authorsList[index].authorName
    }
    
    func setAuthor(index: Int) {
        author = authorsList[index]
    }
    
    func loadData() {
        let decoder = JSONDecoder()
        guard let path = Bundle.main.url(forResource: "post-list", withExtension: "json"),
              let data = try? Data(contentsOf: path) else { return }
        do {
            let jsonData = try decoder.decode(Posts.self, from: data)
            postList = jsonData.list
            author = jsonData.list.first!.author
            setAuthorList()
            return
        } catch {
            print(error)
            return
        }
    }
}

extension PostListViewModel {
    private var updatePostList: [MediaPost] {
        var list = postList
        if selectedChangeFormat == .mine {
            list = postList.filter({$0.author.authorUserName == author.authorUserName})
        }
        return list
    }
    
    private func setAuthorList() {
        let authorList = postList.compactMap({$0.author})
        let authorSet = Set<Author>(authorList)
        authorsList = Array(authorSet)
    }
    
    var currentAuthor: Author {
        author
    }
}
