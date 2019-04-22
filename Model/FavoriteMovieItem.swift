//
//  FavoriteMovieItem.swift
//  MovieApp
//
//  Created by Nicolas Kalousek on 28.03.19.
//  Copyright © 2019 Nicolas Kalousek. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class FavoriteMovieItem: Object {
    @objc dynamic var id:String = ""
    @objc dynamic var movieTitle = ""
    @objc dynamic var rating = ""
    @objc dynamic var overview = ""
    @objc dynamic var backdrop = ""
    @objc dynamic var actors = ""
    
    
    // tells realm which property is our primary key
    override open class func primaryKey() -> String? {
        return "id"
    }
}
