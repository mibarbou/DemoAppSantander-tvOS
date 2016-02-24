//
//  AccionViewController.swift
//  BancoSantanderShareholder-tvOS
//
//  Created by Michel Barbou Salvador on 19/02/16.
//  Copyright © 2016 Grupo CMC. All rights reserved.
//

import UIKit

class AccionViewController: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    @IBOutlet weak var headerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        headerLabel.layer.borderColor = UIColor.darkGrayColor().CGColor
        headerLabel.layer.borderWidth = 2.0
        
        view1.layer.borderColor = UIColor.darkGrayColor().CGColor
        view1.layer.borderWidth = 2.0
        
        view2.layer.borderColor = UIColor.darkGrayColor().CGColor
        view2.layer.borderWidth = 2.0
        
        view3.layer.borderColor = UIColor.darkGrayColor().CGColor
        view3.layer.borderWidth = 2.0
        
        view4.layer.borderColor = UIColor.darkGrayColor().CGColor
        view4.layer.borderWidth = 2.0
        
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
