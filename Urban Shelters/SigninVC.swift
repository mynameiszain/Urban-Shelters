


import UIKit

class SigninVC: BaseVC {
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var eyeimg: UIImageView!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var namelblTF: UITextField!
    @IBOutlet weak var namelblTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var passlbl: UILabel!
    @IBOutlet weak var passlblTF: UITextField!
    @IBOutlet weak var passlblTopConstraint: NSLayoutConstraint!
    
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
    
    @IBAction func passwordHidebtn(_ sender: UIButton) {
        if checkeye {
            eyeimg.image = UIImage(named: "ic_unhide")
            passwordTF.isSecureTextEntry = false
            checkeye = false
        } else {
            eyeimg.image = UIImage(named: "ic_hide")
            passwordTF.isSecureTextEntry = true
            checkeye = true
        }
    }
    
    @IBAction func Signinbtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func forgotBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "ForgotVC") as! ForgotVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        // Handle Login button action
        let email = EmailTF.text ?? ""
        let password = passwordTF.text ?? ""
        let urlString = "https://urbanshelters.capraworks.com/api/login.php?login=1&email=\(email)&password=\(password)"
        
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                print(response)
                
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            if let message = json["message"] as? String, message == "Login successful" {
                                print("Login successful!")
                                if let email = self.EmailTF.text, !email.isEmpty {
                                    UserDefaults.standard.set(email, forKey: "userEmail")
                                }
                                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                                DispatchQueue.main.async {
                                    let vc = self.storyboard?.instantiateViewController(identifier: "HomeVC") as! HomeVC
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                            } else {
                                print("Login failed or message not found")
                                DispatchQueue.main.async {
                                    if let message = json["message"] as? String {
                                        self.showTool(msg: message, state: .warning)
                                    } else {
                                        print("Message not found in response")
                                    }
                                }
                            }
                        } else {
                            print("Failed to parse JSON")
                        }
                    } catch {
                        print("Error parsing JSON: \(error)")
                    }
                }
                
            }
            task.resume()
        } else {
            print("Invalid URL")
        }
    }
    
}
