//
//  BaseVC.swift
//  Stargaze
//
//  Created by Naveed ur Rehman on 26/02/2020.
//  Copyright © 2020 Naveed ur Rehman. All rights reserved.
//

import UIKit
import SFSymbols
import Loaf
import SDWebImage

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func btnNotificationButton() -> UIBarButtonItem {
        
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let notBtn = UIBarButtonItem(image: UIImage(symbol: SFSymbol.bellFill).applyingSymbolConfiguration(boldConfig), style: .plain, target: self, action: #selector(self.btnNotAction))
        return notBtn
    }
    
    @objc func btnNotAction(_ sender: Any) {
        
        
    }
    func BtnEditButton() -> UIBarButtonItem {
        
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let notBtn = UIBarButtonItem(image: UIImage(named: "pencil-1")!.applyingSymbolConfiguration(boldConfig), style: .plain, target: self, action: #selector(self.BtneditAction))
        return notBtn
    }
    
    @objc func BtneditAction(_ sender: Any) {
        
        
    }
    func btndownloadButton() -> UIBarButtonItem {
        
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let notBtn = UIBarButtonItem(image: UIImage(named: "Icon feather-download-cloud-1")!.applyingSymbolConfiguration(boldConfig), style: .plain, target: self, action: #selector(self.btndownloadAction))
        
        return notBtn
    }
    
    @objc func btndownloadAction(_ sender: Any) {
        
     
    }

   
    
    // MARK: Back Bar Button Item
    func btnBackButton() -> UIBarButtonItem {
        
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let backBtn = UIBarButtonItem(image: UIImage(symbol: SFSymbol.arrowLeft).applyingSymbolConfiguration(boldConfig), style: .plain, target: self, action: #selector(self.btnBackAction))
        return backBtn
    }
    
    @objc func btnBackAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: Menu Bar Button Item
    func btnMenuButton() -> UIBarButtonItem {
        
        let menuBtn = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(self.btnMenuAction(_:)))
        return menuBtn
    }
    
    @objc func btnMenuAction(_ sender: UIBarButtonItem) {
        
        
    }
    
    // MARK: EditPRofile Bar Button Item
    func btnEditProfileButton() -> UIBarButtonItem {
       
        let editBtn : UIBarButtonItem!
        editBtn = UIBarButtonItem(image: UIImage(named: "editProfile"), style: .plain, target: self, action: #selector(self.btnEditProfileAction))
        return editBtn
    }
    
    @objc func btnEditProfileAction(_ sender: Any) {
        
        
    }
    
    // MARK: Logo Bar Button Item
    func btnLogoButton(imgname: String) -> UIBarButtonItem {
        
        let btnLogo = UIButton(type: .custom)
        let img = URL(string: imgname)
        UIImageView().sd_setImage(with: img) { image, err, type, url in
            btnLogo.setImage(image, for: .normal)
        }
//        btnLogo.kf.setImage(with: img, for: .normal, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
//        btnLogo.setImage(UIImage(named: imgname), for: .normal)
        btnLogo.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnLogo.addTarget(self, action: #selector(btnLogoAction(_:)), for: .touchUpInside)
//        btnLogo.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0.0)
        btnLogo.imageView?.layer.cornerRadius =  30 / 2
        btnLogo.imageView?.layer.masksToBounds = true
        btnLogo.imageView?.contentMode = .scaleAspectFill
//        btnLogo.transform = CGAffineTransform(translationX: -5, y: 0)

        let container = UIView(frame: btnLogo.frame)
        container.addSubview(btnLogo)

        let barButton = UIBarButtonItem()
        barButton.customView = container
        return barButton
    }
    
    @objc func btnLogoAction(_ sender: Any) {
        
        
    }
    func showTool(msg: String, state: Loaf.State){
        Loaf(msg, state: state, sender: self).show()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            Loaf.dismiss(sender: self, animated: true)
        }
    }
    func setupDarkNav(){
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white as Any, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
    }
    func setupLightNav(){
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white as Any, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
    }
    func setupBlackNav(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(hexString: "#2E284E")
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white as Any, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        self.navigationController?.navigationBar.tintColor = UIColor(hexString: "#17BDC8")
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    func setupClearNav(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = .black.withAlphaComponent(0.1)
        
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black as Any, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    func setupWhiteNav(){
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black as Any, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    func btnLeft(image: String? = nil,text: String? = nil, isOrignal: Bool) -> UIBarButtonItem {
        var leftBtn: UIBarButtonItem!
        if text != nil {
            leftBtn = UIBarButtonItem(title: text, style: .plain, target: self, action: #selector(self.btnLeftAction(_:)))
        } else {
            leftBtn = UIBarButtonItem(image: isOrignal ? UIImage(named: image!)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal) : UIImage(named: image!), style: .plain, target: self, action: #selector(self.btnLeftAction(_:)))
        }
        
        return leftBtn
    }
    
    @objc func btnLeftAction(_ sender: Any) {
        
    }
    func btnRight(image: String? = nil,text: String? = nil, isOrignal: Bool) -> UIBarButtonItem {
        var rightBtn: UIBarButtonItem!
        if text != nil {
            rightBtn = UIBarButtonItem(title: text, style: .plain, target: self, action: #selector(self.btnRightAction(_:)))
        } else {
            rightBtn = UIBarButtonItem(image: isOrignal ? UIImage(named: image!)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal) : UIImage(named: image!), style: .plain, target: self, action: #selector(self.btnRightAction(_:)))
        }
        return rightBtn
    }
    
    @objc func btnRightAction(_ sender: Any) {
        
    }
    func btnLeft2(image: String? = nil, text: String? = nil, isOrignal: Bool) -> UIBarButtonItem {
        
        var leftBtn2: UIBarButtonItem!
        if text != nil {
            leftBtn2 = UIBarButtonItem(title: text, style: .plain, target: self, action: #selector(self.btnLeftAction2(_:)))
        } else {
            leftBtn2 = UIBarButtonItem(image: isOrignal ? UIImage(named: image!)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal) : UIImage(named: image!), style: .plain, target: self, action: #selector(self.btnLeftAction2(_:)))
        }
        return leftBtn2
    }
    
    @objc func btnLeftAction2(_ sender: Any) {
        
    }
    func btnRight2(image: String? = nil, text: String? = nil, isOrignal: Bool) -> UIBarButtonItem {
        var rightBtn2: UIBarButtonItem!
        if text != nil {
            rightBtn2 = UIBarButtonItem(title: text, style: .plain, target: self, action: #selector(self.btnRightAction2(_:)))
        } else {
            rightBtn2 = UIBarButtonItem(image: isOrignal ? UIImage(named: image!)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal) : UIImage(named: image!), style: .plain, target: self, action: #selector(self.btnRightAction2(_:)))
        }
        return rightBtn2
    }
    
    @objc func btnRightAction2(_ sender: Any) {
        
    }
    func btnUserImg(image: UIImage) -> UIBarButtonItem {
        
        let buttonWidth = CGFloat(30)
        let buttonHeight = CGFloat(30)

        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.clipsToBounds = true
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(btnUserImgAction(_:)), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        
        return UIBarButtonItem.init(customView: button)

    }
    
    @objc func btnUserImgAction(_ sender: Any) {
        
    }
  
    func btnImgTxt(image: String, text: String) -> UIBarButtonItem {
        
        let button = UIButton.init(type: .custom)
        button.addTarget(self, action: #selector(btnImgTxtAction(_:)), for: .touchUpInside)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: image)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: 250, height: 30))
        label.text = text
        label.textColor = UIColor(hexString: "#FD435F")
//        label.font =  UIFont(name: AppFonts.roboto, size: 12)
        let buttonView = UIView(frame: CGRect(x: 0, y: 0, width: 275, height: 30))
        button.frame = buttonView.frame
        buttonView.addSubview(button)
        buttonView.addSubview(imageView)
        buttonView.addSubview(label)
        return UIBarButtonItem.init(customView: buttonView)

    }
    
    @objc func btnImgTxtAction(_ sender: Any) {
        
    }
    
    // MARK: Notification Bar Button Item
    func btnBack(isOrignal: Bool) -> UIBarButtonItem {
        
        let backBtn = UIBarButtonItem(image: isOrignal ? UIImage(named: "Vector")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal) : UIImage(named: "Vector"), style: .plain, target: self, action: #selector(self.btnBackAction(_:)))
        return backBtn
    }
    // MARK: Notification Bar Button Item
    func btnWithCustomText(text: String) -> UIBarButtonItem {
        
        let txtBtn = UIBarButtonItem(title: text, style: .plain, target: self, action: #selector(self.btnCustomTextAction(_:)))
        return txtBtn
    }
    @objc func btnCustomTextAction(_ sender: Any) {
        
    }
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    func goBackToRoot() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func goBackWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func goRootWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func navigateWithDelay(vc: UIViewController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.navigationController?.pushViewController(vc, animated: true)
//            self.navigationController?.popToRootViewController(animated: true)
        }
    }

}


