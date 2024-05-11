//
//  SignupVC.swift
//  AdopteUneLivrasion
//
//  Created by Sameer Amjad on 15/06/2023.
//

import UIKit
import FlagPhoneNumber
import PhoneNumberKit


class SignupVC: BaseVC {
    
    @IBOutlet weak var phoneView : UIView!
    @IBOutlet weak var membershipType: UIButton!
    @IBOutlet weak var commisionType: UIButton!
    
    @IBOutlet weak var user_nameLbl: UILabel!
    @IBOutlet weak var user_nameTF: UITextField!
    @IBOutlet weak var user_nameTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var resturant_nameLbl: UILabel!
    @IBOutlet weak var resturant_nameTF: UITextField!
    @IBOutlet weak var resturant_nameTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var nameTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var addressTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordTopConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var countrycodeFeild : FPNTextField!
    var isPhoneNumberValid: Bool = false
    var number = ""
    var type = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
   

        
        
        addTapGesture(to: resturant_nameLbl, selector: #selector(resturantTapped(_:)))
        addTapGesture(to: nameLbl, selector: #selector(nameTapped(_:)))
        addTapGesture(to: emailLbl, selector: #selector(emailTapped(_:)))
        addTapGesture(to: addressLbl, selector: #selector(addressTapped(_:)))
        addTapGesture(to: passwordLbl, selector: #selector(passwordTapped(_:)))
    }
    func addTapGesture(to label: UILabel, selector: Selector) {
        label.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: selector)
        label.addGestureRecognizer(tapGesture)
    }
    
    @objc func userTapped(_ sender: UITapGestureRecognizer) {
        user_nameTopConstraint.constant = 12
        user_nameTF.isUserInteractionEnabled = true
        user_nameTF.becomeFirstResponder()
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func resturantTapped(_ sender: UITapGestureRecognizer) {
        resturant_nameTopConstraint.constant = 12
        resturant_nameTF.isUserInteractionEnabled = true
        resturant_nameTF.becomeFirstResponder()
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func nameTapped(_ sender: UITapGestureRecognizer) {
        nameTopConstraint.constant = 12
        nameTF.isUserInteractionEnabled = true
        nameTF.becomeFirstResponder()
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func emailTapped(_ sender: UITapGestureRecognizer) {
        emailTopConstraint.constant = 12
        emailTF.isUserInteractionEnabled = true
        emailTF.becomeFirstResponder()
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func addressTapped(_ sender: UITapGestureRecognizer) {
        addressTopConstraint.constant = 12
        addressTF.isUserInteractionEnabled = true
        addressTF.becomeFirstResponder()
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func passwordTapped(_ sender: UITapGestureRecognizer) {
        passwordTopConstraint.constant = 12
        passwordTF.isUserInteractionEnabled = true
        passwordTF.becomeFirstResponder()
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupUI() {
        //  Phonenumbertxtf.keyboardType = .phonePad
        countrycodeFeild.delegate = self
        countrycodeFeild.textColor = #colorLiteral(red: 0.1450980392, green: 0.1411764706, blue: 0.1725490196, alpha: 1)
        countrycodeFeild.hasPhoneNumberExample = false
        countrycodeFeild.placeholder = ""
        
        setupClearNav()
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func textfieldbtn(_ sender: UIButton) {
        countrycodeFeild.flagButton.sendActions(for: .touchUpInside)
    }
    
    @IBAction func submitBtn(_ sender: UIButton) {
        
        guard let username = nameTF.text, !username.isEmpty,
              let password = passwordTF.text, !password.isEmpty,
              let email = emailTF.text, !email.isEmpty,
              let cnic = resturant_nameTF.text, !cnic.isEmpty,
              let address = addressTF.text, !address.isEmpty
        else {
            // Show an error message or handle the empty fields case
            showTool(msg: "Please fill in all required fields", state: .warning)
            print("Please fill in all required fields")
            return
        }
        
        signup()

//        self.showTool(msg: "Successfully SignedUp", state: .error)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.navigationController?.popViewController(animated: true)
//        }
        
        
    }
    
    @IBAction func merchantType(_ sender: UIButton) {
        
        if type == 1 {
            if let newImage = UIImage(named: "ic_select") {
                commisionType.setImage(newImage, for: .normal)
                    }
            if let newImage = UIImage(named: "ic_unselect") {
                membershipType.setImage(newImage, for: .normal)
                    }
            type = 2
            print(type)
        } else {
            if let newImage = UIImage(named: "ic_unselect") {
                commisionType.setImage(newImage, for: .normal)
                    }
            if let newImage = UIImage(named: "ic_select") {
                membershipType.setImage(newImage, for: .normal)
                    }
            type = 1
            print(type)
        }
        
    }
  
    @IBAction func backbtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension SignupVC: FPNTextFieldDelegate {
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        print(name, dialCode, code)
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        textField.rightViewMode = .always
        textField.rightView = UIImageView(image: isValid ? UIImage(named: "ic_success") : UIImage(named: "ic_error"))
        self.isPhoneNumberValid = isValid
        if isValid {
            number = textField.getFormattedPhoneNumber(format: .E164) ?? "nil"
            print(textField.getFormattedPhoneNumber(format: .E164) ?? "nil")
            phoneView.backgroundColor = UIColor.green
        } else {
            phoneView.backgroundColor = UIColor.red
            print ("invalid")
        }
    }
    
    func fpnDisplayCountryList() {
        
    }
    func Signup()
    {
        
    }
}
extension SignupVC {
    func signup() {
        // Prepare the request
        var request = URLRequest(url: URL(string: "https://urbanshelters.capraworks.com/api/signup.php")!,timeoutInterval: Double.infinity)
        request.httpMethod = "POST"
        
        // Prepare the parameters
        let parameters = [
            "username": nameTF.text!,
            "password": passwordTF.text!,
            "email": emailTF.text!,
            "cnic": resturant_nameTF.text!,
            "address": addressTF.text!
        ] as [String : Any]
        
        print(parameters)
        request.httpBody = parameters.percentEncoded()
        
        // Perform the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            if let dataString = String(data: data, encoding: .utf8) {
                print("Response: \(dataString)")
                
                // Check if the response indicates successful user registration
                if dataString.contains("{\"message\":\"User registered successfully\"}") {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                } else if dataString.contains("{\"message\":\"Username already exists\"}") {
                    // Show tool if username already exists
                    DispatchQueue.main.async {
                        self.showTool(msg: "Username already exists", state: .error)
                    }
                }
            }
        }

        task.resume()

    }
}

// Extension to percent encode parameters for POST request
extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

// Allowed characters set for URL query value
private extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "&+=")
        return allowed
    }()
}
