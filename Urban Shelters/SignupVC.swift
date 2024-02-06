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
        
        self.showTool(msg: "Successfully SignedUp", state: .error)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.navigationController?.popViewController(animated: true)
        }
        //Signup()
        
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
