//
//  cell.swift
//  MovieApp
//
//  Created by Nicolas Kalousek on 11.03.19.
//  Copyright © 2019 Nicolas Kalousek. All rights reserved.
//

import UIKit

class cell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: cell.self)
    static let nibName = String(describing: cell.self)

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var movieTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
    }
    
    public func doSomething(number: Int, navigation: Int){
    }
    
}
