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
    
    let multInteractor = MULTInteractor()
    let callInteractor = CALLInteractor()
    let retInteractor = RETInteractor()
    let printInteractor = PRINTInteractor()
    let stopInteractor = STOPInteractor()
    let pushInteractor = PUSHInteractor()
    
    presenter.router = self
    presenter.viewDelegate = self.homeViewController
    
    presenter.multInteractor = multInteractor
    presenter.callInteractor = callInteractor
    presenter.retInteractor = retInteractor
    presenter.printInteractor = printInteractor
    presenter.stopInteractor = stopInteractor
    presenter.pushInteractor = pushInteractor
    
    
    self.homeViewController?.presenter = presenter
  }
  
}
