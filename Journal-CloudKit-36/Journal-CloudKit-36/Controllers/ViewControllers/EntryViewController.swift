//
//  EntryViewController.swift
//  Journal-CloudKit-36
//
//  Created by Shean Bjoralt on 10/5/20.
//

import UIKit

class EntryViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    //MARK: - Properties
    
    var entry: Entry? {
        didSet {
            DispatchQueue.main.async {
                self.loadViewIfNeeded()
                self.updateViews()
            }
        }
    }
    
    //MARK: - Lifecycle Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

    }
    
    //MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty,
              let body = bodyTextView.text, !body.isEmpty else { return }
        
        EntryController.shared.createEntryWith(title: title, body: body) { (result) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    @IBAction func tapGenstureRecognizerTapped(_ sender: Any) {
        titleTextField.resignFirstResponder()
        bodyTextView.resignFirstResponder()
    }
    
    //MARK: - Helper Functions
    
    func updateViews() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
    }
    
}

extension EntryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
    }
}
