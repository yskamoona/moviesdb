//
//  MoviesList.swift
//  Movies
//
//  Created by Yousra S Kamoona on 7/9/18.
//  Copyright © 2018 Yous. All rights reserved.
//

import Foundation

class MoviesList: NSObject, NSCoding, ParsableProtocol
{
    fileprivate(set) open var movies: Array<Movie>  = Array<Movie>()
  
    // Initializer. Also: See ParsableProtocol
    public required init(dictionary: Dictionary<String, AnyObject>)
    {
        super.init()
        
        if let moviesArr = dictionary["movies"]
        {
            var error:NSError? = nil
            let parser: MovieParser = MovieParser()
            let parsedMovesList:[Movie] = parser.parseList(moviesArr, error:&error)
            self.movies = parsedMovesList
        }
    }
    
    //MARK: - NSCodingProtocol -
    public required init?(coder:NSCoder)
    {
        if let moviesArr = coder.decodeObject(forKey: "movies") as? Array<Movie>
        { self.movies = moviesArr as [Movie] }
    
        super.init()
    }
    
    open func encode(with encoder:NSCoder)
    {
        encoder.encode(self.movies, forKey: "movies")
    }
}

