//
//  ViewController2.swift
//  MovieApp
//
//  Created by Nicolas Kalousek on 18.03.19.
//  Copyright © 2019 Nicolas Kalousek. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var watchNextButton: UIButton!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var actors: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var personalRating: UILabel!
    
    
    @IBOutlet weak var ratingBar: UISegmentedControl!
    public var selectedSegment = 0
    public var movieTitle: String = "";
    public var backgroundUrl = URL(string: "https://www.apple.com")
    public var overview_: String = ""
    public var actors_ :String = ""
    public var ratings_ :String = ""
    public var id:Int = 0
    public var model = FavoriteMovieModel()
    public var isFavorite = false
    private let provider = NetworkManager()
    private var recommendedMovies = [Movie]()

    
    @IBAction func rateButtonPressed(_ sender: Any) {
        if(rateButton.title(for: UIControl.State.normal) == "Rate this movie"){
        rateButton.setTitle("", for: UIControl.State.normal)
        watchNextButton.setTitle("Submit rating", for: UIControl.State.normal)
        ratingBar.isHidden = false
        }
        else if(rateButton.title(for: UIControl.State.normal) == "Add Favorite"){
            _ = model.getMovieTitle(id: id, backdrop: backgroundUrl!, overview: overview_, rating: ratings_, actors: actors_)
            model.changeMovieTitle(id: id, newTitle: title!)
            print(model.getMovieTitle(id: id, backdrop: backgroundUrl!, overview: overview_, rating: ratings_, actors: actors_))
            rateButton.setTitle("Added", for: UIControl.State.normal)
        }
    }
    
    @IBAction func watchNextButtonPressed(_ sender: Any) {
        if(rateButton.title(for: UIControl.State.normal)==""){
            //submit rating
            if(ratingBar.selectedSegmentIndex==0){
                model.setMovieRating(id: id, movieRating: 1)
            }
            else if(ratingBar.selectedSegmentIndex==1){
                model.setMovieRating(id: id, movieRating: 2)
            }
            else if(ratingBar.selectedSegmentIndex==2){
                model.setMovieRating(id: id, movieRating: 3)
            }
            else{
                model.setMovieRating(id: id, movieRating: 4)
            }
            
            rateButton.setTitle("Rate this movie", for: UIControl.State.normal)
            watchNextButton.setTitle("What to watch next", for: UIControl.State.normal)
            ratingBar.isHidden = true
            personalRating.text = "Personal rating: "+String(ratingBar.selectedSegmentIndex+1)
        }
        else{
            //show movies to watch next
            provider.getRecommendationsForMovie(movieId: id) {[weak self] movies in
                print("\(movies.count) new movies loaded")
                self?.recommendedMovies.removeAll()
                self?.recommendedMovies.append(contentsOf: movies)
                let recommendationNumber = Int.random(in: 0...4)
                self?.backgroundImage.kf.setImage(with: movies[recommendationNumber].fullPosterURL)
                self?.backgroundUrl = movies[recommendationNumber].fullPosterURL
                self?.id = movies[recommendationNumber].id
                self?.movieTitle = movies[recommendationNumber].title
                print("movie title:"+movies[recommendationNumber].title)
                self?.title = movies[recommendationNumber].title
                self?.navBarTitle.title = movies[recommendationNumber].title
                var actorNames = ""
                var myActors = [Actor]();
                self?.provider.getActorsForMovie(movieId: self?.id ?? 0, completion: {[weak self] actor in
                    print(actor.count)
                    myActors.append(contentsOf: actor)
                    if(actor.count>2){
                        actorNames = actor[0].name + ", " + actor[1].name + ", " + actor[2].name + " and more..."
                    }
                    self?.actors_ = actorNames
                    self?.actors.text = self?.actors_
                })
                self?.overview.text = movies[recommendationNumber].overview
                self?.ratings_ = String(movies[recommendationNumber].rating)
                self?.rating.text = "rating: " + self!.ratings_
                self?.rateButton.setTitle("Add Favorite", for: UIControl.State.normal)
                self?.personalRating.isHidden = true
                self?.rateButton.isHidden = false
                }
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarTitle.title = movieTitle
        backgroundImage.clipsToBounds = true
        backgroundImage.kf.setImage(with: backgroundUrl)
        overview.text = overview_
        rating.text = "rating: "+ratings_
        actors.text = actors_
        ratingBar.isHidden = true
        print(movieTitle)
        // Do any additional setup after loading the view.
        let personalRating_ = model.getMovieRating(id: self.id)
        if(personalRating_ != -1){
        personalRating.text = "Personal rating: "+String(model.getMovieRating(id: self.id))
        ratingBar.selectedSegmentIndex = personalRating_-1
        }
        else{
            personalRating.text = "Rate this movie to show personal rating"
        }
        
        if(!self.isFavorite){
            rateButton.isHidden = true
            personalRating.isHidden = true
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("I was called...")
        if let destinationVC = segue.destination as? ViewController{
            destinationVC.selectedSegment = selectedSegment
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
