//
//  cell.swift
//  MovieApp
//
//  Created by Nicolas Kalousek on 11.03.19.
//  Copyright © 2019 Nicolas Kalousek. All rights reserved.
//

import UIKit

class cell: UITableViewCell {
    
    var favorited = false
    var backdropURL:URL!
    var overview:String!
    var actors:String!
    
    
    static let reuseIdentifier = String(describing: cell.self)
    static let nibName = String(describing: cell.self)

    @IBOutlet weak var addedLabel: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundImage.clipsToBounds = true
    }
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
    }
    
    public func addFavorite(model:FavoriteMovieModel){
        _ = model.getMovieTitle(id: self.movieTitle.text!, backdrop: self.backdropURL, overview: overview, rating: rating.text!, actors: actors)
        model.changeMovieTitle(id: self.movieTitle.text!, newTitle: movieTitle.text!)
        self.favorited = true
        print(model.getMovieTitle(id: self.movieTitle.text!, backdrop: self.backdropURL, overview: overview, rating: rating.text!, actors: actors))
        addedLabel.text = "added"
    }
    
    public func removeFavorite(model:FavoriteMovieModel){
        
        self.favorited = false
        _ = model.removeMovieTitle(id: self.movieTitle.text!)
        addedLabel.text = ""
    }
    
    // Override to support editing the table view.
   
}
