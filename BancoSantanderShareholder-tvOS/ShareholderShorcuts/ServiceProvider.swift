//
//  ServiceProvider.swift
//  ShareholderShorcuts
//
//  Created by Michel Barbou Salvador on 24/02/16.
//  Copyright © 2016 Grupo CMC. All rights reserved.
//

import Foundation
import TVServices

class ServiceProvider: NSObject, TVTopShelfProvider {

    override init() {
        super.init()
    }

    // MARK: - TVTopShelfProvider protocol

    var topShelfStyle: TVTopShelfContentStyle {
        // Return desired Top Shelf style.
        return .sectioned
    }

    var topShelfItems: [TVContentItem] {
        // Create an array of TVContentItems.
        
        //        let item1 = TVContentItem(contentIdentifier: TVContentIdentifier(identifier: "myapp.item1", container: nil)!)
        //        let item2 = TVContentItem(contentIdentifier: TVContentIdentifier(identifier: "myapp.item2", container: nil)!)
        //        let item3 = TVContentItem(contentIdentifier: TVContentIdentifier(identifier: "myapp.item3", container: nil)!)
        //
        //        return [item1!,item2!,item3!]
        
        // Create an array of TVContentItems.
        let wrapperID = TVContentIdentifier(identifier: "shelf-wrapper", container: nil)!
        let wrapperItem = TVContentItem(contentIdentifier: wrapperID)!
        var ContentItems = [TVContentItem]()
        
        for i in 0 ..< 4
        {
            let identifier = TVContentIdentifier(identifier: "VOD", container: wrapperID)!
            let contentItem = TVContentItem(contentIdentifier: identifier )!
            
            switch i {
            case 0:
                contentItem.imageURL = Bundle.main.url(forResource: "videos", withExtension: "png")
                contentItem.imageShape = .HDTV
                contentItem.title = "Vídeos"
                contentItem.displayURL = URL(string: "SantanderShareholder://section/\(i)");
                contentItem.playURL = URL(string: "VideoApp://video/\(i)");
            case 1:
                contentItem.imageURL = Bundle.main.url(forResource: "documentos", withExtension: "png")
                contentItem.imageShape = .HDTV
                contentItem.title = "Documentos"
                contentItem.displayURL = URL(string: "SantanderShareholder://section/\(i)");
                contentItem.playURL = URL(string: "VideoApp://video/\(i)");
            case 2:
                contentItem.imageURL = Bundle.main.url(forResource: "TopShelf", withExtension: "png")
                contentItem.imageShape = .HDTV
                contentItem.title = "Accionistas"
                contentItem.displayURL = URL(string: "SantanderShareholder://section/\(i)");
                contentItem.playURL = URL(string: "VideoApp://video/\(i)");
            case 3:
                contentItem.imageURL = Bundle.main.url(forResource: "cotizaciones", withExtension: "png")
                contentItem.imageShape = .HDTV
                contentItem.title = "Cotizaciones"
                contentItem.displayURL = URL(string: "SantanderShareholder://section/\(i)");
                contentItem.playURL = URL(string: "VideoApp://video/\(i)");
            default:
                break
                
            }
            
            
            //            if let url = NSURL(string: "http://www.brianjcoleman.com/code/images/feature-\(i).jpg")
            //            {
            //                contentItem.imageURL = url
            //                contentItem.imageShape = .HDTV
            //                contentItem.title = "Movie Title"
            //                contentItem.displayURL = NSURL(string: "SantanderShareholder://section/\(i)");
            //                contentItem.playURL = NSURL(string: "VideoApp://video/\(i)");
            //            }
            ContentItems.append(contentItem)
        }
        
        // Section Details
        wrapperItem.title = "Santander Accionistas"
        wrapperItem.topShelfItems = ContentItems
        
        return [wrapperItem]
    }


}

