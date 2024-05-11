import UIKit

class AgentDetaiVC: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phoneno: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var createdat: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var likebtn : UIButton!
    
    var idd = "6"
    var userid = "6"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apicall()
    }
    
    @IBAction func favbtn(_ sender : UIButton)
    
    {
        likeapi()
    }
    
    func apicall() {
        guard let url = URL(string: "https://urbanshelters.capraworks.com/api/agent_detail.php?agent_id=\(idd)") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Error fetching data: \(error)")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let agentName = json["agent_name"] as? String {
                        DispatchQueue.main.async {
                            self.name.text = "👤 " + agentName
                        }
                    }
                    if let phoneNo = json["phone_no"] as? String {
                        DispatchQueue.main.async {
                            self.phoneno.text = "📞 " + phoneNo
                        }
                    }
                    if let agentEmail = json["agent_email"] as? String {
                        DispatchQueue.main.async {
                            self.email.text = "📩 " + agentEmail
                        }
                    }
                    if let createdAt = json["created_at"] as? String {
                        DispatchQueue.main.async {
                            self.createdat.text = "🕒 " + createdAt
                        }
                    }
                    if let agentImage = json["agent_image"] as? String, let imageUrl = URL(string: agentImage) {
                        self.loadImage(from: imageUrl)
                    }
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
        
        task.resume()
    }
    
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.img.image = UIImage(data: data)
                }
            }
        }.resume()
    }
    
    func likeapi()
    {
        var request = URLRequest(url: URL(string: "https://urbanshelters.capraworks.com/api/favorite_agent.php?user_id=\(userid)&agent_id=\(idd)")!,timeoutInterval: Double.infinity)
        request.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }

            // Assuming the response is in JSON format
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let message = json["message"] as? String {
                        print(message)
                        if message == "Agent added to favorites successfully." {
                            DispatchQueue.main.async {
                                self.likebtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                            }
                        } else {
                            
                            DispatchQueue.main.async {
                                
                                
                                self.likebtn.setImage(UIImage(systemName: "heart"), for: .normal)
                            }
                        }
                    }
                }
            } catch let error as NSError {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }

        task.resume()

    }
    
    @IBAction func BackBtn(_ sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
