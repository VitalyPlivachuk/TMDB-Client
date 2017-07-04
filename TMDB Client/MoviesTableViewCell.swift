//
//  MoviesTableViewCell.swift
//  TMDB Client
//
//  Created by Vitaly Plivachuk on 28.06.17.
//  Copyright © 2017 Vitaly Plivachuk. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell, UINavigationControllerDelegate{

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var vote: UILabel!
    @IBOutlet weak var poster: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
