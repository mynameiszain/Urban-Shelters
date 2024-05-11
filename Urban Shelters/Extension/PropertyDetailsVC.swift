//
//  PropertyDetailsVC.swift
//  Urban Shelters
//
//  Created by Sameer amjad on 5/11/24.
//

import UIKit

class PropertyDetailsVC: UIViewController {
    @IBOutlet weak var img1 : UIImageView!
    @IBOutlet weak var likebtn : UIButton!
    @IBOutlet weak var agentname1 : UILabel!
    @IBOutlet weak var detail1 : UILabel!
    @IBOutlet weak var location1 : UILabel!
    @IBOutlet weak var titile1 : UILabel!
    
    var like = ""
    var userid = ""
    var agentid = ""
    var img = ""
    var agentname = ""
    var detail = ""
    var location = ""
    var titile = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        agentname1.text =  "👤 " + agentname
        detail1.text = detail
        location1.text = "🌍 " + location
        titile1.text = "🏢 " + titile
        
        
        
        // Assuming you have a imageURL property in your cell
        let imageURL = img
        
        // Use URLSession to fetch the image asynchronously
        if let url = URL(string: imageURL) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    // Create UIImage from the fetched data
                    let image = UIImage(data: data)
                    
                    // Update UI on the main thread
                    DispatchQueue.main.async {
                        // Set the image to your cell's UIImageView
                        self.img1.image = image
                    }
                }
            }.resume()
        }
    }
    
    @IBAction func btn(_sender: UIButton)
    {
//        var request = URLRequest(url: URL(string: "https://urbanshelters.capraworks.com/api/favorite_agent.php?user_id=\(userid)&agent_id=\(agentid)")!,timeoutInterval: Double.infinity)
//        request.httpMethod = "POST"
        var request = URLRequest(url: URL(string: "https://urbanshelters.capraworks.com/api/favorite_properties.php?user_id=\(userid)&property_id=\(agentid)")!,timeoutInterval: Double.infinity)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
            if self.like == "0"
            {
                self.like = "1"
                
                    
                DispatchQueue.main.async {
                    self.likebtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                }
            }
            else
            {
                self.like = "0"
                DispatchQueue.main.async {
                    self.likebtn.setImage(UIImage(systemName: "heart"), for: .normal)
                }
            }
        }
        
        task.resume()
    }
    
    @IBAction func BackBtn(_ sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
}
