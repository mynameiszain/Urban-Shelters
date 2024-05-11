//
//  AccountVC.swift
//  AdopteUneLivrasion
//
//  Created by Sameer Amjad on 16/06/2023.
//

import UIKit

class AccountVC: BaseVC {

    var idd = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
 
    }
    @IBAction func BackBtn(_ sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func SignOutBtn (_ sender :UIButton)
    {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "userEmail")
        let vc = self.storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func DeleteBtn (_ sender :UIButton)
    {
    
        var request = URLRequest(url: URL(string: "https://urbanshelters.capraworks.com/api/delete_account.php?user_id=\(idd)")!,timeoutInterval: Double.infinity)
        request.httpMethod = "DELETE"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            UserDefaults.standard.removeObject(forKey: "userEmail")

            DispatchQueue.main.async {
                
                
                let vc = self.storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }

        task.resume()


    }

    @IBAction func profileBtn (_ sender :UIButton)
    {
        let vc = self.storyboard?.instantiateViewController(identifier: "ProfileVC") as! ProfileVC
        vc.idd = idd
        self.navigationController?.pushViewController(vc, animated: true)

    }

    @IBAction func agentBtn (_ sender :UIButton)
    {
        let vc = self.storyboard?.instantiateViewController(identifier: "BestagentsVC") as! BestagentsVC
        vc.id = idd
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func propertyBtn (_ sender :UIButton)
    {
        let vc = self.storyboard?.instantiateViewController(identifier: "FavouritePropertiesVC") as! FavouritePropertiesVC
        vc.id = idd
        self.navigationController?.pushViewController(vc, animated: true)

    }


}
