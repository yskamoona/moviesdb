//
//  MoviesTableViewController.swift
//  Movies
//
//  Created by Yousra S Kamoona on 7/9/18.
//  Copyright © 2018 Yous. All rights reserved.
//

import UIKit

class MoviesTableViewController: PullRefreshViewController
{
    //MARK: - IBOutlets -
    @IBOutlet weak var tableView: UITableView?
    
    //MARK: - Private Properties -
    fileprivate var movies: Array<Movie> = Array<Movie>()
    
    //MARK: - ViewController Cycle -
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setupTableView()
        
        if let movies = self.loadMovies()
        {
            self.movies = movies
            self.tableView?.reloadData()
        }
        else
        { self.loadData() }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.setupViews()
    }
    
    //MARK: - TableView Setup -
    fileprivate func setupTableView()
    {
        // Set delegate and data source
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        // Set tableView height
        self.tableView?.estimatedRowHeight = 100
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        
        // Set refresh controll for the tableview
        self.tableView?.refreshControl = self.refreshControl

        // Register cell
        if let tableview = self.tableView
        { MovieTableViewCell.registerCell(tableview) }
    }
    
    //MARK: - Views Setup -
    fileprivate func setupViews()
    {
        // Navigation Bar setup
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    //MARK: - Data loading -
    fileprivate func loadData()
    {
        self.refreshControl.beginRefreshing()
        MovieClient.sharedInstance.fetchMovieList(successCallback: self.onMoviesListReceived, error: self.onErrorHandler)
    }
    
    fileprivate lazy var onMoviesListReceived: ([Movie])->() =
    { result in
        
        if self.refreshControl.isRefreshing
        {
            self.movies = []
            self.errorMessageView.isHidden = true
            self.refreshControl.endRefreshing()
        }
        
        self.movies = result
        
        // Persist movie list
        self.saveMovies()
        
        self.tableView?.reloadData()
    }
    
    fileprivate lazy var onErrorHandler:
        ((Error?)->())? =
        { error in
            
            self.errorMessageView.isHidden = false
            self.refreshControl.endRefreshing()
    }
    
    //MARK: - Overloaded Methods -
    override func loadDataAfterPullRefresh()
    {
        self.refreshControl.beginRefreshing()
        MovieClient.sharedInstance.fetchMovieList(successCallback: self.onMoviesListReceived, error: self.onErrorHandler)
    }
    
    //MARK: - Data Persistence Methods -
    // Save data to disk
    fileprivate func saveMovies()
    {
        do {
            let data = try PropertyListEncoder().encode(self.movies)
            let success = NSKeyedArchiver.archiveRootObject(data, toFile: Movie.ArchiveURL.path)
            print(success ? "Successful save" : "Save Failed")
        } catch {
            print("Save Failed")
        }
    }
    
    // Load data from disk
    fileprivate func loadMovies() -> [Movie]?
    {
        guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: Movie.ArchiveURL.path) as? Data else
        { return nil }
       
        do {
            let movies = try PropertyListDecoder().decode([Movie].self, from: data)
            return movies
        } catch {
            print("Retrieve Failed")
            return nil
        }
    }
}

//MARK: - UITableViewDelegate -
//MARK: - UITableViewDataSource -
extension MoviesTableViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    { return self.movies.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = MovieTableViewCell()
        if let movieCell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.cellIdentifier(), for: indexPath) as? MovieTableViewCell
        {
            movieCell.tableView(tableView, setupCellWithAny: self.movies[indexPath.row], indexPath: indexPath)
            cell = movieCell
        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
//    {
//        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
//        if let movieListDetailViewController = mainStoryboard.instantiateViewController(withIdentifier:"MovieDetailTableViewController") as? MovieDetailTableViewController
//        {
//            //movieListDetailViewController.profile = self.movies[indexPath.row].profile
//            self.navigationController?.pushViewController(movieListDetailViewController, animated: true)
//        }
//
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
}


