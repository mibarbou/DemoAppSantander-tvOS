//
//  FocusScrollView.swift
//  BancoSantanderShareholder-tvOS
//
//  Created by Michel Barbou Salvador on 23/02/16.
//  Copyright © 2016 Grupo CMC. All rights reserved.
//

import UIKit

class FocusScrollView: UIScrollView {

    override func canBecomeFocused() -> Bool {
        return true
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        if context.previouslyFocusedView === self {
            
           
        }
    }

}
