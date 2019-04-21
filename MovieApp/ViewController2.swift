//
//  ViewController2.swift
//  MovieApp
//
//  Created by Nicolas Kalousek on 18.03.19.
//  Copyright © 2019 Nicolas Kalousek. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    public var selectedSegment = 0
    public var movieTitle: String = "";
    public var backgroundUrl = URL(string: "https://www.apple.com")
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarTitle.title = movieTitle
        backgroundImage.clipsToBounds = true
        backgroundImage.kf.setImage(with: backgroundUrl)
        print(movieTitle)
        // Do any additional setup after loading the view.
        
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
