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
    var id:Int!
    
    
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
    
    public func addFavorite(model:FavoriteMovieModel, provider:NetworkManager){
        
        provider.getActorsForMovie(movieId: self.id, completion: {[weak self] actor in
            print(actor.count)
            if(actor.count>2){
                self?.actors = actor[0].name + ", " + actor[1].name + ", " + actor[2].name + " and more..."
                _ = model.getMovieTitle(id: self?.id ?? 0, backdrop: self?.backdropURL ?? URL(fileURLWithPath: "http://apple.ch"), overview: self?.overview ?? "", rating: self?.rating.text! ?? "", actors: self?.actors ?? "")
                model.changeMovieTitle(id: self?.id ?? 0, newTitle: self?.movieTitle.text! ?? "")
                self?.favorited = true
                self?.addedLabel.text = "added"
            }
        })
        
    }
    
    public func removeFavorite(model:FavoriteMovieModel){
        
        self.favorited = false
        _ = model.removeMovieTitle(id: self.id)
        addedLabel.text = ""
    }
    
    // Override to support editing the table view.
   
}
