//
//  Movie.swift
//  TMDB Client
//
//  Created by Vitaly Plivachuk on 27.06.17.
//  Copyright © 2017 Vitaly Plivachuk. All rights reserved.
//

import Foundation
import UIKit

class movieInSearchResults {
    var id : Double?
    var title : String?
    var overview : String?
    var releaseDate : Date?
    var vote: Double?
    var posterPath : String?
    var posterImage :UIImage?
    var genres : [Double]?
    var voteCount : Double?
    
    init(parsedJson: [String: AnyObject]) {
        
        if let id = parsedJson["id"] as? Double {
            self.id = id
        }
        
        if let voteCount = parsedJson["vote_count"] as? Double {
            self.voteCount = voteCount
        }
        
        if let genres = parsedJson["genre_ids"] as? [Double] {
            self.genres = genres
        }
        
        if let overview = parsedJson["overview"] as? String {
            self.overview = overview
        }
        
       
        if let posterPath = parsedJson["poster_path"] as? String {
            self.posterPath = posterPath
            let imgURL = URL(string: "https://image.tmdb.org/t/p/w154\(self.posterPath!)")!
            let imgData = try? Data(contentsOf: imgURL)
            posterImage = UIImage(data: imgData!)
        } else {
            posterImage = UIImage(named: "moviedb")
        }
        
        if let title = parsedJson["title"] as? String {
            self.title = title
        }
        
        if let vote = parsedJson["vote_average"] as? Double {
            self.vote = vote
        }
        
        if let releaseDate = parsedJson["release_date"] as? String {
            let toDateFormatter = DateFormatter()
            toDateFormatter.dateFormat = "yyyy-MM-dd"
            self.releaseDate = toDateFormatter.date(from: releaseDate)
        }
        
    }

    
}

class tvShowInSearchResults {
    var id : Double?
    var title : String?
    var overview : String?
    var releaseDate : Date?
    var vote: Double?
    var posterPath : String?
    var posterImage :UIImage?
    var genres : [Double]?
    var voteCount : Double?
    
    init(parsedJson: [String: AnyObject]) {
        
        if let id = parsedJson["id"] as? Double {
            self.id = id
        }
        
        if let voteCount = parsedJson["vote_count"] as? Double {
            self.voteCount = voteCount
        }
        
        if let genres = parsedJson["genre_ids"] as? [Double] {
            self.genres = genres
        }
        
        if let overview = parsedJson["overview"] as? String {
            self.overview = overview
        }
        
        
        if let posterPath = parsedJson["poster_path"] as? String {
            self.posterPath = posterPath
            let imgURL = URL(string: "https://image.tmdb.org/t/p/w154\(self.posterPath!)")!
            let imgData = try? Data(contentsOf: imgURL)
            posterImage = UIImage(data: imgData!)
        } else {
            posterImage = UIImage(named: "moviedb")
        }
        
        if let title = parsedJson["name"] as? String {
            self.title = title
        }
        
        if let vote = parsedJson["vote_average"] as? Double {
            self.vote = vote
        }
        
        if let releaseDate = parsedJson["first_air_date"] as? String {
            let toDateFormatter = DateFormatter()
            toDateFormatter.dateFormat = "yyyy-MM-dd"
            self.releaseDate = toDateFormatter.date(from: releaseDate)
        }
        
    }
    
    
}

