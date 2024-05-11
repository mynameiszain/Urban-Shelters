//
//  BestagentsVC.swift
//  Urban Shelters
//
//  Created by Sameer amjad on 5/11/24.
//

import UIKit

class BestagentsVC: UIViewController {
        
        @IBOutlet weak var col : UICollectionView!
        var homemodel = [AgentModel]()
        var id = ""
        
        override func viewDidLoad() {
            super.viewDidLoad()
            Homeapicall()
            
        }
        
        func Homeapicall() {
            var request = URLRequest(url: URL(string: "https://urbanshelters.capraworks.com/api/favorite_agent.php?user_id=\(id)")!,timeoutInterval: Double.infinity)
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
                    var homeModels: [AgentModel] = []
                    
                    // Parse JSON array into an array of HomeModel objects
                    if let jsonArray = jsonArray {
                        for json in jsonArray {
                            let homeModel = AgentModel(fromDictionary: json)
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
        @IBAction func BackBtn(_ sender : UIButton)
        {
            self.navigationController?.popViewController(animated: true)
        }
    }

    extension BestagentsVC: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
    {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            print(homemodel.count)
            return homemodel.count
            
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            
            
            let vc = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! BestagentscVC
          
            
//            vc.AgentBtn.addTarget(self, action: #selector(agentButtonTapped), for: .touchUpInside
//            vc.AgentBtn.tag = indexPath.row
            
            vc.NAme.text = "👤 " + homemodel[indexPath.row].agentName
            vc.email.text = "✉️ " + homemodel[indexPath.row].agentEmail
            vc.number.text = "📞" + homemodel[indexPath.row].phoneNo
            
            // Assuming you have a imageURL property in your cell
            let imageURL = homemodel[indexPath.row].agentImage ?? ""
            
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
            
            let vc = self.storyboard?.instantiateViewController(identifier: "AgentDetaiVC") as! AgentDetaiVC
            vc.idd = homemodel[indexPath.row].agentId
            self.navigationController?.pushViewController(vc, animated: true)
   
            
        }
        
    }

