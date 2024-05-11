//
//  HomeVC.swift
//  Urban Shelters
//
//  Created by Sameer amjad on 5/10/24.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var col1 : UICollectionView!
    @IBOutlet weak var col2 : UICollectionView!
    @IBOutlet weak var col3 : UICollectionView!
    @IBOutlet weak var lbl : UILabel!
    @IBOutlet weak var searchh : UISearchBar!
    
    var homemodel = [HomeModel]()
    var usermodel : UserModel!
    var email = ""
    var array = ["Lahore", "Karachi" , "Islamabad" ,"Faislabad" , "Pindi"]
    var img = ["lahore","rawalpindi","islamabad","faislabad","rawalpindi"]
    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedEmail = UserDefaults.standard.string(forKey: "userEmail") {
            // Use the saved email
            print("Saved email:", savedEmail)
             email = savedEmail
            userapicall()
        } else {
            // Handle the case where the email is not found in UserDefaults
            print("Email not found in UserDefaults")
        }

        
        Homeapicall()
        navigationController?.navigationBar.isHidden = true 
    }
    
    func locationcall(searchText: String) {
    
        print(searchText)
        var request = URLRequest(url: URL(string: "https://urbanshelters.capraworks.com/api/search_property.php?location=\(searchText)")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            print("Response status code: \(httpResponse.statusCode)")
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let jsonArray = try JSONSerialization.jsonObject(with: data) as? [[String: Any]]
                var homeModels: [HomeModel] = []
                
                // Parse JSON array into an array of HomeModel objects
                if let jsonArray = jsonArray {
                    for json in jsonArray {
                        let homeModel = HomeModel(fromDictionary: json)
                        homeModels.append(homeModel)
                    }
                }
                
                // Assign the parsed HomeModel objects to the homemodel array
                self.homemodel = homeModels
                
                // Reload the collection view data after fetching and parsing data
                DispatchQueue.main.async {
                    self.col2.reloadData()
                    self.col3.reloadData()
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    func Homeapicall() {
        var request = URLRequest(url: URL(string: "https://urbanshelters.capraworks.com/api/get_properties.php")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            print("Response status code: \(httpResponse.statusCode)")
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let jsonArray = try JSONSerialization.jsonObject(with: data) as? [[String: Any]]
                var homeModels: [HomeModel] = []
                
                // Parse JSON array into an array of HomeModel objects
                if let jsonArray = jsonArray {
                    for json in jsonArray {
                        let homeModel = HomeModel(fromDictionary: json)
                        homeModels.append(homeModel)
                    }
                }
                
                // Assign the parsed HomeModel objects to the homemodel array
                self.homemodel = homeModels
                
                // Reload the collection view data after fetching and parsing data
                DispatchQueue.main.async {
                    self.col2.reloadData()
                    self.col3.reloadData()
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    func userapicall() {
        guard let url = URL(string: "https://urbanshelters.capraworks.com/api/user.php?email=\(email)") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("No data received: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                // Parse JSON data into dictionary
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    // Create UserModel instance from JSON dictionary
                    self.usermodel = UserModel(fromDictionary: json)
                    // Now you can use self.usermodel to access the parsed data
                    print("User ID: \(self.usermodel.id ?? "N/A")")
                    print("Username: \(self.usermodel.username ?? "N/A")")
                    DispatchQueue.main.async {
                        
                        
                        self.lbl.text = "Hi," + self.usermodel.username
                    }
                    print("Email: \(self.usermodel.email ?? "N/A")")
                    // Similarly, access other properties as needed
                } else {
                    print("Failed to parse JSON")
                }
            } catch let error {
                print("JSON serialization error: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    @IBAction func menubtn(_ sender : UIButton)
    {
        let vc = self.storyboard?.instantiateViewController(identifier: "AccountVC") as! AccountVC
        vc.idd = usermodel.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func agentButtonTapped(_ sender: UIButton)
    {
        let rowIndex = sender.tag
        
        let vc = self.storyboard?.instantiateViewController(identifier: "AgentDetaiVC") as! AgentDetaiVC
        vc.idd = homemodel[rowIndex].agentId
        vc.userid = usermodel.id
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func likeButtonTapped(_ sender: UIButton) {
        // Retrieve the tag to identify which button was tapped
        let rowIndex = sender.tag
        print(homemodel[rowIndex].id!)
        print(usermodel.id!)
        var request = URLRequest(url: URL(string: "https://urbanshelters.capraworks.com/api/favorite_properties.php?user_id=\(usermodel.id)&property_id=\(homemodel[rowIndex].id!)")!,timeoutInterval: Double.infinity)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
            self.Homeapicall()
        }
        
        task.resume()
    }
    
   
}
extension HomeVC: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == col1
        {
            return 5
        }
        else if collectionView == col2
        {
            return homemodel.count
        }
        else
        {
            return homemodel.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == col1
        {
            let vc = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FilterCVC
            vc.title.text = array[indexPath.row]
            vc.img.image = UIImage(named: img[indexPath.row])
            return vc
        }
        else if collectionView == col2
        {
            let vc = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! FeatureCVC
            vc.title.text = "🏢 " + homemodel[indexPath.row].title
            vc.dealer.text =  "👤 " + homemodel[indexPath.row].dealerName
            vc.location.text = "🌍 " + homemodel[indexPath.row].location
            vc.detail.text = homemodel[indexPath.row].detail
            vc.likeBtn.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
            vc.likeBtn.tag = indexPath.row
            
            vc.AgentBtn.addTarget(self, action: #selector(agentButtonTapped), for: .touchUpInside)
            vc.AgentBtn.tag = indexPath.row
            
            if homemodel[indexPath.row].favorite == "0"
            {
                vc.likeBtn.setImage(UIImage(systemName: "heart"), for: .normal)
                
            }
            else
            {
                vc.likeBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
            
            // Assuming you have a imageURL property in your cell
            let imageURL = homemodel[indexPath.row].backgroundImage ?? ""
            
            // Use URLSession to fetch the image asynchronously
            if let url = URL(string: imageURL) {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        // Create UIImage from the fetched data
                        let image = UIImage(data: data)
                        
                        // Update UI on the main thread
                        DispatchQueue.main.async {
                            // Set the image to your cell's UIImageView
                            vc.img.image = image
                        }
                    }
                }.resume()
            }
            
            return vc
            
        }
        else
        {
            let vc = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! FeatureCVC
            vc.title.text = "🏢 " + homemodel[indexPath.row].title
            vc.dealer.text =  "👤 " + homemodel[indexPath.row].dealerName
            vc.location.text = "🌍 " + homemodel[indexPath.row].location
            vc.detail.text = homemodel[indexPath.row].detail
            // Assuming you have a imageURL property in your cell
            let imageURL = homemodel[indexPath.row].backgroundImage ?? ""
            
            // Use URLSession to fetch the image asynchronously
            if let url = URL(string: imageURL) {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        // Create UIImage from the fetched data
                        let image = UIImage(data: data)
                        
                        // Update UI on the main thread
                        DispatchQueue.main.async {
                            // Set the image to your cell's UIImageView
                            vc.img.image = image
                        }
                    }
                }.resume()
            }
            
            return vc
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == col1
        {
            if indexPath.row == 0
            {
                
            }
            else if indexPath.row == 1
            {
                
            }
            else if indexPath.row == 2
            {
                
            }
            else if indexPath.row == 3
            {
                
            }
            else if indexPath.row == 4
            {
                
            }
        }
        
        else if collectionView == col2
        {
            let vc = self.storyboard?.instantiateViewController(identifier: "PropertyDetailsVC") as! PropertyDetailsVC
            vc.agentid = homemodel[indexPath.row].id
            vc.titile = homemodel[indexPath.row].title
            vc.detail = homemodel[indexPath.row].detail
            vc.agentname = homemodel[indexPath.row].dealerName
            vc.location = homemodel[indexPath.row].location
            vc.userid =  usermodel.id
            vc.like = homemodel[indexPath.row].favorite
            vc.img = homemodel[indexPath.row].backgroundImage
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}

extension HomeVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        locationcall(searchText: searchText)
    }
}
