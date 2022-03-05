//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Jibril Mohamed on 3/4/22.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: [String: Any]!

    override func viewDidLoad() {
        super.viewDidLoad()

        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backropURL = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        
        titleLabel?.text = title
        posterView.af.setImage(withURL: posterURL!)
        backdropImageView.af.setImage(withURL: backropURL!)
        synopsisLabel?.text = synopsis

        // Do any additional setup after loading the view.
        print("Movie: \(movie)")
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
