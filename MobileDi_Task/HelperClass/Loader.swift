//
//  Loader.swift
//  DoozyDoc
//
//  Created by Octal on 6/2/17.
//  Copyright © 2017 Uyloo Solutions Pvt Ltd. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class Loader: UIViewController, NVActivityIndicatorViewable {

    static let shared : Loader =  {
        let instance = Loader()
        return instance
    }()
    
    //MARK: - Loader
    func startLoader() {
        startAnimating(loaderSize, message: "", type: NVActivityIndicatorType(rawValue: loaderType)!)
    }
    
    func stopLoader() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.stopAnimating()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
