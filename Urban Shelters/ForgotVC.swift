//
//  ForgotVC.swift
//  AdopteUneLivrasion
//
//  Created by Sameer Amjad on 15/06/2023.
//

import UIKit

class ForgotVC: BaseVC {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func BackBtn(_ sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetPassword(_ sender : UIButton)
    {
}
}
