//
//  ViewController.swift
//  MovieApp
//
//  Created by Nicolas Kalousek on 11.03.19.
//  Copyright © 2019 Nicolas Kalousek. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    let model = FavoriteMovieModel()
    
    @IBOutlet weak var movieSearchButton: UIButton!
    @IBOutlet weak var movieSearchField: UITextField!
    @IBOutlet weak var movieTable: UITableView!
    private var selectedMovie = ""
    private var selectedMovieBackground = URL(string: "https://www.apple.com")
    private let provider = NetworkManager()
    private var movies = [Movie]()
    private var favoriteMovies = [FavoriteMovieItem]()
    private var favorite = false
    public var selectedSegment = -1
    
    //do your movie model thingie here 
    //private let myCell = cell()
    
    @IBOutlet weak var navPoint: UILabel!
    
    @IBOutlet weak var navigation: UISegmentedControl!
    
    @IBAction func searchPressed(_ sender: Any) {
        
        let title = movieSearchField.text!
        provider.getMoviesWithTitle(title: title, completion: {[weak self] movies in
            print("\(movies.count) new movies loaded")
            self?.movies.removeAll()
            self?.movies.append(contentsOf: movies)
            self?.movieTable.reloadData()
        })
    }
    
    @IBAction func navigationSelected(_ sender: Any) {
        let index = navigation.selectedSegmentIndex
        navPoint.text = navigation.titleForSegment(at: index)
        
        if navigation.selectedSegmentIndex == 0{
            movieSearchField.isHidden = true
            movieSearchButton.isHidden = true
            navPoint.isHidden = false
            favorite = false
            movies.removeAll()
            movieTable.reloadData()
            loadNewMovies()
        }
        else if navigation.selectedSegmentIndex == 1{
            movieSearchField.isHidden = true
            movieSearchButton.isHidden = true
            navPoint.isHidden = false
            favorite = false
            movies.removeAll()
            movieTable.reloadData()
            loadPopularNewMovies()
        } else if navigation.selectedSegmentIndex == 2{
            movieSearchField.isHidden = false
            movieSearchButton.isHidden = false
            navPoint.isHidden = true
            favorite = false
            movies.removeAll()
            movieTable.reloadData()
            loadMoviesWithBradPitt()
        }
        else {
            movieSearchField.isHidden = true
            movieSearchButton.isHidden = true
            navPoint.isHidden = false
            favorite = true
            movies.removeAll()
            movieTable.reloadData()
            loadFavoriteMovies()
        }
    }
    
    private func loadNewMovies(){
        
        provider.getNewMovies(page: 1) {[weak self] movies in
            print("\(movies.count) new movies loaded")
            self?.movies.removeAll()
            self?.movies.append(contentsOf: movies)
            self?.movieTable.reloadData()
        }
    }
    
    private func loadPopularNewMovies(){
        
        provider.getPopularMovies(page: 1) {[weak self] movies in
            print("\(movies.count) popular movies loaded")
            self?.movies.removeAll()
            self?.movies.append(contentsOf: movies)
            self?.movieTable.reloadData()
        }
    }
    
    private func loadMoviesWithBradPitt() {
        provider.getMoviesWithActors(actorIds: [819]) {[weak self] movies in
            print("\(movies.count) popular movies loaded")
            self?.movies.removeAll()
            self?.movies.append(contentsOf: movies)
            self?.movieTable.reloadData()
        }
    }
    
    private func loadFavoriteMovies(){
        
        let faves = model.getAllMovies()
        self.favoriteMovies.removeAll()
        self.favoriteMovies.append(contentsOf: faves)
       
        self.movieTable.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupTableView()
        loadNewMovies()
    }

    private func setupTableView(){
        movieTable.register(UINib(nibName: cell.nibName, bundle: Bundle.main), forCellReuseIdentifier: cell.reuseIdentifier)
        
        if(selectedSegment != -1){
            navigation.selectedSegmentIndex = selectedSegment
        }
        
        movieTable.delegate = self
        movieTable.dataSource = self
    }
    

}


extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("I was called...")
        if let destinationVC = segue.destination as? ViewController2{
            destinationVC.movieTitle = self.selectedMovie
            destinationVC.backgroundUrl = selectedMovieBackground
            destinationVC.selectedSegment = navigation.selectedSegmentIndex
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if(favorite==false){
            self.selectedMovie = movies[indexPath.row].title
            self.selectedMovieBackground = movies[indexPath.row].fullPosterURL!
            performSegue(withIdentifier: "showMovie", sender: self)
        }
        else{
            self.selectedMovie = favoriteMovies[indexPath.row].movieTitle
            self.selectedMovieBackground = URL(string: favoriteMovies[indexPath.row].backdrop)
            performSegue(withIdentifier: "showMovie", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(favorite==false){
            return movies.count
        }
        else{
            return favoriteMovies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(favorite==false){
        
        let movie = movies[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cell.reuseIdentifier, for: indexPath) as? cell{
            cell.movieTitle.text = movie.title
            cell.rating.text = "rated "+String(movie.rating)
            cell.backdropURL = movie.fullBackdropURL
            let favorited = model.checkIfMovieExists(id: cell.movieTitle.text!)
            if(favorited){
                cell.addedLabel.text = "added"
                cell.favorited = true
            }
            else{
                cell.addedLabel.text = ""
                cell.favorited = false
            }
            
            //use something else than nibName (e.g. movie title) as identifier so we can use and load favorited as property!!!
            //cell.favorited = model.getMovieTitle(id: cell.nibName)
            
            
            //cell.overviewLabel.text = movie.overview
            
            //cell.popularity.text = String(movie.popularity)
            
            if let url = movie.fullBackdropURL{
                cell.backgroundImage.kf.setImage(with: url)
            }
//            if let url = movie.fullPosterURL{
//                cell.backgroundImage.kf.setImage(with: url)
//            }
            
            return cell
        }
        }
        else{
            let movie = favoriteMovies[indexPath.row]
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: cell.reuseIdentifier, for: indexPath) as? cell{
                cell.movieTitle.text = movie.movieTitle
                cell.backdropURL = URL(string: movie.backdrop)
                cell.addedLabel.text = "added"
                
                //cell.rating.text = "rated "+String(movie.rating)
                //use something else than nibName (e.g. movie title) as identifier so we can use and load favorited as property!!!
                //cell.favorited = model.getMovieTitle(id: cell.nibName)
                
                
                //cell.overviewLabel.text = movie.overview
                
                //cell.popularity.text = String(movie.popularity)
                
                if let url = URL(string: movie.backdrop){
                    cell.backgroundImage.kf.setImage(with: url)
                }
                
                return cell
            }
        }
            return tableView.dequeueReusableCell(withIdentifier: cell.reuseIdentifier, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        let cell = tableView.cellForRow(at: indexPath) as! cell
        let favorited = model.checkIfMovieExists(id: cell.movieTitle.text!)
        let favorite = UIContextualAction(style: .normal, title: "Add Favorite"){(contextualAction, view, ActionPerformed: (Bool) -> ()) in
            if(!favorited){
                //perform add favorite
                cell.addFavorite(model: self.model)
            }
            else{
                //perform delete favorite
                cell.removeFavorite(model: self.model)
                if(self.favorite){
                    self.movies.removeAll()
                    self.movieTable.reloadData()
                    self.loadFavoriteMovies()
                }
            }
            
            ActionPerformed(true)
        }
        favorite.backgroundColor = favorited ? .red : .green
        favorite.title = favorited ? "Remove Favorite" : "Add Favorite"
        
        return UISwipeActionsConfiguration(actions: [favorite])
    }
    
}


