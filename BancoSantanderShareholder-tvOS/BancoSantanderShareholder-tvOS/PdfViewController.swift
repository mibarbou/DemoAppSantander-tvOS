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
    
    let defaultSize = CGSize(width: 500, height: 500)
    
    let focusSize = CGSize(width: 600, height: 600)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(pdf.url)
        
        getPdfFile()
    
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToPdfDetailSegue" {
            
            if let pdfVC = segue.destination as? PdfDetailViewController {
                
                if let theImage = sender {
                    
                    pdfVC.image = (theImage as? UIImage)!
                }
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.images.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 768, height: 1080)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PdfCell", for: indexPath) as? PdfCell {
            
            cell.titleLabel.layer.cornerRadius = 10
            cell.titleLabel.layer.masksToBounds = true
            
            cell.titleLabel.text = "Página \(indexPath.row + 1)"
            cell.imageView.image = self.images[indexPath.row]
            cell.imageView.contentMode = .scaleAspectFit
            
            if cell.gestureRecognizers?.count == nil {
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(PdfViewController.tapped(_:)))
                tap.allowedPressTypes = [NSNumber(value: UIPressType.select.rawValue as Int)]
                cell.addGestureRecognizer(tap)
                
            }
            
            return cell
            
        } else {
            
            return PdfCell()
            
        }
    }
    
    // MARK: UICollectionViewDelegate
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        if let prev = context.previouslyFocusedView as? PdfCell {
            
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                
                prev.imageView.adjustsImageWhenAncestorFocused = false
                prev.titleLabel.alpha = 0.8
                
                
//                prev.imageView.frame.size = self.defaultSize
            })
        }
        
        if let next = context.nextFocusedView as? PdfCell {
            
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                
//                next.imageView.frame.size = self.focusSize
                
                next.imageView.adjustsImageWhenAncestorFocused = true
            })
            
            collectionView.isScrollEnabled = false
            let indexPath = collectionView.indexPath(for: next)!
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            UIView.animate(withDuration: 2.0, animations: { () -> Void in
                
                //                next.imageView.frame.size = self.focusSize
                
                next.titleLabel.alpha = 0
            })
        }
        
    }
    
    
    func tapped(_ gesture: UITapGestureRecognizer) {
        
        
        if images.count > 0  {
            
            let itemTapped = gesture.view as? PdfCell
            
            if let theItem = itemTapped {
                
                let indexPath = self.collectionView.indexPath(for: theItem)
                
                if let theIndex = indexPath {
                    
                    print("celda pulsada: \(theIndex.row)")
                    
                    self.performSegue(withIdentifier: "goToPdfDetailSegue", sender:images[theIndex.row])
                }
                
            }
            
        }
        
    }
    
    // MARK: Private Methods
    
    func getPdfFile(){
        
        let url = URL(string:pdf.url)!
        
        activityIndicator.startAnimating()
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            
            // Will happen when task completes
            
            if let pdfData = data {
                
                if let theImages = self.getImagesFromData(pdfData) {
                    
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        
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
                
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: okButton, style: .default, handler: nil)
                let retryAction = UIAlertAction(title: retryButton, style: .cancel) { _ in
                    
                    self.getPdfFile()
                }
                
                alert.addAction(okAction)
                alert.addAction(retryAction)
                
                self.present(alert, animated: true, completion: nil)
            }
        }) 
        
        task.resume()
    }
    
    
    func getImagesFromData(_ data: Data) -> Array<UIImage>? {
        
        var images = [UIImage]()
         
        let dataPtr = CFDataCreate(kCFAllocatorDefault, (data as NSData).bytes.bindMemory(to: UInt8.self, capacity: data.count), data.count)
        let dataProvider = CGDataProvider(data: dataPtr!)
    
        guard let document = CGPDFDocument(dataProvider!) else {return nil}
        
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
    

}
