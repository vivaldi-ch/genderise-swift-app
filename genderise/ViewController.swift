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
        
        initComponent()
    }
    
    func initComponent() {
        let animation: CATransition = CATransition()
        animation.duration = 1.0
        animation.type = CATransitionType.fade
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        percentageLabel.layer.add(animation, forKey: nil)
        genderLabel.layer.add(animation, forKey: nil)
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
                debugPrint(response.result.value!)
                
                if let jsonData = response.result.value as? [String: Any] {
                    self.onSuccess(jsonData)
                }
            case .failure(let error):
                self.onError(error)
            }
        }
    }
    
    func onSuccess(_ jsonData: [String: Any]) {
        self.percentageLabel.isHidden = false
        
        if let gender = jsonData["gender"] as? String,
            let probability = jsonData["probability"] as? Double {
            self.genderLabel.isHidden = false
            self.genderLabel.text = gender.capitalized
            
            let percentage: Int = Int(probability * 100)
            self.percentageLabel.text = "There is a \(percentage)% that you are a..."
        } else {
            self.genderLabel.isHidden = true
            self.percentageLabel.text = "Your gender is indeterminate..."
        }
    }
    
    func onError(_ error: Any) {
        // TODO: Handle error
        print(error)
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

