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

    
    let defaultSize = CGSizeMake(350, 220)
    let focusSize = CGSizeMake(420, 264)
    
    let defaultCellSize = CGSizeMake(540, 600)
    let focusCellSize = CGSizeMake(648, 720)
    
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // AIzaSyDihxCK70Qsf6S2e98dM8ku9tnYvdeO3LU   api youtube
        
        getYoutubeVideos()
        
//        Alamofire.request(.GET, "https://www.googleapis.com/youtube/v3/channels?part=banco+santander&managedByMe=false&maxResults=20&mine=false&key=AIzaSyDihxCK70Qsf6S2e98dM8ku9tnYvdeO3LU").response { (request, response, data, error) -> Void in
//            
//            if error != nil {
//                
//                print(error)
//                
//            } else {
//            
//                let xml = SWXMLHash.parse(data!)
//                
//                for elem in xml["media"]["videos"]["item"] {
//                    
//                    print(elem["title"].element!.text!)
//                    
//                    let title = elem["title"].element!.text!
//                    let description = elem["description"].element!.text!
//                    let url = elem["url"].element!.text!
//                    let thumbnail = elem["thumbnail"].element!.text!
//                    
//                    let movie = Movie(title: title, url: url, thumbnail: thumbnail, description: description)
//                    
//                    self.movies.append(movie)
//                    
//                }
//                
//                print(xml)
//                print(request)
//                print(response)
//                self.collectionView.reloadData()
//            
//            }
//        }
        
//        let urlpath = NSBundle.mainBundle().pathForResource("Financialreport4Q2015", ofType: "pdf")
//        let url:NSURL = NSURL.fileURLWithPath(urlpath!)
//        
//        let images = getImagesFromURL(url)
//        
//        if let theImages = images {
//            
//            print(theImages)
//        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "goToVideoSegue" {
            
            if let movieVC = segue.destinationViewController as? VideoViewController {
                
                if let theMovie = sender {
                
                    movieVC.movie = theMovie as? Movie
                }
            }
        }
    }
 
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
 
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movies.count;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(540, 600)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCell", forIndexPath: indexPath) as? MovieCell {
            
//            let movie = movies[indexPath.row]
//            cell.configureCell(movie)
            
            cell.layer.cornerRadius = 10
            
            let movie = movies[indexPath.row]
            
            
            cell.movie = movie
            cell.titleLabel.text = movie.title
            cell.descriptionLabel.text = movie.description
            cell.descriptionLabel.hidden = true
            
            if let imageURL = NSURL(string: movie.thumbnail) {
            
                cell.imageView.kf_setImageWithURL(imageURL, placeholderImage: UIImage(named: "santander.jpg"))
            }
            

            
            
            if cell.gestureRecognizers?.count == nil {
                
                let tap = UITapGestureRecognizer(target: self, action: "tapped:")
                tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
                cell.addGestureRecognizer(tap)
                
            }
            
            return cell
            
        } else {
            
            return MovieCell()
            
        }
    }
    
    // MARK: UICollectionViewDelegate

    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        if let prev = context.previouslyFocusedView as? MovieCell {
            
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                prev.imageView.adjustsImageWhenAncestorFocused = false
                prev.descriptionLabel.hidden = true

                
//                prev.frame.size = self.defaultCellSize
//                prev.imageView.frame.size = self.defaultSize
            })
        }
        
        if let next = context.nextFocusedView as? MovieCell {
            
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                next.imageView.adjustsImageWhenAncestorFocused = true
                next.descriptionLabel.hidden = false
                
//                next.frame.size = self.focusCellSize
//                next.imageView.frame.size = self.focusSize
            })
        }
        
    }
    
    // MARK: Private functions
    
    
    func tapped(gesture: UITapGestureRecognizer) {
        
        if let cell = gesture.view as? MovieCell {
            // Load the next view controller and pass in the movie
            print("Tap detected... " + cell.titleLabel.text!)
            
            if let theMovie = cell.movie {
                
                self.performSegueWithIdentifier("goToVideoSegue", sender: theMovie)
                
            
//                let youTubeString : String = "https://www.youtube.com/watch?v=" + theMovie.videoId
//                let videos : NSDictionary = HCYoutubeParser.h264videosWithYoutubeURL(NSURL(string: youTubeString))
//                let urlString : String = videos["medium"] as! String
//                let asset = AVAsset(URL: NSURL(string: urlString)!)
//                
//                let avPlayerItem = AVPlayerItem(asset:asset)
//                let avPlayer = AVPlayer(playerItem: avPlayerItem)
//                let avPlayerLayer  = AVPlayerLayer(player: avPlayer)
//                avPlayerLayer.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height);
//                self.view.layer.addSublayer(avPlayerLayer)
//                avPlayer.play()
            }
            
        }
    }
    
    func getImagesFromURL(url: NSURL) -> Array<UIImage>? {
        
        var images = [UIImage]()
        
        guard let document = CGPDFDocumentCreateWithURL(url) else { return nil }
        
        let pdfPages = CGPDFDocumentGetNumberOfPages(document);
        
        for (var i = 1; i <= pdfPages; i++){
        
            guard let page = CGPDFDocumentGetPage(document, i) else { return nil }
        
            let pageRect = CGPDFPageGetBoxRect(page, .MediaBox)
            
            UIGraphicsBeginImageContextWithOptions(pageRect.size, true, 0)
            let context = UIGraphicsGetCurrentContext()
            
            CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
            CGContextFillRect(context,pageRect)
            
            CGContextTranslateCTM(context, 0.0, pageRect.size.height);
            CGContextScaleCTM(context, 1.0, -1.0);
            
            CGContextDrawPDFPage(context, page);
            let img = UIGraphicsGetImageFromCurrentImageContext()
            
            images.append(img)
            
        }
        
        UIGraphicsEndImageContext()
        
        return images
    }
    
    func getYoutubeVideos() {
        
        self.activityIndicator.startAnimating()
        
        Alamofire.request(.GET, "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet%2CcontentDetails&maxResults=50&playlistId=UUL8xzwgqyOr4748Efwe_dFw&key=AIzaSyALEEpQoXgEfav7Jb-1qj7e8fiU30V9nsw").response { (request, response, data, error) -> Void in
            
            
            if error != nil {
                
                print(error.debugDescription)
                self.activityIndicator.stopAnimating()
                
            } else {
                
                do {
                    
                    let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? Dictionary<String, AnyObject>
                    
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

