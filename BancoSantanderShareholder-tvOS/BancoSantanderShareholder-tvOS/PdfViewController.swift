//
//  PdfViewController.swift
//  BancoSantanderShareholder-tvOS
//
//  Created by Michel Barbou Salvador on 15/02/16.
//  Copyright © 2016 Grupo CMC. All rights reserved.
//

import UIKit

class PdfViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images = [UIImage]()
    
    var pdf = Pdf()
    
    let defaultSize = CGSizeMake(500, 500)
    
    let focusSize = CGSizeMake(600, 600)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(pdf.url)
        
        getPdfFile()
    
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.images.count;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(768, 1080)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PdfCell", forIndexPath: indexPath) as? PdfCell {
            
            cell.titleLabel.layer.cornerRadius = 10
            cell.titleLabel.layer.masksToBounds = true
            
            cell.titleLabel.text = "Página \(indexPath.row + 1)"
            cell.imageView.image = self.images[indexPath.row]
            cell.imageView.contentMode = .ScaleAspectFit
            
            if cell.gestureRecognizers?.count == nil {
                
                let tap = UITapGestureRecognizer(target: self, action: "tapped:")
                tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
                cell.addGestureRecognizer(tap)
                
            }
            
            return cell
            
        } else {
            
            return PdfCell()
            
        }
    }
    
    // MARK: UICollectionViewDelegate
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        if let prev = context.previouslyFocusedView as? PdfCell {
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                prev.imageView.adjustsImageWhenAncestorFocused = false
                prev.titleLabel.alpha = 0.8
                
                
//                prev.imageView.frame.size = self.defaultSize
            })
        }
        
        if let next = context.nextFocusedView as? PdfCell {
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
//                next.imageView.frame.size = self.focusSize
                
                next.imageView.adjustsImageWhenAncestorFocused = true
            })
            
            collectionView.scrollEnabled = false
            let indexPath = collectionView.indexPathForCell(next)!
            collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
            
            UIView.animateWithDuration(2.0, animations: { () -> Void in
                
                //                next.imageView.frame.size = self.focusSize
                
                next.titleLabel.alpha = 0
            })
        }
        
    }
    
    
    func tapped(gesture: UITapGestureRecognizer) {
        
        
        
    }
    
    // MARK: Private Methods
    
    func getPdfFile(){
        
        let url = NSURL(string:pdf.url)!
        
        activityIndicator.startAnimating()
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            // Will happen when task completes
            
            if let pdfData = data {
                
                if let theImages = self.getImagesFromData(pdfData) {
                    
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        self.images = theImages
                        self.activityIndicator.stopAnimating()
                        self.collectionView.reloadData()
                    })
                    
                }
                
            } else {
                // Show error message
                print("Error al descargar pdf")
                self.activityIndicator.stopAnimating()
                
                let title = "Error"
                let message = "Ha ocurrido un error al descargar el PDF"
                
                let okButton = "OK"
                let retryButton = "Intentar Nuevamente"
                
                let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
                
                let okAction = UIAlertAction(title: okButton, style: .Default, handler: nil)
                let retryAction = UIAlertAction(title: retryButton, style: .Cancel) { _ in
                    
                    self.getPdfFile()
                }
                
                alert.addAction(okAction)
                alert.addAction(retryAction)
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
        task.resume()
    }
    
    
    func getImagesFromData(data: NSData) -> Array<UIImage>? {
        
        var images = [UIImage]()
        
//        guard let document = CGPDFDocumentCreateWithURL(url) else { return nil }
 
        let dataPtr = CFDataCreate(kCFAllocatorDefault, UnsafePointer<UInt8>(data.bytes), data.length)
        let dataProvider = CGDataProviderCreateWithCFData(dataPtr)
    
        guard let document = CGPDFDocumentCreateWithProvider(dataProvider) else {return nil}
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
