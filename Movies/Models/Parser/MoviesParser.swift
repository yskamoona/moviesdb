//
//  MovieParser.swift
//  Movies
//
//  Created by Yousra S Kamoona on 7/9/18.
//  Copyright © 2018 Yous. All rights reserved.
//

import Foundation

// Any object that needs to use Movie Parser should confirm to ParsableProtocol
protocol ParsableProtocol
{
   init(dictionary: Dictionary<String, AnyObject>)
}

// Using Generics to create a generic parser, can be used with any object that confirms to ParsableProtocol
open class MovieParser: NSObject
{
    // Parsing a single object
    func parse<T: ParsableProtocol>(_ data: AnyObject, error: NSErrorPointer) -> T?
    {
        var object: T? = nil
        
        // if data is formatted correctly, create the object
        if let goodData = data as? Dictionary<String, AnyObject>
        {
            object = T(dictionary: goodData)
        }
        else // if data is not in the expected format, format the error object
        {
            error?.pointee = NSError.StandardParseError
        }
        
        return object
    }
    
    // Parsing a list of the object
    func parseList<T: ParsableProtocol>(_ data: AnyObject, error: NSErrorPointer) -> Array<T>
    {
        var objects: Array<T> = Array<T>()
        
        if let objectList: Array<AnyObject> = data as? Array<AnyObject>
        {
            for objectData in objectList
            {
                var object: T? = nil
                
                // if data is formatted correctly, create the object
                if let goodData = objectData as? Dictionary<String, AnyObject>
                {
                    object = T(dictionary: goodData)
                }
                else  // if data is not in the expected format, format the error object
                {
                    error?.pointee = NSError.StandardParseError
                }
                
                if error?.pointee != nil
                { break }
                else if let parsedObject = object
                {
                    objects += [parsedObject]
                }
            }
        }
        else
        {
            error?.pointee = NSError.StandardParseError
        }
        
        return objects
    }
}
