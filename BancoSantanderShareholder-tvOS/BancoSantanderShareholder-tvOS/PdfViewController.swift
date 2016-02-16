//
//  PdfViewController.swift
//  BancoSantanderShareholder-tvOS
//
//  Created by Michel Barbou Salvador on 15/02/16.
//  Copyright © 2016 Grupo CMC. All rights reserved.
//

import UIKit

class PdfViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var images = [UIImage]()
    
    let defaultSize = CGSizeMake(500, 500)
    
    let focusSize = CGSizeMake(600, 600)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        return images.count;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(768, 1080)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PdfCell", forIndexPath: indexPath) as? PdfCell {
            
            cell.titleLabel.layer.cornerRadius = 10
            cell.titleLabel.layer.masksToBounds = true
            
            cell.titleLabel.text = "Página \(indexPath.row + 1)"
            cell.imageView.image = images[indexPath.row]
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
