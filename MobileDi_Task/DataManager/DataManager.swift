//
//  DataManager.swift
//  HenotiTask
//
//  Created by HeMu on 16/12/17.
//  Copyright © 2017 HeMu. All rights reserved.
//

import UIKit
import Alamofire

class DataManager: NSObject {
    
    class func Post_request(parameterDictionary :NSDictionary,methodName:NSString , completion : @escaping (_ result : NSDictionary,_ status : Bool) -> Void ) {
       
        if NetReachability.isConnectedToNetwork() {
            
            DispatchQueue.global(qos: .default).async {
                
                let parameters: Parameters   =  parameterDictionary as! Parameters
                let urlString                =  "\(BaseUrl)\(methodName)"
                
                let headers: HTTPHeaders = [
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                ]
                
                Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers :headers )
                    .responseJSON { response in
                        if let json = response.result.value {
                            
                            print("result ====== \(json)")
                            
                            let output        = (json as! NSDictionary).replacingNullsWithBlanks() as NSDictionary
                            
                            let status        = output.object(forKey: "Response") as! String
                            
                            if(status == "True"){
                                let jsonResult  = ["response": output] as [String : Any]
                                completion(jsonResult as NSDictionary,true)
                            }else{
                                  completion(["response" : ["status":0,"message":"There is something wrong.Try again!"]],false)
                            }
                            
                        } else {
                            print("Did not receive json")
                            completion(["response" : ["status":0,"message":"There is something wrong.Try again!"]],false)
                        }
                }
            }
            
        } else {
            completion(["response" : ["status":0,"message":"Please check network connectivity."]],false)
        }
    }    
    
}
