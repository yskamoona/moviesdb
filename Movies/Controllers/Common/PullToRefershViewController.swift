//
//  PullToRefershViewController.swift
//  MoviesList
//
//  Created by Yousra S Kamoona on 7/9/18.
//  Copyright © 2018 Yous. All rights reserved.
//

import Foundation
import UIKit

/* Subclass PullRefreshViewController when pull to refresh functionality is needed to load data.
  -- NOTE: This controller would show an error msg: "Couldn't refresh your movie list :(" on failure
  -- NOTE: set errorMessageView.isHidden = true on failure.
*/
class PullRefreshViewController: UIViewController
{
    //MARK: - UI -
    let refreshControl = UIRefreshControl()
    let errorMessageView = UIView(frame: CGRect(x: 0.0, y: UIScreen.main.bounds.origin.y, width: UIScreen.main.bounds.width, height: 50))
    let errorMessageLabel = UILabel(frame: CGRect(x: 10.0, y: 4.0, width: UIScreen.main.bounds.width, height: 15))
    
    //MARK: - ViewController Cycle -
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setupErrorMessage()
        self.setupRefreshControl()
    }
    
    //MARK: - Private Methods -
    // Use this to show an error msg if tableview data fails to refresh.
    // NOTE: set errorMessageView.isHidden = true on failure.
    fileprivate func setupErrorMessage()
    {
        self.errorMessageLabel.textColor = UIColor.white
        self.errorMessageLabel.font = self.errorMessageLabel.font.withSize(13.0)
        self.errorMessageLabel.layer.cornerRadius = 4
        self.errorMessageLabel.textAlignment = NSTextAlignment.center
        self.errorMessageLabel.text = NSLocalizedString("Couldn't refresh movie list", comment:"Couldn't refresh your movie list :(")
        
        self.errorMessageView.backgroundColor = UIColor.black
        self.errorMessageView.addSubview(self.errorMessageLabel)
        self.view.addSubview(self.errorMessageView)
        
        self.errorMessageView.isHidden = true
    }
    
    fileprivate func setupRefreshControl()
    {
        self.refreshControl.addTarget(self, action: #selector(self.refreshControlAction), for: UIControlEvents.valueChanged)
    }
    
    @objc fileprivate func refreshControlAction()
    {
        self.loadDataAfterPullRefresh()
    }
    
    //MARK: - Internal Methods -
    internal func loadDataAfterPullRefresh()
    {
        // To be overloaded by subclasses
    }
}
