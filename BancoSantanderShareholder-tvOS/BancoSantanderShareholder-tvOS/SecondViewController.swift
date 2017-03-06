//
//  SecondViewController.swift
//  BancoSantanderShareholder-tvOS
//
//  Created by Michel Barbou Salvador on 12/02/16.
//  Copyright © 2016 Grupo CMC. All rights reserved.
//

import UIKit
import Kingfisher
import SWXMLHash

class SecondViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let defaultSize = CGSize(width: 500, height: 500)
    
    let focusSize = CGSize(width: 600, height: 600)
    
    var images = [UIImage]()
    
    var pdfArray = [Pdf]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getXmlFile()
        self.collectionView.reloadData()
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToPdfSegue" {
            
            if let pdfVC = segue.destination as? PdfViewController {
                
                if let thePdf = sender {
                    
                    pdfVC.pdf = (thePdf as? Pdf)!
                }
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pdfArray.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 500, height: 600)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DocumentCell", for: indexPath) as? DocumentCell {
            
            cell.layer.cornerRadius = 10

            
            let pdf = pdfArray[indexPath.row]
            
            cell.titleLabel.text = pdf.title
            cell.sizeLabel.text = pdf.size + " KB"
//            cell.sizeLabel.adjustsFontSizeToFitWidth = true

            
            if pdf.icon != "" {
                
                if let imageURL = URL(string: pdf.icon) {
                                        
                    cell.imageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "santander.jpg"), options: nil, progressBlock: nil, completionHandler: nil)
                }
                
            } else {
                
                cell.imageView.image = UIImage(named: "santander.jpg")
            }
                
            
            cell.imageView.contentMode = .scaleAspectFit
           
            if cell.gestureRecognizers?.count == nil {
             
                let tap = UITapGestureRecognizer(target: self, action: #selector(SecondViewController.tapped(_:)) )
                tap.allowedPressTypes = [NSNumber(value: UIPressType.select.rawValue as Int)]
                cell.addGestureRecognizer(tap)
                
            }
            
            return cell
            
        } else {
            
            return DocumentCell()
            
        }
    }
    
    // MARK: UICollectionViewDelegate
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        if let prev = context.previouslyFocusedView as? DocumentCell {
            
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                
                prev.imageView.adjustsImageWhenAncestorFocused = false

                
//                prev.imageView.frame.size = self.defaultSize
            })
        }
        
        if let next = context.nextFocusedView as? DocumentCell {
            
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                
                next.imageView.adjustsImageWhenAncestorFocused = true

                
//                next.imageView.frame.size = self.focusSize
            })
        }
        
    }

    
    func tapped(_ gesture: UITapGestureRecognizer) {
        
        if pdfArray.count > 0  {
            
            let itemTapped = gesture.view as? DocumentCell
            
            if let theItem = itemTapped {
            
                let indexPath = self.collectionView.indexPath(for: theItem)
                
                if let theIndex = indexPath {
                    
                    print("celda pulsada: \(theIndex.row)")
                    
                    self.performSegue(withIdentifier: "goToPdfSegue", sender:pdfArray[theIndex.row])
                }
                
            }

        }
        
    }
    
    // MARK: Utils
    
    func getXmlFile() {
        
        let path = Bundle.main.path(forResource: "documentos_pdf", ofType: "xml")
        
        if path != nil {
            
            let data: Data? = try? Data(contentsOf: URL(fileURLWithPath: path!))
            
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
    
    
    func getImagesFromURL(_ url: URL) -> Array<UIImage>? {
        
        var images = [UIImage]()
        
        guard let document = CGPDFDocument(url as NSURL) else { return nil }
        
        let pdfPages = document.numberOfPages;
        
        for i in 1...pdfPages{
            
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

