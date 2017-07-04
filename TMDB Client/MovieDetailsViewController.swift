//
//  MovieDetailsViewController.swift
//  TMDB Client
//
//  Created by Vitaly Plivachuk on 28.06.17.
//  Copyright © 2017 Vitaly Plivachuk. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movieTitle = ""
    var poster = UIImage()
    var releaseDate = ""
    var genre = ""
    var vote = ""
    var voteCount = ""
    var overview = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitleLabel.text = movieTitle
        posterView.image = poster
        dateLabel.text = releaseDate
        genreLabel.text = genre
        voteLabel.text = vote
        voteCountLabel.text = voteCount
        overviewLabel.text = overview
        // Do any additional setup after loading the view.
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
