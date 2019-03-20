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


    @IBOutlet weak var movieTable: UITableView!
    private let provider = NetworkManager()
    private var movies = [Movie]()
    
    //do your movie model thingie here 
    //private let myCell = cell()
    
    @IBOutlet weak var navPoint: UILabel!
    
    @IBOutlet weak var navigation: UISegmentedControl!
    
    @IBAction func navigationSelected(_ sender: Any) {
        let index = navigation.selectedSegmentIndex
        navPoint.text = navigation.titleForSegment(at: index)
        
        movies.removeAll()
        movieTable.reloadData()
        if navigation.selectedSegmentIndex == 0{
            loadNewMovies()
        }
        else if navigation.selectedSegmentIndex == 1{
            loadPopularNewMovies()
        } else {
            loadMoviesWithBradPitt()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupTableView()
        loadNewMovies()
    }

    private func setupTableView(){
        movieTable.register(UINib(nibName: cell.nibName, bundle: Bundle.main), forCellReuseIdentifier: cell.reuseIdentifier)
        
        movieTable.delegate = self
        movieTable.dataSource = self
    }
    

}


extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print("test")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovie" {
            if let destinationVC = segue.destination as? ViewController2 {
                destinationVC.exampleStringProperty = "Example"
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("selected a cell")
        performSegue(withIdentifier: "showMovie", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie = movies[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cell.reuseIdentifier, for: indexPath) as? cell{
            cell.movieTitle.text = movie.title
            //cell.overviewLabel.text = movie.overview
            
            //cell.popularity.text = String(movie.popularity)
            
            if let url = movie.fullPosterURL{
                cell.backgroundImage.kf.setImage(with: url)
            }
            
            return cell
        }
        return tableView.dequeueReusableCell(withIdentifier: cell.reuseIdentifier, for: indexPath)
    }
    
}


