//
//  DividendosViewController.swift
//  BancoSantanderShareholder-tvOS
//
//  Created by Michel Barbou Salvador on 22/02/16.
//  Copyright © 2016 Grupo CMC. All rights reserved.
//

import UIKit

class DividendosViewController: UIViewController {
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var subview1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var subview2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var subview3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var subview4: UIView!

    @IBOutlet weak var headerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        subview1.layer.cornerRadius = 50
        view1.layer.borderWidth = 2.0
        view1.layer.borderColor = UIColor(red: 135.0 / 255.0, green: 135 / 255.0, blue: 135 / 255.0, alpha: 1).CGColor
        view1.backgroundColor = UIColor.clearColor()
        
        subview2.layer.cornerRadius = 50
        view2.layer.borderWidth = 2.0
        view2.layer.borderColor = UIColor(red: 135.0 / 255.0, green: 135 / 255.0, blue: 135 / 255.0, alpha: 1).CGColor
        view2.backgroundColor = UIColor.clearColor()
        
        subview3.layer.cornerRadius = 50
        view3.layer.borderWidth = 2.0
        view3.layer.borderColor = UIColor(red: 138.0 / 255.0, green: 34 / 255.0, blue: 84 / 255.0, alpha: 1).CGColor
        view3.backgroundColor = UIColor.clearColor()
        
        subview4.layer.cornerRadius = 50
        view4.layer.borderWidth = 2.0
        view4.layer.borderColor = UIColor(red: 138.0 / 255.0, green: 34 / 255.0, blue: 84 / 255.0, alpha: 1).CGColor
        view4.backgroundColor = UIColor.clearColor()
        
        headerLabel.layer.borderColor = UIColor.darkGrayColor().CGColor
        headerLabel.layer.borderWidth = 2.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
