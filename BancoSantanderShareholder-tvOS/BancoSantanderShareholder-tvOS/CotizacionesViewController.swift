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
        
        return CGSizeMake(540, 600)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("StockCell", forIndexPath: indexPath) as? StockCell {
            
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
