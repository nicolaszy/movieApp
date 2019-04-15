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
    
    public var exampleStringProperty: String = "";
    public var backgroundUrl = URL(string: "https://www.apple.com")
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarTitle.title = exampleStringProperty
        backgroundImage.clipsToBounds = true
        backgroundImage.kf.setImage(with: backgroundUrl)
        print(exampleStringProperty)
        // Do any additional setup after loading the view.
        
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
