//
//  HomeViewController.swift
//  TenTen
//
//  Created by Jérôme Cha on 29/03/2017.
//  Copyright © 2017 Jérôme Cha. All rights reserved.
//

import UIKit

protocol HomeViewDelegate {
  
}

class HomeViewController: UIViewController, HomeViewDelegate {

  var presenter : HomePresenter?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

