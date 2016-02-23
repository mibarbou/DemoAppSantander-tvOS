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
    
    var stocks = [Stock]()
    
    let defaultSize = CGSizeMake(700, 650)
    
    let focusSize = CGSizeMake(840, 780)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDummyData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "goToStockDetailSegue" {
            
            if let stockDetailVC = segue.destinationViewController as? StockDetailViewController {
                
                if let theStock = sender {
                    
                    stockDetailVC.stock = (theStock as? Stock)!
                }
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return stocks.count;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(700, 650)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("StockCell", forIndexPath: indexPath) as? StockCell {
            
            cell.layer.cornerRadius = 10
            cell.shareNameLabel.text = "Acción SAN"
            
            let stock = stocks[indexPath.row] as Stock
            
            cell.cityLabel?.text = stock.city
            cell.currencyNameLabel.text = stock.currency
            cell.updateTimeLabel.text = stock.updateTime
            cell.changeValueLabel.text = stock.changeValue
            cell.stockValueLabel.text = "283"
            cell.changePercentageLabel.text = stock.changePercentage + "%"
            (cell.changeImageView.image, cell.percentageImageView.image) = setArrowsValues(stock.changeValue, percentage: stock.changePercentage)
            
            
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
    
        
        if stocks.count > 0  {
            
            let itemTapped = gesture.view as? StockCell
            
            if let theItem = itemTapped {
                
                let indexPath = self.collectionView.indexPathForCell(theItem)
                
                if let theIndex = indexPath {
                    
                    print("celda pulsada: \(theIndex.row)")
                    
                    self.performSegueWithIdentifier("goToStockDetailSegue", sender:stocks[theIndex.row])
                }
                
            }
            
        }
        
    }
    
    
    func createDummyData(){
        
        let londres = Stock(city: "LONDRES", currency: "Pence Sterling", updateTime: "11:44h", changeValue: "11,33", changePercentage: "4,17", stockValue: "283")
        stocks.append(londres)
        
        let buenosAires = Stock(city: "BUENOS AIRES", currency: "Argentine Peso", updateTime: "22:00h", changeValue: "-2,00", changePercentage: "-3,23", stockValue: "60,00")
        stocks.append(buenosAires)
        
        let lisboa = Stock(city: "LISBOA", currency: "Euro", updateTime: "10:17h", changeValue: "0,11", changePercentage: "3,14", stockValue: "3,61")
        stocks.append(lisboa)
        
        let madrid = Stock(city: "MADRID", currency: "Euro", updateTime: "10:29h", changeValue: "0,12", changePercentage: "3,40", stockValue: "6,618")
        stocks.append(madrid)
        
        let mexico = Stock(city: "MEXICO", currency: "Mexican Peso", updateTime: "21:00h", changeValue: "-0,95", changePercentage: "-1,30", stockValue: "72,00")
        stocks.append(mexico)
        
        let milan = Stock(city: "MILAN", currency: "Euro", updateTime: "17:30h", changeValue: "0,32", changePercentage: "8,96", stockValue: "3,89")
        stocks.append(milan)
        
        let nuevaYork = Stock(city: "NUEVA YORK", currency: "US Dollar", updateTime: "23:17h", changeValue: "0,09", changePercentage: "-2,28", stockValue: "3,86")
        stocks.append(nuevaYork)
        
        let varsovia = Stock(city: "VARSOVIA", currency: "Zloty", updateTime: "09:04h", changeValue: "0,37", changePercentage: "2,25", stockValue: "16,81")
        stocks.append(varsovia)
        
        self.collectionView.reloadData()
        
    }
    

   

}
