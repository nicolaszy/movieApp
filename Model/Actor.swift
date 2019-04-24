//
//  Movie.swift
//  MoyaExample
//
//  Created by Oliver Gepp on 17.02.19.
//  Copyright © 2019 fhnw Workshop. All rights reserved.
//

import Foundation

struct Actor {
    let id: Int
    let character: String
    let name: String
    //let profile_path: String

    }

extension Actor: Decodable {
    enum ActorCodingKeys: String, CodingKey {
        case id
        case character
        case name
        //case profile_path = "profile_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ActorCodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        character = try container.decode(String.self, forKey: .character)
        name = try container.decode(String.self, forKey: .name)
        //profile_path = try container.decode(String.self, forKey: .profile_path)
    }
    
}
