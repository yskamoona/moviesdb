//
//  MovieClient.swift
//  Movies
//
//  Created by Yousra S Kamoona on 7/9/18.
//  Copyright © 2018 Yous. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MovieClient
{
    fileprivate let baseURL = "https://api.themoviedb.org"
    fileprivate let moviesistEndpoint = "/3/movie/now_playing"
    fileprivate let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    
    //MARK: - MovieClient Singlton -
    static let sharedInstance = MovieClient()
    
    // request to get a dict with
    open func fetchMovieList(successCallback: @escaping ([Movie])->(), error: ((Error?)->())?)
    {
        let stringURL = self.baseURL + self.moviesistEndpoint
        var params = Parameters()
        params["api_key"] = self.apiKey
        
        Alamofire.request(stringURL,
                          method: .get,
                          parameters: params,
                          encoding: URLEncoding.default,
                          headers: nil).validate().responseJSON(completionHandler:
                            { response in
                                switch response.result
                                {
                                case .success(let value):
                                    let resultJSON = JSON(value).dictionaryObject!["results"]

                                    var localError: NSError? = nil
                                    let parser: MovieParser = MovieParser()
                                    let movieList: [Movie] = parser.parseList(resultJSON as AnyObject, error: &localError)
                                    
                                    if (localError != nil)
                                    { error!(localError!) }
                                    else
                                    { successCallback(movieList)}

                                case .failure(let errorResponse):
                                    if let errorCallback = error
                                    { errorCallback(errorResponse) }
                                }
                          })
    }
}
