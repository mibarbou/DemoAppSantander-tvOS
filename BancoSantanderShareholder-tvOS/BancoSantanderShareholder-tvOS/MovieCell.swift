//
//  MovieCell.swift
//  BancoSantanderShareholder-tvOS
//
//  Created by Michel Barbou Salvador on 12/02/16.
//  Copyright © 2016 Grupo CMC. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var movie : Movie?
    
    func configureCell(movie: Movie) {
        
        titleLabel.text = movie.title
        
    }
    
}
