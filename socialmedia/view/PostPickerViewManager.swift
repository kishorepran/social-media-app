//
//  PostPickerViewManager.swift
//  socialmedia
//
//  Created by Pran Kishore on 15/04/24.
//

import UIKit

protocol PostPickerDelegate: AnyObject {
    func didSelectItemAt(index: Int)
}

protocol PostPickerDataSource: AnyObject {
    func itemAt(index: Int) -> String
    func itemsforRows(in component: Int) -> Int
}

class PostPickerViewManager: NSObject {

    private let pickerView = UIPickerView()
    private var pickerData: [String]?
    private var selectedRow = 0
    private weak var delegate: PostPickerDelegate?
    private weak var dataSource: PostPickerDataSource?
    
    private let alertController: UIAlertController = {
        let alertController = UIAlertController(title: "Select User", message: "", preferredStyle: .actionSheet)
        return alertController
    }()
    
    override init() {
        super.init()
        setPickerView()
        setupEnclosingViewController()
    }

    private func setPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
        
    }
    
    private func setupEnclosingViewController() {
        let viewController = UIViewController()
        viewController.preferredContentSize = CGSize(width: Constants.UI.screenWidth, height: Constants.UI.screenHeight)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(pickerView)
        let margins = viewController.view.layoutMarginsGuide
        pickerView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
        
        
        alertController.setValue(viewController, forKey: "contentViewController")
        let okAction = UIAlertAction(title: "Done", style: .default) { (_ : UIAlertAction) -> Void in
            self.doneBtnClicked()
        }
        let cancelAction = UIAlertAction(title: "Cencel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
    }
    
    
    func setup(dataSource: PostPickerDataSource,delegate: PostPickerDelegate) {
        self.dataSource = dataSource
        self.delegate = delegate
    }
    
    func presentPicker(over viewController: UIViewController) {
        viewController.present(alertController, animated: true)
    }

    func doneBtnClicked() {
        delegate?.didSelectItemAt(index: selectedRow)
    }
}

extension PostPickerViewManager: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource?.itemAt(index: row)
    }
}

extension PostPickerViewManager: UIPickerViewDataSource {
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource?.itemsforRows(in: component) ?? 0
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
}
