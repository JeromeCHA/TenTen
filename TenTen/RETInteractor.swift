//
//  RETInteractor.swift
//  TenTen
//
//  Created by Jérôme Cha on 29/03/2017.
//  Copyright © 2017 Jérôme Cha. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum RETError : Error {
  case cannotReturnToAddress
  case cannotFindNextAddress
}

class RETInteractor: NSObject {

  // Pop address from stack and set PC to address
  func ret(from computerEntity:ComputerEntity) -> Observable<ComputerEntity> {
    return Observable.create { observer in
      let cancel = Disposables.create()
      
      // if we cannot set PC to previous address, there is a mistake
      guard let returnToAddress = computerEntity.shouldReturnTo else {
        observer.onError(RETError.cannotReturnToAddress)
        return cancel
      }
      
      // pop current stack
      let _ = computerEntity.removeFromStack()
      
      // set PC to address
      computerEntity.currentAddress = computerEntity.getNextAddress(returnToAddress)
      
      // then reset the value
      computerEntity.shouldReturnTo = nil
      
      // Rx
      observer.onNext(computerEntity)
      observer.onCompleted()
      
      return cancel
    }
  }
  
}
