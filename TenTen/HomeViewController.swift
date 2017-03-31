//
//  HomeViewController.swift
//  TenTen
//
//  Created by Jérôme Cha on 29/03/2017.
//  Copyright © 2017 Jérôme Cha. All rights reserved.
//

import UIKit

protocol HomeViewDelegate {
  func print(_ value:Int)
}

class HomeViewController: UIViewController, HomeViewDelegate {

  @IBOutlet weak var displayTextView: UITextView!
  var presenter : HomePresenter?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.presenter?.createStack()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  //MARK: - HomeViewDelegate
  func print(_ value:Int) {
    if self.displayTextView.text == "" {
      self.displayTextView.text = "\(value)"
    } else {
      self.displayTextView.text = "\(self.displayTextView.text!)\n\(value)"
    }
  }
}

