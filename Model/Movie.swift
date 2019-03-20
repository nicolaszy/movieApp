//
//  Movie.swift
//  MoyaExample
//
//  Created by Oliver Gepp on 17.02.19.
//  Copyright © 2019 fhnw Workshop. All rights reserved.
//

import Foundation

struct Movie {
    let id: Int
    let posterPath: String
    let backdrop: String
    let title: String
    let releaseDate: String
    let rating: Double
    let overview: String
    let popularity: Double
    
    var fullPosterURL:URL?{
        get{
            return URL(string: "https://image.tmdb.org/t/p/w500" + posterPath)
        }
    }
}

extension Movie: Decodable {
    enum MovieCodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case backdrop = "backdrop_path"
        case title
        case releaseDate = "release_date"
        case rating = "vote_average"
        case overview
        case popularity
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieCodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        backdrop = try container.decode(String.self, forKey: .backdrop)
        title = try container.decode(String.self, forKey: .title)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        rating = try container.decode(Double.self, forKey: .rating)
        overview = try container.decode(String.self, forKey: .overview)
        popularity = try container.decode(Double.self, forKey: .popularity)
    }
}
