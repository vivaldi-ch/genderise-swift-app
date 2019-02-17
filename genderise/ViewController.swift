//
//  ViewController.swift
//  genderise
//
//  Created by Vivaldi Ibelio Chandra on 16/2/19.
//  Copyright © 2019 Vivaldi Ibelio Chandra. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        nameTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        performApiCall(text: textField.text)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        performApiCall(text: textField.text)
    }
    
    func performApiCall(text: String?) {
        let baseUrl: String = "https://genderize.io/?name="
        let completeUrl = baseUrl + parseNameText(name: text!)!
    }

    func showAlertMessage(text: String?) {
        if (text ?? "").isEmpty {
            return
        }
        
        let alert = UIAlertController(title: "My Alert", message: text, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func parseNameText(name: String) -> (String?) {
        let nameArr = name.components(separatedBy: " ")
        let firstName: String = nameArr[0]
        
        return firstName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
}

