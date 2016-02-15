//
//  SecondViewController.swift
//  BancoSantanderShareholder-tvOS
//
//  Created by Michel Barbou Salvador on 12/02/16.
//  Copyright © 2016 Grupo CMC. All rights reserved.
//

import UIKit
import Alamofire

class SecondViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let defaultSize = CGSizeMake(500, 500)
    
    let focusSize = CGSizeMake(600, 600)
    
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let urlpath = NSBundle.mainBundle().pathForResource("Financialreport4Q2015", ofType: "pdf")
        let url:NSURL = NSURL.fileURLWithPath(urlpath!)

        let images = getImagesFromURL(url)

        if let theImages = images {

            self.images = theImages
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "goToPdfSegue" {
            
            if let pdfVC = segue.destinationViewController as? PdfViewController {
                
                if let theImages = sender {
                    
                    pdfVC.images = (theImages as? [UIImage])!
                }
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(500, 500)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DocumentCell", forIndexPath: indexPath) as? DocumentCell {
            
            
            cell.titleLabel.text = "Financialreport4Q2015 \(indexPath.row)"
            cell.imageView.image = UIImage(named: "santander.jpg")
            cell.imageView.contentMode = .ScaleAspectFit
           
            if cell.gestureRecognizers?.count == nil {
                
                let tap = UITapGestureRecognizer(target: self, action: "tapped:")
                tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
                cell.addGestureRecognizer(tap)
                
            }
            
            return cell
            
        } else {
            
            return DocumentCell()
            
        }
    }
    
    // MARK: UICollectionViewDelegate
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        if let prev = context.previouslyFocusedView as? DocumentCell {
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                prev.imageView.frame.size = self.defaultSize
            })
        }
        
        if let next = context.nextFocusedView as? DocumentCell {
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                next.imageView.frame.size = self.focusSize
            })
        }
        
    }
    
    
    func tapped(gesture: UITapGestureRecognizer) {
        
        if images.count > 0 {
            
            self.performSegueWithIdentifier("goToPdfSegue", sender: self.images)
        }
        
    }
    
    // MARK: Utils
    
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

