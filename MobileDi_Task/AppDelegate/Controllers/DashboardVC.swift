//
//  DashboardVC.swift
//  MobileDi_Task
//  Created by HeMu on 19/01/18.
//  Copyright © 2018 HeMu. All rights reserved.

import UIKit

import SDWebImage
class DashboardVC: UIViewController {
    @IBOutlet var collectionViewMovie: UICollectionView!
    @IBOutlet var navTopConst: NSLayoutConstraint!
    var arrgetData = NSMutableArray()
    var movieName = "Taken"
    var viewHeight : CGFloat = 0
    
    //MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
        webserviceCalling()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        updateUI()
        self.collectionViewMovie.reloadData()
    }
    
    //MARK: - Button Clicks
    func updateUI() {
        viewHeight = self.view.frame.size.height
        if( UIDevice.current.orientation.isLandscape){
            viewHeight = self.view.frame.size.width
        }
        if(viewHeight == 812){
            navTopConst.constant = 0
        }
    }
    
    //MARK: -  REST Webservice Calling
    func webserviceCalling() {
        arrgetData.removeAllObjects()
        Loader.shared.startLoader()
        let queryRequest = "?s=\(movieName)&apikey=\(Apikey)"
        DataManager.Post_request(parameterDictionary: NSDictionary(), methodName: queryRequest as NSString) { (response, bool) in
            DispatchQueue.main.async {
                if(bool){
                    
                    let output      = (response ).replacingNullsWithBlanks() as NSDictionary
                    let array       =  ((output.object(forKey: "response") as! NSDictionary).object(forKey: "Search") as! NSArray).mutableCopy() as! NSMutableArray
                    for object in array{
                        let value = object as! NSDictionary
                        let modelMovie:viewModel = viewModel.init(posterImage:value.object(forKey:"Poster") as! String, movieTitle: value.object(forKey:"Title") as! String, movieYear: value.object(forKey:"Year") as! String, imdbID: value.object(forKey:"imdbID") as! String)
                        self.arrgetData.add(modelMovie)
                        print(self.arrgetData)
                    }
                    Loader.shared.stopLoader()
                    self.collectionViewMovie.reloadData()
                }else{
                    let message = (response.object(forKey: "response") as! NSDictionary).object(forKey: "message") as! String
                    self.view.makeToast("\(message)", duration: 1.5, position: .bottom)
                    Loader.shared.stopLoader()
                }
            }
        }
    }
    
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: collection view delegate and data source

extension DashboardVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrgetData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionViewMovie.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)as! cellCollectionDashboard
        
        let  MovieData = self.arrgetData.object(at: indexPath.row) as! viewModel
        
        print(MovieData.posterImage)
        
        cell.imgViewMovie.sd_setImage(with: URL(string:(MovieData.posterImage)), placeholderImage:#imageLiteral(resourceName: "noImage"), options: .refreshCached)
        
        cell.backgroundColor = UIColor.init(hex: 0x000000, alpha: 0.4)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let distinationVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        distinationVC.modelVC = (arrgetData.object(at:indexPath.row) as! viewModel)
        self.navigationController?.pushViewController(distinationVC, animated: true)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let cellWidth  = collectionViewMovie.frame.size.width*0.5-4.0
        if(UIDevice.current.userInterfaceIdiom == .pad){
            return CGSize.init(width: cellWidth, height: 190.0)
        }else{
            return CGSize.init(width: cellWidth, height: 150.0)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets.init(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 5.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 5.0
    }
}


//MARK: extension for color

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat) {
        let red = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hex & 0xFF)/256.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
