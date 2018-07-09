//
//  NSErrorExtension.swift
//  Movies
//
//  Created by Yousra S Kamoona on 7/9/18.
//  Copyright © 2018 Yous. All rights reserved.
//

import Foundation

extension NSError
{
    //MARK:- Singleton setup -
    class var StandardParseError : NSError
    {
        // create the instance
        struct Singleton
        {
            static let parseError = NSError(domain: "Could not parse the given data", code: 0, userInfo: nil)
        }
        
        // return the singleton instance
        return Singleton.parseError
    }
}
