//
//  ViewController.swift
//  genderise
//
//  Created by Vivaldi Ibelio Chandra on 16/2/19.
//  Copyright © 2019 Vivaldi Ibelio Chandra. All rights reserved.
//

import UIKit
import Alamofire

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
        let baseUrl: String = "https://api.genderize.io/"
        let parameter: Parameters = ["name": parseNameText(text!)!]
        
        AF.request(baseUrl, parameters: parameter).validate().responseJSON { response in
            switch response.result {
            case .success:
                let jsonData = response.result.value
                debugPrint(jsonData)
            case .failure(let error):
                self.onError(error)
            }
        }
    }
    
    func onError(_ error: Any) {
        // TODO: Handle error
    }

    func showAlertMessage(_ text: String?) {
        if (text ?? "").isEmpty {
            return
        }
        
        let alert = UIAlertController(title: "My Alert", message: text, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func parseNameText(_ name: String) -> (String?) {
        let nameArr = name.components(separatedBy: " ")
        return nameArr[0]
    }
}

