//
//  PostModel.swift
//  socialmedia
//
//  Created by Pran Kishore on 13/04/24.
//

import Foundation

struct Author: Codable {
    let authorName: String
    let authorUserName: String
    let authorImagePath: String?
}

extension Author: Hashable {
    static func == (lhs: Author, rhs: Author) -> Bool {
        return lhs.authorUserName == rhs.authorUserName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(authorUserName)
    }
}


struct PostMessage: Codable {
    let message: String
    let messageImagePath: String
}

struct MediaPost: Codable {
    let author: Author
    let message: PostMessage
}

struct Posts: Codable {
    let list: [MediaPost]
}


enum PostValidationError: Error {
    case imageNotFound
    case messageNotFound
    
    var errorMessage: String {
        switch self {
        case .imageNotFound:
            return "Please provide image"
        case .messageNotFound:
            return "Please provide a post message"
        }
    }
}


extension MediaPost: PostCellViewModel {
    var postAuthorImagePath: URL? {
        URL(string: author.authorImagePath ?? "")
    }
    
    var postMessageImagePath: URL? {
        URL(string: message.messageImagePath)
    }
    
    var postHeaderText: String {
        "\(author.authorName)  @\(author.authorUserName)"
    }
    
    var postSubheader: String {
        message.message
    }
}
