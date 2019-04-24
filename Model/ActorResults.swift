//
//  Results.swift
//  MoyaExample
//
//  Created by Oliver Gepp on 17.02.19.
//  Copyright © 2019 fhnw Workshop. All rights reserved.
//

import Foundation

struct ActorResults {
    let credits: [Actor]
}

extension ActorResults: Decodable {
    
    private enum ActorResultsCodingKeys: String, CodingKey {
        case credits = "cast"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ActorResultsCodingKeys.self)
        credits = try container.decode([Actor].self, forKey: .credits)
        print("number of actors: "+String(credits.count))
    }
}
