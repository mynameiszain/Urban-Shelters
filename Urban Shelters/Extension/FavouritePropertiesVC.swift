//
//  FavouritePropertiesVC.swift
//  Urban Shelters
//
//  Created by Sameer amjad on 5/11/24.
//

import UIKit

class FavouritePropertiesVC: UIViewController {
    
    @IBOutlet weak var col : UICollectionView!
    var homemodel = [HomeModel]()
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Homeapicall()
        
    }
    
    func Homeapicall() {
        var request = URLRequest(url: URL(string: "https://urbanshelters.capraworks.com/api/favorite_properties.php?user_id=\(id)")!,timeoutInterval: Double.infinity)
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
            print(response)
            
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
                    self.col.reloadData()
                    
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    @objc func agentButtonTapped(_ sender: UIButton)
    {
        let rowIndex = sender.tag
        
        let vc = self.storyboard?.instantiateViewController(identifier: "AgentDetaiVC") as! AgentDetaiVC
        vc.idd = homemodel[rowIndex].agentId
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func likeButtonTapped(_ sender: UIButton) {
        // Retrieve the tag to identify which button was tapped
        let rowIndex = sender.tag
        
        
        
        var request = URLRequest(url: URL(string: "https://urbanshelters.capraworks.com/api/favorite_agent.php?user_id=\(id)&agent_id=\(homemodel[rowIndex].agentId!)")!,timeoutInterval: Double.infinity)
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
    @IBAction func BackBtn(_ sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
}

extension FavouritePropertiesVC: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return homemodel.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = view.frame.width / 2 - 20
        return CGSize(width: cellWidth, height: cellWidth + 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let vc = self.storyboard?.instantiateViewController(identifier: "PropertyDetailsVC") as! PropertyDetailsVC
        vc.agentid = homemodel[indexPath.row].agentId
        vc.titile = homemodel[indexPath.row].title
        vc.detail = homemodel[indexPath.row].detail
        vc.agentname = homemodel[indexPath.row].dealerName
        vc.location = homemodel[indexPath.row].location
        vc.userid =  id
        vc.like = homemodel[indexPath.row].favorite
        vc.img = homemodel[indexPath.row].backgroundImage
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

