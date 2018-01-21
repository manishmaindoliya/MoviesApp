//
//  modelDetail.swift
//  MobileDi_Task
//
//  Created by HeMu on 20/01/18.
//  Copyright © 2018 HeMu. All rights reserved.
//

import UIKit

class modelDetail: NSObject {
    var posterImage:String = String()
    var movieTitle :String = String()
    var movieDirector :String = String()
    var movieActors:String = String()
    var moviePlot:String = String()
    var movieWriter:String = String()
    
    init(posterImage:String,movieTitle:String,movieDirector:String,movieActors:String,moviePlot:String,movieWriter:String) {
        super.init()
        self.posterImage = posterImage
        self.movieTitle = movieTitle
        self.movieDirector = movieDirector
        self.movieActors = movieActors
        self.moviePlot = moviePlot
        self.movieWriter = movieWriter
    }
    
    
}

