//
//  ImageExtension.swift
//  Movies
//
//  Created by Yousra S Kamoona on 7/9/18.
//  Copyright © 2018 Yous. All rights reserved.
//

import Foundation
import UIKit

// Or could use AlamofireImage, but the implementation isn't complex or messy to do it in house.
extension UIImageView
{
    func loadImageWithUrl(urlString: String)
    {
        // download image from url
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!, completionHandler:
            {
                (data, response, error) -> Void in
                
                if (error != nil)
                { return }
               
                if let image = UIImage(data: data!)
                {
                    DispatchQueue.main.async(execute:
                        {
                            () -> Void in
                            self.image = image
                    })
                }
                else
                { return }

        }).resume()
    }
}
