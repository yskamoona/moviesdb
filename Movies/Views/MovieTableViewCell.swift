//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Yousra S Kamoona on 7/9/18.
//  Copyright © 2018 Yous. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class MovieTableViewCell: UITableViewCell
{
    @IBOutlet weak var movieTitleLabel: UILabel?
    @IBOutlet weak var movieOverviewLabel: UILabel?
    @IBOutlet weak var movieImageView: UIImageView?
    
    class func cellIdentifier() -> String
    { return String(describing: self) }
 
    class func registerCell(_ tableView: UITableView)
    {
        let nibName = self.cellIdentifier()
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: self.cellIdentifier())
    }
    
    func tableView(_ tableView: UITableView, setupCellWithAny any: Any? = nil, indexPath: IndexPath)
    {
        self.backgroundColor = UIColor.black
        
        if let movie = any as? Movie
        {
            self.movieTitleLabel?.text = movie.title
            self.movieOverviewLabel?.text = movie.overview
            
            if let imageURLString = movie.imageURL?.absoluteString
            { self.movieImageView?.loadImageWithUrl(urlString: imageURLString) }
        }
    }
}
