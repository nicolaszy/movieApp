//
//  FavoriteMovieModel.swift
//  MovieApp
//
//  Created by Nicolas Kalousek on 28.03.19.
//  Copyright © 2019 Nicolas Kalousek. All rights reserved.
//

import Foundation
import RealmSwift

class FavoriteMovieModel{
    
    let realm = try! Realm()
    
    private func createFavoriteMovieItem(id:Int, backdrop:URL, overview:String, rating:String, actors:String){
        let item = FavoriteMovieItem()
        item.id = id
        item.backdrop = backdrop.absoluteString
        item.overview = overview
        item.rating = rating
        item.actors = actors
        try! realm.write {
            realm.add(item)
        }
    }
    
    private func removeFavoriteMovieItem(id:Int){
        print("removing...")
        let itemToDelete = realm.objects(FavoriteMovieItem.self).filter("id = %@", id).first
        try! realm.write {
            realm.delete(itemToDelete!)
        }
        
    }
    
    func getAllMovies() -> [FavoriteMovieItem]{
        var allMovies = [FavoriteMovieItem]()
        let movies = realm.objects(FavoriteMovieItem.self)
        for movie in movies{
            allMovies.append(movie)
        }
        return allMovies
    }
    
    func checkIfMovieExists(id:Int)->Bool{
        if realm.objects(FavoriteMovieItem.self).filter("id = %@", id).first != nil{
            return true
        }
        else{ return false }
    }
    
    func setMovieRating(id:Int, movieRating:Int){
        if let item = realm.objects(FavoriteMovieItem.self).filter("id = %@", id).first{
            try! realm.write {
            item.personalRating = movieRating
            }
        }
    }
    
    func getMovieRating(id:Int) -> Int{
        if let item = realm.objects(FavoriteMovieItem.self).filter("id = %@", id).first{
            return item.personalRating
        }
        return -1
    }
    
    func getMovieTitle(id:Int, backdrop:URL, overview:String, rating:String, actors:String)->String{
        if let item = realm.objects(FavoriteMovieItem.self).filter("id = %@", id).first{
            return item.movieTitle
        }
        else{
            //if no item was found -> create one
            createFavoriteMovieItem(id: id, backdrop: backdrop, overview: overview, rating: rating, actors: actors)
        }
        return ""
    }
    
    func removeMovieTitle(id:Int)->String{
        if realm.objects(FavoriteMovieItem.self).filter("id = %@", id).first != nil{
            removeFavoriteMovieItem(id: id)
        }
        else{
            //if no item was found -> create one
            return "does not exist"
        }
        return ""
    }
    
    func changeMovieTitle(id:Int, newTitle:String){
        if let item = realm.objects(FavoriteMovieItem.self).filter("id = %@", id).first{
            
            try! realm.write {
                item.movieTitle = newTitle
            }
        }
    }
    
}
