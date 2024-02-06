//
//  AccountVC.swift
//  AdopteUneLivrasion
//
//  Created by Sameer Amjad on 16/06/2023.
//

import UIKit

class AccountVC: UIViewController {

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

    }
//    @IBAction func EditBtn (_ sender :UIButton)
//    {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditprofileVC") as! EditprofileVC
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    @IBAction func EditpasswordBtn (_ sender :UIButton)
//    {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditpasswordVC") as! EditpasswordVC
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    @IBAction func LocationBtn (_ sender :UIButton)
//    {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocationVC") as! LocationVC
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    @IBAction func LanguageBtn (_ sender :UIButton)
//    {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LanguageVC") as! LanguageVC
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    @IBAction func DeleteBtn (_ sender :UIButton)
//    {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DeleteVC") as! DeleteVC
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    @IBAction func LegalBtn (_ sender :UIButton)
//    {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LegalVC") as! LegalVC
//        self.navigationController?.pushViewController(vc, animated: true)
//    }

    
}
