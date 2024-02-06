//
//  SigninVC.swift
//  AdopteUneLivrasion
//
//  Created by Sameer Amjad on 15/06/2023.
//

import UIKit

class SigninVC: BaseVC {
    
    @IBOutlet weak var passwordTF :UITextField!
    @IBOutlet weak var EmailTF : UITextField!
    @IBOutlet weak var eyeimg : UIImageView!
    @IBOutlet weak var namelbl : UILabel!
    @IBOutlet weak var namelblTF : UITextField!
    @IBOutlet weak var namelblTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var passlbl : UILabel!
    @IBOutlet weak var passlblTF : UITextField!
    @IBOutlet weak var passlblTopConstraint: NSLayoutConstraint!
    
    //    @IBOutlet weak var
    var checkeye = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        passwordTF.isSecureTextEntry = true
        namelbl.isUserInteractionEnabled = true
        passlbl.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        namelbl.addGestureRecognizer(tapGesture)
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(passTapped(_:)))
        passlbl.addGestureRecognizer(tapGesture2)
        
    }
    
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        namelblTopConstraint.constant = 12
        namelblTF.isUserInteractionEnabled = true
        namelblTF.becomeFirstResponder()
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    @objc func passTapped(_ sender: UITapGestureRecognizer) {
        passlblTopConstraint.constant = 12
        passlblTF.isUserInteractionEnabled = true
        passlblTF.becomeFirstResponder()
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    
    @IBAction func passwordHidebtn(_ sender: UIButton)
    {
        if checkeye == true
        {
            eyeimg.image = UIImage(named: "ic_unhide")
            passwordTF.isSecureTextEntry = false
            checkeye = false
        }
        else
        {
            eyeimg.image = UIImage(named: "ic_hide")
            passwordTF.isSecureTextEntry = true
            checkeye = true
        }
        
    }
    @IBAction func Signinbtn(_ sender: UIButton)
    {
        
        
        let vc = storyboard?.instantiateViewController(identifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func forgotBtn(_ sender: UIButton)
    {
        
        let vc = storyboard?.instantiateViewController(identifier: "ForgotVC") as! ForgotVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginBtn(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(identifier: "AccountVC") as! AccountVC
        self.navigationController?.pushViewController(vc, animated: true)

        
    }
}
