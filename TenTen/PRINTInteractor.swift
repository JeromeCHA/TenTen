//
//  PRINTInteractor.swift
//  TenTen
//
//  Created by Jérôme Cha on 29/03/2017.
//  Copyright © 2017 Jérôme Cha. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class PRINTInteractor: NSObject {

  // this interactpr just pop the current stack
  func print(from computerEntity:ComputerEntity) -> Observable<ComputerEntity> {
    return Observable.create { observer in
      let cancel = Disposables.create()

      // pop the current stack
      computerEntity.currentAddress = computerEntity.removeFromStack()
      
      // Rx
      observer.onNext(computerEntity)
      observer.onCompleted()
      
      return cancel
    }
  }
  
}
