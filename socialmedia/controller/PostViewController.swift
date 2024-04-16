//
//  PostViewController.swift
//  socialmedia
//
//  Created by Pran Kishore on 11/04/24.
//


import UIKit
import MobileCoreServices
import AVFoundation
import Photos

class PostViewController: UIViewController {
    
    var completionHandler: ((MediaPost) -> Void)?
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postMessageView: UITextView!
    
    private var postImagePath: String?
    private var viewModel: PostViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTextView()
        setupViewAppearence()
    }
    
    func setupViewModel(_ viewModel: PostViewModel) {
        self.viewModel = viewModel
    }
    
    func setupTextView() {
        setPlaceHolder()
        postMessageView.delegate = self
    }
    
    func setPlaceHolder() {
        postMessageView.text = Constants.Text.postMessagePlaceHolder
        postMessageView.textColor = .lightGray
    }
    
    func setupViewAppearence() {
        postImageView.layer.borderColor = UIColor.lightGray.cgColor
        postImageView.layer.borderWidth = 1.0
        postMessageView.layer.borderColor = UIColor.gray.cgColor
        postMessageView.layer.borderWidth = 1.0
    }
}

// MARK: IBActions
extension PostViewController {
    @IBAction func selectImageAction(_ sender: UIButton) {
        uploadDocumentsActionSheet()
    }
    
    @IBAction func createPostAction(_ sender: UIButton) {
        do {
            let mediaPost = try viewModel.createPostWith(postMessageView.text, postImagePath)
            completionHandler?(mediaPost)
            navigationController?.popViewController(animated: true)
        } catch let error as PostValidationError {
            showErrorAlert(message: error.errorMessage)
        } catch {
            showErrorAlert(message: Constants.Text.unknownError)
        }
    }
}

// MARK: Methods
extension PostViewController {
    func uploadDocumentsActionSheet() {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        let saveAction = UIAlertAction(title: "Camera", style: .default, handler: { (_: UIAlertAction!) -> Void in
            self.camera()
        })
        let deleteAction = UIAlertAction(title: "Gallery", style: .default, handler: { (_: UIAlertAction!) -> Void in
            self.checkPhotoLibraryPermission()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (_: UIAlertAction!) -> Void in
        })
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        present(optionMenu, animated: true, completion: nil)
    }
    
    func checkPhotoLibraryPermission() {
        PHPhotoLibrary.requestAuthorization { (status) in
            if status == .authorized {
                DispatchQueue.main.async {
                    self.photoLibrary()
                }
            } else {
                self.showSuccessAlert(message: Constants.Text.phoneGalleryAccess) { (_) in
                    UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: { (_) in
                    })
                }
            }
        }
    }
    
    func camera() {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerController.SourceType.camera
        myPickerController.modalPresentationStyle = .fullScreen
        present(myPickerController, animated: true, completion: nil)
    }

    func photoLibrary() {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        myPickerController.modalPresentationStyle = .fullScreen
        present(myPickerController, animated: true, completion: nil)
    }
}

// MARK: UIImagePickerControllerDelegate
extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = image(for: info) {
            picker.dismiss(animated: true, completion: nil)
            setImage(image)
        } else {
            print(Constants.Text.unknownError)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func image(for info: [UIImagePickerController.InfoKey: Any]) -> UIImage? {
        if let image = info[.editedImage] as? UIImage {
            return image
        } else if let image = info[.originalImage] as? UIImage {
            return image
        } else {
            return nil
        }
    }
    func setImage(_ image: UIImage) {
        postImageView.image = image
        postImagePath = viewModel.imageManager.saveImageAtPath(image: image)
    }
}

// MARK: UITextViewDelegate
extension PostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            setPlaceHolder()
        }
    }
}
