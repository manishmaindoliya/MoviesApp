//
//  LoginVC.swift
//  MobileDi_Task
//
//  Created by HeMu on 19/01/18.
//  Copyright © 2018 HeMu. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet var txtfldEmail: UITextField!
    @IBOutlet var txtfldPassword: UITextField!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var contentViewHeight: NSLayoutConstraint!
    @IBOutlet var innerViewHeightConst: NSLayoutConstraint!
    @IBOutlet var scTopConst: NSLayoutConstraint!
    @IBOutlet var scrollView: UIScrollView!
    var viewHeight : CGFloat = 0
    
    
    //MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        updateUI()
    }
    
    //MARK: - UI Update Method
    func updateUI() {
        viewHeight = self.view.frame.size.height
        if( UIDevice.current.orientation.isLandscape){
            viewHeight = self.view.frame.size.width
        }
        
        if(viewHeight > contentViewHeight.constant){
            contentViewHeight.constant = viewHeight;
        }
        
        if(UIDevice.current.userInterfaceIdiom == .phone){
            viewHeight = self.view.frame.size.height
            if( UIDevice.current.orientation.isLandscape){
                viewHeight = self.view.frame.size.width
            }
            if(viewHeight == 812){
                scTopConst.constant = 0
            }
        }else{
            innerViewHeightConst.constant = 420;
        }
    }
    
   
    
    //MARK: - Button Clicks Login
    @IBAction func clickOnLogin(_ sender: UIButton) {
        
        if(!ValidationClass.shared.ValidateLoginForm(loginObj: self)){
        return
        }
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let destinationVC = storyBoard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

//MARK: TextField Delegate
extension LoginVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
