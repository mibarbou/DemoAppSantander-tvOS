//
//  ThirdViewController.swift
//  BancoSantanderShareholder-tvOS
//
//  Created by Michel Barbou Salvador on 13/02/16.
//  Copyright © 2016 Grupo CMC. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    
    weak var currentViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        switch indexPath.row {
            
        case 0:
           cell.textLabel?.text = "LA ACCIÓN"
        case 1:
            cell.textLabel?.text = "ACCIONARADO"
        case 2:
            cell.textLabel?.text = "DIVIDENDOS"
        case 3:
            cell.textLabel?.text = "RESULTADOS"
        default:
            break
           
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didUpdateFocusInContext context: UITableViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        //this gives you the indexpath of the focused cell
        if let nextIndexPath = context.nextFocusedIndexPath {
            
            print(nextIndexPath.row)
            
            changeContainer(nextIndexPath.row)
        }
    }
    
    
    func changeContainer(index: Int) {
        
        let viewController : UIViewController?
        
        switch index {
            
        case 0:
            viewController = self.storyboard?.instantiateViewControllerWithIdentifier("ControllerAccion")
            setChildControllerInContainer(viewController)
        case 1:
            viewController = self.storyboard?.instantiateViewControllerWithIdentifier("ControllerAccionarado")
            setChildControllerInContainer(viewController)
        case 2:
            viewController = self.storyboard?.instantiateViewControllerWithIdentifier("ControllerDividendos")
            setChildControllerInContainer(viewController)
        case 3:
            viewController = self.storyboard?.instantiateViewControllerWithIdentifier("ControllerResultados")
            setChildControllerInContainer(viewController)
        default:
            break
            
        }
        
    
        
    }
    
    func setChildControllerInContainer(viewController:UIViewController?){
        
        if self.childViewControllers.count > 0 {
            
            let oldController = self.childViewControllers.last
            
            if let theOldController = oldController {
                
                theOldController.willMoveToParentViewController(nil)
                theOldController.view.removeFromSuperview()
            }
        }
        
        if let theViewController = viewController {
            
            self.addChildViewController(theViewController)
            self.containerView.addSubview(theViewController.view)
            theViewController.didMoveToParentViewController(self)
            
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
