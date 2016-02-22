//
//  CotizacionesViewController.swift
//  BancoSantanderShareholder-tvOS
//
//  Created by Michel Barbou Salvador on 19/02/16.
//  Copyright © 2016 Grupo CMC. All rights reserved.
//

import UIKit

class CotizacionesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let defaultSize = CGSizeMake(700, 650)
    
    let focusSize = CGSizeMake(840, 780)
    
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
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 8;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(700, 650)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("StockCell", forIndexPath: indexPath) as? StockCell {
            
            cell.layer.cornerRadius = 10
            
            switch indexPath.row {
                
            case 0:
                cell.cityLabel?.text = "LONDRES"
            case 1:
                cell.cityLabel?.text = "BUENOS AIRES"
            case 2:
                cell.cityLabel?.text = "LISBOA"
            case 3:
                cell.cityLabel?.text = "MADRID"
            case 4:
                cell.cityLabel?.text = "MEXICO"
            case 5:
                cell.cityLabel?.text = "MILAN"
            case 6:
                cell.cityLabel?.text = "NUEVA YORK"
            case 7:
                cell.cityLabel?.text = "VARSOVIA"
            default:
                break
                
            }
            
            
            if cell.gestureRecognizers?.count == nil {
                
                let tap = UITapGestureRecognizer(target: self, action: "tapped:")
                tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
                cell.addGestureRecognizer(tap)
                
            }
            
            return cell
            
        } else {
            
            return StockCell()
            
        }
    }
    
    // MARK: UICollectionViewDelegate
 
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        
        if let prev = context.previouslyFocusedView as? StockCell {
            
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                prev.center = CGPointMake(prev.center.x,prev.center.y + 200)
            
//                prev.frame.size = self.defaultSize
//                prev.layer.shadowColor = UIColor.clearColor().CGColor
//                prev.layer.shadowOffset = CGSizeMake(0, 0)
//                prev.layer.masksToBounds = true

//                prev.imageView.adjustsImageWhenAncestorFocused = false
//                prev.descriptionLabel.hidden = true
                
                
                //                prev.frame.size = self.defaultCellSize
                //                prev.imageView.frame.size = self.defaultSize
            })
        }
        
        if let next = context.nextFocusedView as? StockCell {
            
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                next.center = CGPointMake(next.center.x,next.center.y - 200)
                
//                next.frame.size = self.focusSize
                
//                next.layer.shadowColor = UIColor.darkGrayColor().CGColor
//                next.layer.shadowOffset = CGSizeMake(10, 10)
//                next.layer.masksToBounds = true
//                next.imageView.adjustsImageWhenAncestorFocused = true
//                next.descriptionLabel.hidden = false
                
                //                next.frame.size = self.focusCellSize
                //                next.imageView.frame.size = self.focusSize
            })
            
            collectionView.scrollEnabled = false
            let indexPath = collectionView.indexPathForCell(next)!
            collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
        }
        
        
        
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
