//
//  FontExtension.swift
//  Movies
//
//  Created by Yousra S Kamoona on 7/9/18.
//  Copyright © 2018 Yous. All rights reserved.
//

import Foundation
import UIKit

extension UIFont
{
    // Use in main cell labels
    public class func titleMedium() -> UIFont
    {
        let titleMedium: UIFont =
        {
            let f = UIFont.systemFont(ofSize: 15)
            return f
        }()
        return titleMedium
    }
    
    public class func titleBoldMedium() -> UIFont
    {
        let titleBoldMedium: UIFont =
        {
            let f = UIFont.boldSystemFont(ofSize: 15)
            return f
        }()
        return titleBoldMedium
    }
    
    // Use in cell title labels
    public class func titleSmall() -> UIFont
    {
        let titleSmall: UIFont =
        {
            let f = UIFont.systemFont(ofSize: 12)
            return f
        }()
        return titleSmall
    }
    
    // Use in cell detail lables
    public class func detail() -> UIFont
    {
        let detail: UIFont =
        {
            let f = UIFont.systemFont(ofSize: 15)
            return f
        }()
        return detail
    }
}
