//
//  TheMovieDB_API.swift
//  MoyaExample
//
//  Created by Oliver Gepp on 17.02.19.
//  Copyright © 2019 fhnw Workshop. All rights reserved.
//

import Foundation
import Moya

enum TheMovieDB_Api {
    case recommended(id:Int)
    case popular(page:Int)
    case newMovies(page:Int)
    case video(id:Int)
    case actor(ids:[Int])
}

extension TheMovieDB_Api: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/") else {
            fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .recommended(let id):
            return "movie/\(id)/recommendations"
        case .popular:
            return "movie/popular"
        case .newMovies:
            return "movie/now_playing"
        case .video(let id):
            return "movie/\(id)/videos"
        case .actor:
            return "discover/movie"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .recommended, .video:
            return .requestParameters(parameters: ["api_key":  NetworkManager.MovieAPIKey], encoding: URLEncoding.queryString)
        case .popular(let page), .newMovies(let page):
            return .requestParameters(parameters: ["page":page, "api_key": NetworkManager.MovieAPIKey], encoding: URLEncoding.queryString)
        case .actor(let ids):
            let params = ids.map({"\($0)"}).joined(separator: ",")
            return .requestParameters(parameters: ["api_key": NetworkManager.MovieAPIKey, "with_people": params], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}
