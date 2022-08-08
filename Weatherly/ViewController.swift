//
//  ViewController.swift
//  Weatherly
//
//  Created by McKenzie Macdonald on 8/8/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var conditionImageView: UIImageView!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var tempUnitLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Textfield should report back to ViewController if the user interacts
        searchTextField.delegate = self
        
    }

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        if let userText = searchTextField.text {
            print(userText)
        }
    }
    
}

// MARK: TextFieldDelegate Methods

extension ViewController: UITextFieldDelegate {
    /// Says what to do when return button is pressed. Returns a Bool for if it should process that return.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        if let userText = searchTextField.text {
            print(userText)
        }
        return true
    }
    
    /// Runs when a user tries to deslect the textField
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != nil && textField.text != "" {
            textField.placeholder = "Search"
            return true
        } else {
            textField.placeholder = "Enter a city"
            return false
        }
    }
    
    /// Clear textField when user is done editing
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.text = ""
    }
}
