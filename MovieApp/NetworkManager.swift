//
//  NetworkManager.swift
//  MoyaExample
//
//  Created by Oliver Gepp on 17.02.19.
//  Copyright © 2019 fhnw Workshop. All rights reserved.
//

import Foundation
import Moya

protocol Network {
    associatedtype T: TargetType
    var provider: MoyaProvider<T> { get }
}

struct NetworkManager: Network {
    
    static let MovieAPIKey = "7a312711d0d45c9da658b9206f3851dd"
    let provider = MoyaProvider<TheMovieDB_Api>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    func getMoviesWithTitle(title: String, completion: @escaping ([Movie])->()){
        provider.request(.movies(title: title)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(Results.self, from: response.data)
                    completion(results.movies)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    func getNewMovies(page: Int, completion: @escaping ([Movie])->()){
        provider.request(.newMovies(page: page)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(Results.self, from: response.data)
                    completion(results.movies)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getPopularMovies(page: Int, completion: @escaping ([Movie])->()){
        
        provider.request(.popular(page: 1)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(Results.self, from: response.data)
                    completion(results.movies)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getMoviesWithActors(actorIds: [Int], completion: @escaping ([Movie]) -> ()) {
        
        provider.request(.actor(ids: actorIds)) { result in
            switch result {
            case let .success(response):
                do {
                    let result = try JSONDecoder().decode(Results.self, from: response.data)
                    completion(result.movies)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getActorsForMovie(movieId: Int, completion: @escaping ([Actor]) -> ()) {

        provider.request(.credits(id: movieId)) { result in
            switch result {
            case let .success(response):
                do {
                    let result = try JSONDecoder().decode(ActorResults.self, from: response.data)
                    print("count:"+String(result.credits.count))
                    completion(result.credits)
                } catch let err {
                    print("error.....")
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    func getRecommendationsForMovie(movieId: Int, completion: @escaping ([Movie]) -> ()) {
        
        provider.request(.recommended(id: movieId)) { result in
            switch result {
            case let .success(response):
                do {
                    let result = try JSONDecoder().decode(Results.self, from: response.data)
                    print("count:"+String(result.movies.count))
                    completion(result.movies)
                } catch let err {
                    print("error.....")
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
}
