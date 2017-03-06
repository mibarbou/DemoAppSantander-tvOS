//
//  FirstViewController.swift
//  BancoSantanderShareholder-tvOS
//
//  Created by Michel Barbou Salvador on 12/02/16.
//  Copyright © 2016 Grupo CMC. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash
import HCYoutubeParser
import AVFoundation
import Kingfisher


class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    
    let defaultSize = CGSize(width: 350, height: 220)
    let focusSize = CGSize(width: 420, height: 264)
    
    let defaultCellSize = CGSize(width: 540, height: 600)
    let focusCellSize = CGSize(width: 648, height: 720)
    
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // AIzaSyDihxCK70Qsf6S2e98dM8ku9tnYvdeO3LU   api youtube
        
        getYoutubeVideos()
        


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToVideoSegue" {
            
            if let movieVC = segue.destination as? VideoViewController {
                
                if let theMovie = sender {
                
                    movieVC.movie = theMovie as? Movie
                }
            }
        }
    }
 
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movies.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 540, height: 600)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell {
            
//            let movie = movies[indexPath.row]
//            cell.configureCell(movie)
            
            cell.layer.cornerRadius = 10
            
            let movie = movies[indexPath.row]
            
            
            cell.movie = movie
            cell.titleLabel.text = movie.title
            cell.descriptionLabel.text = movie.description
            cell.descriptionLabel.isHidden = true
            
            if let imageURL = URL(string: movie.thumbnail) {
            
                cell.imageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "santander.jpg"), options: nil, progressBlock: nil, completionHandler: nil)
            }
            

            
            
            if cell.gestureRecognizers?.count == nil {
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(FirstViewController.tapped(_:)))
                tap.allowedPressTypes = [NSNumber(value: UIPressType.select.rawValue as Int)]
                cell.addGestureRecognizer(tap)
                
            }
            
            return cell
            
        } else {
            
            return MovieCell()
            
        }
    }
    
    // MARK: UICollectionViewDelegate

    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        if let prev = context.previouslyFocusedView as? MovieCell {
            
            
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                
                prev.imageView.adjustsImageWhenAncestorFocused = false
                prev.descriptionLabel.isHidden = true


            })
        }
        
        if let next = context.nextFocusedView as? MovieCell {
            
            
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                
                next.imageView.adjustsImageWhenAncestorFocused = true
                next.descriptionLabel.isHidden = false
                

            })
        }
        
    }
    
    // MARK: Private functions
    
    
    func tapped(_ gesture: UITapGestureRecognizer) {
        
        if let cell = gesture.view as? MovieCell {
            // Load the next view controller and pass in the movie
            print("Tap detected... " + cell.titleLabel.text!)
            
            if let theMovie = cell.movie {
                
                self.performSegue(withIdentifier: "goToVideoSegue", sender: theMovie)

            }
            
        }
    }
    
    func getImagesFromURL(_ url: URL) -> Array<UIImage>? {
        
        var images = [UIImage]()
        
        guard let document = CGPDFDocument(url as NSURL) else { return nil }
        
        let pdfPages = document.numberOfPages;
        
        for i in 1...pdfPages {
        
            guard let page = document.page(at: i) else { return nil }
        
            let pageRect = page.getBoxRect(.mediaBox)
            
            UIGraphicsBeginImageContextWithOptions(pageRect.size, true, 0)
            let context = UIGraphicsGetCurrentContext()
            
            context?.setFillColor(UIColor.white.cgColor)
            context?.fill(pageRect)
            
            context?.translateBy(x: 0.0, y: pageRect.size.height);
            context?.scaleBy(x: 1.0, y: -1.0);
            
            context?.drawPDFPage(page);
            let img = UIGraphicsGetImageFromCurrentImageContext()
            
            images.append(img!)
            
        }
        
        UIGraphicsEndImageContext()
        
        return images
    }
    
    func getYoutubeVideos() {
        
        self.activityIndicator.startAnimating()
        
        Alamofire.request("https://www.googleapis.com/youtube/v3/playlistItems?part=snippet%2CcontentDetails&maxResults=50&playlistId=UUL8xzwgqyOr4748Efwe_dFw&key=AIzaSyALEEpQoXgEfav7Jb-1qj7e8fiU30V9nsw", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                do {
                    
                    let dict = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as? Dictionary<String, AnyObject>
                    
                    if let results = dict!["items"] as? [Dictionary<String, AnyObject>]{
                        
                        print(results)
                        
                        for obj in results {
                            
                            let movie = Movie(movieDict: obj)
                            self.movies.append(movie)
                        }
                        
                        self.activityIndicator.stopAnimating()
                        self.collectionView.reloadData()
                    }
                    
                    
                } catch {
                    
                    self.activityIndicator.stopAnimating()
                    
                }
            }
        }
        
    }


}

