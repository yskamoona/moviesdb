//
//  Movie.swift
//  Movies
//
//  Created by Yousra S Kamoona on 7/9/18.
//  Copyright © 2018 Yous. All rights reserved.
//

import Foundation

struct Movie: Codable, ParsableProtocol
{
    fileprivate(set) var title: String? = nil
    fileprivate(set) var overview: String? = nil
    fileprivate(set) var imageURL: URL? = nil
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("movies")
    
    // Initializer. Also: See ParsableProtocol
    init(dictionary: Dictionary<String, AnyObject>)
    {
        if let titleString = dictionary["title"] as? String
        { self.title = titleString }
        
        if let overviewString = dictionary["overview"] as? String
        { self.overview = overviewString }
        
        if let imageURLString = dictionary["poster_path"] as? String
        {
            let imagePath = "https://image.tmdb.org/t/p/w500\(imageURLString)"
            self.imageURL = URL(string: imagePath)
        }
    }
}
