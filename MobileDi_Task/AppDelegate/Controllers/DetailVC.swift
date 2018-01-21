//
//  DetailVC.swift
//  MobileDi_Task
//
//  Created by HeMu on 19/01/18.
//  Copyright © 2018 HeMu. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
class DetailVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var scrollViewDetail: UIScrollView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDirectors: UILabel!
    @IBOutlet var imgMovie: UIImageView!
    @IBOutlet var lblWriters: UILabel!
    @IBOutlet var lblStars: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var scContentVIew: UIView!    
    @IBOutlet var navTopConst: NSLayoutConstraint!
    @IBOutlet var contentViewHeight: NSLayoutConstraint!
    
    var imdbID : String?
    var modelVC :viewModel?
    var arrdetaiMovie:NSMutableArray?
    var detailInfo : modelDetail?
    var viewHeight : CGFloat = 0
    
    //MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        arrdetaiMovie = NSMutableArray()
        webserviceCalling()
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
            contentViewHeight.constant = viewHeight-64.0;
        }
        
        self.lblDescription.sizeToFit()
        self.lblDescription.textAlignment = .left
        
        if(viewHeight == 812){
            navTopConst.constant = 0
        }
    }
    
   
     //MARK: - REST Webservice Calling
    func webserviceCalling() {
        arrdetaiMovie?.removeAllObjects()
        Loader.shared.startLoader()
        let queryRequest = "?i=\((modelVC?.imdbID)!)&apikey=\(Apikey)"
        DataManager.Post_request(parameterDictionary: NSDictionary(), methodName: queryRequest as NSString) { (response, bool) in
            DispatchQueue.main.async {
                if(bool){
                    
                    let result      =  (response as! NSDictionary).replacingNullsWithBlanks() as NSDictionary
                    let output      =  (result.object(forKey: "response") as! NSDictionary).mutableCopy() as! NSMutableDictionary
                    
                    let modeData:modelDetail = modelDetail.init(posterImage:output.object(forKey:"Poster") as! String, movieTitle: output.object(forKey:"Title") as! String, movieDirector:output.object(forKey:"Director") as! String, movieActors: output.object(forKey:"Actors") as! String, moviePlot: output.object(forKey:"Plot") as! String, movieWriter: output.object(forKey:"Writer") as! String)
                    
                    self.arrdetaiMovie!.add(modeData)
                    self.detailInfo  = self.arrdetaiMovie?.object(at: 0) as? modelDetail
                    self.lblTitle.text = self.detailInfo?.movieTitle
                    self.lblStars.text = self.detailInfo?.movieActors
                    self.lblWriters.text = self.detailInfo?.movieWriter
                    self.lblDirectors.text = self.detailInfo?.movieDirector
                    self.lblDescription.text = self.detailInfo?.moviePlot
                    self.imgMovie.sd_setImage(with: URL(string:(self.detailInfo?.posterImage)!), placeholderImage:#imageLiteral(resourceName: "noImage"), options: .refreshCached)
                    Loader.shared.stopLoader()
                    
                }else{
                    let message = (response.object(forKey: "response") as! NSDictionary).object(forKey: "message") as! String
                    self.view.makeToast("\(message)", duration: 1.5, position: .bottom)
                    Loader.shared.stopLoader()
                }
            }
        }
    }
    
    //MARK: - Button Clicks Back
    @IBAction func clickOnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
     //MARK: - TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
