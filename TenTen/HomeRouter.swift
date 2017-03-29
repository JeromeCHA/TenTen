//
//  HomeRouter.swift
//  TenTen
//
//  Created by Jérôme Cha on 29/03/2017.
//  Copyright © 2017 Jérôme Cha. All rights reserved.
//

import UIKit

class HomeRouter: NSObject {

  var homeViewController : HomeViewController?
  
  func getInitViewController() -> HomeViewController? {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    self.homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
    self.initViper()
    return self.homeViewController
  }
  
  fileprivate func initViper() {
    let presenter = HomePresenter()
    
    presenter.router = self
    presenter.viewDelegate = self.homeViewController
    
    self.homeViewController?.presenter = presenter
  }
  
}
