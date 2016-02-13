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


class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let defaultSize = CGSizeMake(320, 420)
    
    let focusSize = CGSizeMake(384, 504)
    
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Alamofire.request(.GET, "https://microsite.bancosantander.es/files/2015_junta_es/galeria_medios.xml").response { (request, response, data, error) -> Void in
            
            if error != nil {
                
                print(error)
                
            } else {
            
                let xml = SWXMLHash.parse(data!)
                
                for elem in xml["media"]["videos"]["item"] {
                    
                    print(elem["title"].element!.text!)
                    
                    let title = elem["title"].element!.text!
                    let description = elem["description"].element!.text!
                    let url = elem["url"].element!.text!
                    let thumbnail = elem["thumbnail"].element!.text!
                    
                    let movie = Movie(title: title, url: url, thumbnail: thumbnail, description: description)
                    
                    self.movies.append(movie)
                    
                }
                
                print(xml)
                print(request)
                print(response)
                self.collectionView.reloadData()
            
            }
        }
        
        let urlpath = NSBundle.mainBundle().pathForResource("Financialreport4Q2015", ofType: "pdf")
        let url:NSURL = NSURL.fileURLWithPath(urlpath!)
        
        let images = getImagesFromURL(url)
        
        if let theImages = images {
            
            print(theImages)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
 
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movies.count;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(500, 660)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCell", forIndexPath: indexPath) as? MovieCell {
            
//            let movie = movies[indexPath.row]
//            cell.configureCell(movie)
            
            let movie = movies[indexPath.row]
            
            cell.imageView.image = UIImage(contentsOfFile: movie.thumbnail)
            cell.titleLabel.text = movie.title
            
            if movie.thumbnail != "" {
            
                if let theThumbUrl = NSURL(string: movie.thumbnail) {
                    
                    if let data = NSData(contentsOfURL: theThumbUrl) {
                        
                        cell.imageView.image = UIImage(data: data)
                    }
                    
                }
                
            } else {
                
                cell.imageView.image = UIImage(named: "santander.jpg")
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
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        if let prev = context.previouslyFocusedView as? MovieCell {
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                prev.imageView.frame.size = self.defaultSize
            })
        }
        
        if let next = context.nextFocusedView as? MovieCell {
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                next.imageView.frame.size = self.focusSize
            })
        }
        
    }
    
    
    func tapped(gesture: UITapGestureRecognizer) {
        
        if let cell = gesture.view as? MovieCell {
            // Load the next view controller and pass in the movie
            print("Tap detected... " + cell.titleLabel.text!)
            
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


}

