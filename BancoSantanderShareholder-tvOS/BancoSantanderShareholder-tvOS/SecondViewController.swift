//
//  SecondViewController.swift
//  BancoSantanderShareholder-tvOS
//
//  Created by Michel Barbou Salvador on 12/02/16.
//  Copyright © 2016 Grupo CMC. All rights reserved.
//

import UIKit
import SWXMLHash


class SecondViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let defaultSize = CGSizeMake(500, 500)
    
    let focusSize = CGSizeMake(600, 600)
    
    var images = [UIImage]()
    
    var pdfArray = [Pdf]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getXmlFile()
        self.collectionView.reloadData()
        
//        let urlpath = NSBundle.mainBundle().pathForResource("Financialreport4Q2015", ofType: "pdf")
//        let url:NSURL = NSURL.fileURLWithPath(urlpath!)
//
//        let images = getImagesFromURL(url)
//
//        if let theImages = images {
//
//            self.images = theImages
//        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "goToPdfSegue" {
            
            if let pdfVC = segue.destinationViewController as? PdfViewController {
                
                if let thePdf = sender {
                    
                    pdfVC.pdf = (thePdf as? Pdf)!
                }
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pdfArray.count;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(500, 600)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DocumentCell", forIndexPath: indexPath) as? DocumentCell {
            
            cell.layer.cornerRadius = 10
//            cell.layer.shadowColor = UIColor.darkGrayColor().CGColor
//            cell.layer.shadowOffset = CGSizeMake(2.0, 2.0)
            
            let pdf = pdfArray[indexPath.row]
            
            cell.titleLabel.text = pdf.title
            cell.sizeLabel.text = pdf.size + " MB"
//            cell.sizeLabel.adjustsFontSizeToFitWidth = true
            cell.imageView.image = UIImage(named: "santander.jpg")
            
            if pdf.icon != "" {
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { () -> Void in
            
                    if let theIcon = NSURL(string: pdf.icon) {
                        
                        if let data = NSData(contentsOfURL: theIcon) {
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                
                                cell.imageView.image = UIImage(data: data)
                            })
           
                        }
                        
                    }
                })
                
            } else {
                
                cell.imageView.image = UIImage(named: "santander.jpg")
            }
                
            
            cell.imageView.contentMode = .ScaleAspectFit
           
            if cell.gestureRecognizers?.count == nil {
             
                let tap = UITapGestureRecognizer(target: self, action: "tapped:" )
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
                
                prev.imageView.adjustsImageWhenAncestorFocused = false

                
//                prev.imageView.frame.size = self.defaultSize
            })
        }
        
        if let next = context.nextFocusedView as? DocumentCell {
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                next.imageView.adjustsImageWhenAncestorFocused = true

                
//                next.imageView.frame.size = self.focusSize
            })
        }
        
    }

    
    func tapped(gesture: UITapGestureRecognizer) {
        
        if pdfArray.count > 0  {
            
            let itemTapped = gesture.view as? DocumentCell
            
            if let theItem = itemTapped {
            
                let indexPath = self.collectionView.indexPathForCell(theItem)
                
                if let theIndex = indexPath {
                    
                    print("celda pulsada: \(theIndex.row)")
                    
                    self.performSegueWithIdentifier("goToPdfSegue", sender:pdfArray[theIndex.row])
                }
                
            }

        }
        
    }
    
    // MARK: Utils
    
    func getXmlFile() {
        
        let path = NSBundle.mainBundle().pathForResource("documentos_pdf", ofType: "xml")
        
        if path != nil {
            
            let data: NSData? = NSData(contentsOfFile:path!)
            
            if let fileData = data {
                
                let xml = SWXMLHash.parse(fileData)
//                print(xml)
                
                for elem in xml["pdf_documents"]["reports"]["annual_reports"]["year"] {
                    
                    for item in elem["documents"]["item"] {
                        
                        let title = item["title"].element!.text!
                        let docname = item["title"].element!.text!
                        let url = item["url"].element!.text!
                        let size = item["size"].element!.text!
                        let icon = item["icon"].element!.text!
                        
                        
                        // Solo mostramos PDF que tengan de peso un máximo
                        
                        let sizeInt:Int? = Int(size)
                        
                        if let theSize = sizeInt {
                        
                            if (theSize < 2000) {
                            
                                let pdf = Pdf(docname: docname, title: title, url: url, size: size, icon: icon)
                                
                                pdfArray.append(pdf)
                                
                            }
                        }
                        
//                        print(item)
                    }
                    
                    
                }
                
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


}

