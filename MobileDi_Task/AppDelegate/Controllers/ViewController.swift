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
    
     var viewHeight : CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
    }

    func updateUI() {
        if(UIDevice.current.userInterfaceIdiom == .phone){
            if( UIDevice.current.orientation.isLandscape){
                contentViewHeight.constant = 290
            }else{
               contentViewHeight.constant = 0
            }
        }else{
            innerViewHeightConst.constant = 420;
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        updateUI()
    }
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//MARK:text field delegate

extension LoginVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
