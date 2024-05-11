import UIKit

class ForgotVC: BaseVC {
    
    @IBOutlet weak var lbl : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func BackBtn(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetPassword(_ sender : UIButton) {
        // Define the URL for the API call
        guard let email = lbl.text, !email.isEmpty else {
            // Show an error message if the email field is empty
            self.showTool(msg: "Please enter your email", state: .error)
            return
        }
        
        var request = URLRequest(url: URL(string: "https://urbanshelters.capraworks.com/api/user.php?email=\(email)")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
            
            // Check if the response indicates user not found
            if let dataString = String(data: data, encoding: .utf8), dataString.contains("{\"message\":\"User not found\"}") {
                // Show tool if user not found
                DispatchQueue.main.async {
                    self.showTool(msg: "User not found", state: .error)
                }
            }
            else
            {
                DispatchQueue.main.async {
                    let vc = self.storyboard?.instantiateViewController(identifier: "updatepasswordVC") as! updatepasswordVC
                    vc.email = self.lbl.text!
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.showTool(msg: "Resend email sent", state: .error)
                }
            }
            
            // You can handle other responses here as needed
        }
        
        task.resume()
    }
}
