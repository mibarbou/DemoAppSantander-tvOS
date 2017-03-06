//
//  PdfDetailViewController.swift
//  BancoSantanderShareholder-tvOS
//
//  Created by Michel Barbou Salvador on 20/02/16.
//  Copyright © 2016 Grupo CMC. All rights reserved.
//

import UIKit

class PdfDetailViewController: UIViewController {
 
    @IBOutlet weak var scrollView: FocusScrollView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image = UIImage()
    
    var currentY : CGFloat = 0   //this saves current Y position
    
    override func viewDidLayoutSubviews() {
        
        initializeGestureRecognizer()
        
    
        scrollView.contentSize = CGSize(width: 1920, height: 1080)
         
        
    }
    
    func panned(_ gesture: UIPanGestureRecognizer) {
        
        print("PANNNNNN!!")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        imageView.image = image
        
    }
    
    func swipedUp(){
        
        print("UP!")
    }
    
    func swipedDown(){
        
        print("DOWN!")
        
//        scrollView.scrollRectToVisible(CGRectMake(0, 1300, 100, 100), animated: true)
    }
    
    
    func initializeGestureRecognizer()
    {
        //For PanGesture Recoginzation
        let panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(PdfDetailViewController.recognizePanGesture(_:)))
        self.view.addGestureRecognizer(panGesture)
    }
    
    func recognizePanGesture(_ sender: UIPanGestureRecognizer)
    {
        
        let translate = sender.translation(in: self.imageView)
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
        
        sender.setTranslation(CGPoint.zero, in: self.imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    

}
