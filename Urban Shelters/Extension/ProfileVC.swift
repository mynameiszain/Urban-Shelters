//
//  ProfileVC.swift
//  Urban Shelters
//
//  Created by Sameer amjad on 5/11/24.
//

import UIKit

class ProfileVC: BaseVC {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phoneno: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var createdat: UITextField!
    
    
    
    var idd = ""
    var emails = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let savedEmail = UserDefaults.standard.string(forKey: "userEmail") {
            // Use the saved email
            print("Saved email:", savedEmail)
             emails = savedEmail
            apicall()
        } else {
            // Handle the case where the email is not found in UserDefaults
            print("Email not found in UserDefaults")
        }
         
        
    }
    func apicall() {
        guard let url = URL(string: "https://urbanshelters.capraworks.com/api/user.php?email=\(emails)") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("No data returned: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    print("Error parsing JSON")
                    return
                }
                
                DispatchQueue.main.async {
                    self.name.text = json["username"] as? String
                    self.email.text = json["email"] as? String
                    self.phoneno.text = json["cnic"] as? String
                    self.createdat.text = json["address"] as? String
                    // Set other labels as needed
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    func callapiProfileUpdate()

    {
        print(idd)
//        let parameters = "{\r\n    \"user_id\": 3,\r\n    \"username\": \"zainxsxsapiif\",\r\n    \"password\": \"1234567890\",\r\n    \"email\": \"zainapi@zainapiif.com\",\r\n    \"cnic\": \"3520189765413\",\r\n    \"address\": \"pakistan lahore\"\r\n}\r\n"
        
        let parameters = """
        {
            "user_id": \(idd),
            "username": \(name.text!),
            "email": \(email.text!),
            "cnic": \(phoneno.text!),
            "address": \(createdat.text!)
        }
        """
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://urbanshelters.capraworks.com/api/user-edit-profile.php?user_id=3")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "PATCH"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
            DispatchQueue.main.async {
                
                
                self.showTool(msg: "Profile updated", state: .success)
            }
        }

        task.resume()

        
    }

    @IBAction func updateBtn(_ sender : UIButton)
    {
        callapiProfileUpdate()
    }

    
    @IBAction func BackBtn(_ sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

