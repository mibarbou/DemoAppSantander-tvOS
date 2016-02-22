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
            cell.shareNameLabel.text = "Acción SAN"
            
            switch indexPath.row {
                
            case 0:
                cell.cityLabel?.text = "LONDRES"
                cell.currencyNameLabel.text = "Pence Sterling"
                cell.updateTimeLabel.text = "11:44h"
                let changeValue = "11,33"
                cell.changeValueLabel.text = changeValue
                cell.stockValueLabel.text = "283"
                
                let percentage = "4,17"
                cell.changePercentageLabel.text = percentage + "%"
                (cell.changeImageView.image, cell.percentageImageView.image) = setArrowsValues(changeValue, percentage: percentage)
                
            case 1:
                cell.cityLabel?.text = "BUENOS AIRES"
                cell.currencyNameLabel.text = "Argentine Peso"
                cell.updateTimeLabel.text = "22:00h"
                let changeValue = "-2,00"
                cell.changeValueLabel.text = changeValue
                cell.stockValueLabel.text = "60,00"
                
                let percentage = "-3,23"
                cell.changePercentageLabel.text = percentage + "%"
                
                (cell.changeImageView.image, cell.percentageImageView.image) = setArrowsValues(changeValue, percentage: percentage)
                
            case 2:
                cell.cityLabel?.text = "LISBOA"
                cell.currencyNameLabel.text = "Euro"
                cell.updateTimeLabel.text = "10:17h"
                let changeValue = "0,11"
                cell.changeValueLabel.text = changeValue
                cell.stockValueLabel.text = "3,61"
                
                let percentage = "3.14"
                cell.changePercentageLabel.text = percentage + "%"
                
                (cell.changeImageView.image, cell.percentageImageView.image) = setArrowsValues(changeValue, percentage: percentage)
            case 3:
                cell.cityLabel?.text = "MADRID"
                cell.currencyNameLabel.text = "Euro"
                cell.updateTimeLabel.text = "10:29h"
                let changeValue = "0,12"
                cell.changeValueLabel.text = changeValue
                cell.stockValueLabel.text = "6,618"
                
                let percentage = "3,40"
                cell.changePercentageLabel.text = percentage + "%"
                
                (cell.changeImageView.image, cell.percentageImageView.image) = setArrowsValues(changeValue, percentage: percentage)
            case 4:
                cell.cityLabel?.text = "MEXICO"
                cell.currencyNameLabel.text = "Mexican Peso"
                cell.updateTimeLabel.text = "21:00h"
                let changeValue = "-0,95"
                cell.changeValueLabel.text = changeValue
                cell.stockValueLabel.text = "72,00"
                
                let percentage = "-1,30"
                cell.changePercentageLabel.text = percentage + "%"
                
                (cell.changeImageView.image, cell.percentageImageView.image) = setArrowsValues(changeValue, percentage: percentage)
            case 5:
                cell.cityLabel?.text = "MILAN"
                cell.currencyNameLabel.text = "Euro"
                cell.updateTimeLabel.text = "17:30h"
                let changeValue = "0,32"
                cell.changeValueLabel.text = changeValue
                cell.stockValueLabel.text = "3,89"
                
                let percentage = "8,96"
                cell.changePercentageLabel.text = percentage + "%"
                
                (cell.changeImageView.image, cell.percentageImageView.image) = setArrowsValues(changeValue, percentage: percentage)
            case 6:
                cell.cityLabel?.text = "NUEVA YORK"
                cell.currencyNameLabel.text = "US Dollar"
                cell.updateTimeLabel.text = "23:17h"
                let changeValue = "-0,09"
                cell.changeValueLabel.text = changeValue
                cell.stockValueLabel.text = "3,86"
                
                let percentage = "-2,28"
                cell.changePercentageLabel.text = percentage + "%"
                
                (cell.changeImageView.image, cell.percentageImageView.image) = setArrowsValues(changeValue, percentage: percentage)
            case 7:
                cell.cityLabel?.text = "VARSOVIA"
                cell.currencyNameLabel.text = "Zloty"
                cell.updateTimeLabel.text = "09:04h"
                let changeValue = "0,37"
                cell.changeValueLabel.text = changeValue
                cell.stockValueLabel.text = "16,81"
                
                let percentage = "2,25"
                cell.changePercentageLabel.text = percentage + "%"
                
                (cell.changeImageView.image, cell.percentageImageView.image) = setArrowsValues(changeValue, percentage: percentage)
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
    
    func setArrowsValues(value: String, percentage: String) -> (UIImage?,UIImage?) {
        
        var valueImage = UIImage()
        var percentageImage = UIImage()
        
        if (value.containsString("-")) {
            
            valueImage = UIImage(named: "arrowDownIcon")!
            
        } else {
            
            valueImage = UIImage(named: "arrowUpIcon")!
            
        }
        
        if (percentage.containsString("-")) {
            
            percentageImage = UIImage(named: "arrowDownIcon")!
            
        } else {
            
            percentageImage = UIImage(named: "arrowUpIcon")!
            
        }
        
        return (valueImage, percentageImage)
    }
    
    // MARK: UICollectionViewDelegate
 
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        
        if let prev = context.previouslyFocusedView as? StockCell {
            
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                prev.center = CGPointMake(prev.center.x,prev.center.y + 100)
            
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
                
                next.center = CGPointMake(next.center.x,next.center.y - 100)
                
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
    
    func tapped(gesture: UITapGestureRecognizer) {
        
        self.performSegueWithIdentifier("goToStockDetailSegue", sender: nil)
        
//        if pdfArray.count > 0  {
//            
//            let itemTapped = gesture.view as? DocumentCell
//            
//            if let theItem = itemTapped {
//                
//                let indexPath = self.collectionView.indexPathForCell(theItem)
//                
//                if let theIndex = indexPath {
//                    
//                    print("celda pulsada: \(theIndex.row)")
//                    
//                    self.performSegueWithIdentifier("goToPdfSegue", sender:pdfArray[theIndex.row])
//                }
//                
//            }
//            
//        }
        
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
