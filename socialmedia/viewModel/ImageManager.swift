//
//  ImageManager.swift
//  socialmedia
//
//  Created by Pran Kishore on 13/04/24.
//

import UIKit


/// describes image saving behaviour
protocol ImageSaving {
    /// it tries to save image. deteremines internally where the to save the image.
    /// - Parameter image: the image which will be saved
    /// - Returns: the path where the image is saved. nil if the image could not be saved.
    func saveImageAtPath(image: UIImage) -> String?
}

struct ImageManager: ImageSaving {
    func saveImageAtPath(image: UIImage) -> String? {
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        guard let jpegData = image.jpegData(compressionQuality: 0.8) else {
            return nil
        }
        
        do {
            try jpegData.write(to: imagePath)
            return imagePath.absoluteString
        } catch {
            return nil
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
