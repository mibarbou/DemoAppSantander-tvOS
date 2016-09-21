//
//  StockDetailViewController.swift
//  BancoSantanderShareholder-tvOS
//
//  Created by Michel Barbou Salvador on 22/02/16.
//  Copyright © 2016 Grupo CMC. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {

    var stock = Stock()
    
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var updateTimeLabel: UILabel!
    @IBOutlet weak var stockValueLabel: UILabel!
    @IBOutlet weak var changeValueLabel: UILabel!
    @IBOutlet weak var changePercentageLabel: UILabel!
    @IBOutlet weak var valueImageView: UIImageView!
    @IBOutlet weak var percentageImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        frameView.layer.cornerRadius = 10
        
        cityLabel.text = self.stock.city
        currencyLabel.text = self.stock.currency
        updateTimeLabel.text = self.stock.updateTime
        stockValueLabel.text = self.stock.stockValue
        changeValueLabel.text = self.stock.changeValue
        changePercentageLabel.text = self.stock.changePercentage
        (valueImageView.image, percentageImageView.image) = setArrowsValues(self.stock.changeValue, percentage: self.stock.changePercentage)

   
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    

 

}
