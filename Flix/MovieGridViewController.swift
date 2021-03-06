//
//  MovieGridViewController.swift
//  Flix
//
//  Created by Jibril Mohamed on 3/4/22.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
  
    @IBOutlet var movieGridCollectionView: UICollectionView!
    
    var movies = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        movieGridCollectionView.delegate = self
        movieGridCollectionView.dataSource = self
        
//        movieGridCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        let layout = movieGridCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        layout.itemSize = CGSize(width: width, height: width * 2)
        

        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/634649/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    
                    // TODO: Get the array of movies
                 self.movies = dataDictionary["results"] as! [[String: Any]] // Casting to array of dictionary.
                 print("Movies:: \(self.movies)")
                 self.movieGridCollectionView.reloadData()
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data

             }
        }
        task.resume()
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieGridCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        let movie = movies[indexPath.row]
        
        let baseURL = "https://image.tmdb.org/t/p/w780"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)
        let title = movie["title"] as! String
        
        print("posterView: \(posterURL)")
        
        cell.posterView.af.setImage(withURL: posterURL!)
        cell.posterTitle?.text = title
        
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let cell = sender as! UICollectionViewCell
        let indexPath = movieGridCollectionView.indexPath(for: cell)!
        let movie = movies[indexPath.item]
        
        
        
        // Pass the selected object to the new view controller.
        let detailGridViewController = segue.destination as! MovieGridDetailViewController
        
        detailGridViewController.movie = movie
    }
    

}


