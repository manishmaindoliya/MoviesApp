//
//  viewModel.swift
//  MobileDi_Task
//
//  Created by HeMu on 19/01/18.
//  Copyright © 2018 HeMu. All rights reserved.
//

import UIKit

class viewModel: NSObject {
    
    var posterImage:String = String()
    var movieTitle :String = String()
    var movieYear :String = String()
    var imdbID :String = String()
    
    init(posterImage:String,movieTitle:String,movieYear:String,imdbID:String) {
        super.init()
        self.posterImage = posterImage
        self.movieTitle = movieTitle
        self.movieYear = movieYear
        self.imdbID = imdbID
    }
}
