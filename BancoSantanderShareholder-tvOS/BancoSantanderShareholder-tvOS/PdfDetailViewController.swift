//
//  PdfDetailViewController.swift
//  BancoSantanderShareholder-tvOS
//
//  Created by Michel Barbou Salvador on 20/02/16.
//  Copyright © 2016 Grupo CMC. All rights reserved.
//

import UIKit

class PdfDetailViewController: UIViewController {
  
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    var image = UIImage()
    
    var currentY : CGFloat = 0   //this saves current Y position
    
    override func viewDidLayoutSubviews() {
        
        initializeGestureRecognizer()
        
//        let pan = UIPanGestureRecognizer(target: self, action: "panned:" )
//        
//        scrollView.panGestureRecognizer.allowedTouchTypes = [UITouchType.Indirect.rawValue]
//        scrollView.addGestureRecognizer(pan)
//
//        
//        scrollView.contentSize = CGSizeMake(1920, 1500)
        
    }
    
    func panned(gesture: UIPanGestureRecognizer) {
        
        print("PANNNNNN!!")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        imageView.image = image
        
    }
    
    func initializeGestureRecognizer()
    {
        //For PanGesture Recoginzation
        let panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("recognizePanGesture:"))
        self.scrollView.addGestureRecognizer(panGesture)
    }
    
    func recognizePanGesture(sender: UIPanGestureRecognizer)
    {
        
        let translate = sender.translationInView(self.view)
        var newY = sender.view!.center.y + translate.y
        
        if(newY >= self.view.frame.height - 20) {
            newY = sender.view!.center.y    //make it not scrolling downwards at the very beginning
        }
        else if( newY <= 0){
            newY = currentY                 //make it scrolling not too much upwards
        }
        
        sender.view!.center = CGPoint(x:sender.view!.center.x,
            y:newY)
        currentY = newY
        
        print(newY)
        
        sender.setTranslation(CGPointZero, inView: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    

}
