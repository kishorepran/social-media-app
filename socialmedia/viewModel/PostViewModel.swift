//
//  PostViewModel.swift
//  socialmedia
//
//  Created by Pran Kishore on 13/04/24.
//

import Foundation


class PostViewModel {
    let author: Author
    let imageManager: ImageSaving
    private (set) var post: MediaPost?
    
    init(author: Author, imageManager: ImageSaving) {
        self.author = author
        self.imageManager = imageManager
    }
    
    func createPostWith(_ message: String,_ imagePath: String?) throws -> MediaPost {
        guard let imagePath = imagePath, !imagePath.isEmpty else {
            throw PostValidationError.imageNotFound
        }
        
        guard !message.isEmpty else {
            throw PostValidationError.messageNotFound
        }
        
        let message = PostMessage(message: message, messageImagePath: imagePath)
        let mediaPost = MediaPost(author: author, message: message)
        post = mediaPost
        return mediaPost
    }
}
