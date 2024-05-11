//
//  updatepasswordVC.swift
//  Urban Shelters
//
//  Created by Sameer amjad on 5/11/24.
//

import UIKit

class updatepasswordVC: UIViewController {
    @IBOutlet weak var lbl : UITextField!
    
    var email = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func BackBtn(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetPassword(_ sender: UIButton) {
        if lbl.text != nil {
            var request = URLRequest(url: URL(string: "https://urbanshelters.capraworks.com/api/password-reset.php?email=\(email)&new_password=\(lbl.text ?? "")")!,timeoutInterval: Double.infinity)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print(String(describing: error))
                    return
                }
                
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let message = json["message"] as? String, message == "Password reset successful" {
                    DispatchQueue.main.async {
                        let vc = self.storyboard?.instantiateViewController(identifier: "SigninVC") as! SigninVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                } else {
                    print("Password reset failed")
                }
            }
            
            task.resume()
        }
    }

}
