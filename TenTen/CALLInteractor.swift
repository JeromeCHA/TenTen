
//
//  CALLInteractor.swift
//  TenTen
//
//  Created by Jérôme Cha on 29/03/2017.
//  Copyright © 2017 Jérôme Cha. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

enum CALLError : Error {
  case cannotFindArg
}

class CALLInteractor: NSObject {

  // Set the program counter (PC) to `addr`
  func call(index:Int?, from computerEntity:ComputerEntity) -> Observable<ComputerEntity> {
    return Observable.create { observer in
      let cancel = Disposables.create()
      
      // save the address where the PC have to return after
      computerEntity.shouldReturnTo = computerEntity.currentAddress
      
      // check if there is a new address to go to
      guard let newAddress = index else {
        observer.onError(CALLError.cannotFindArg)
        return cancel
      }
      
      // set where it was called
      computerEntity.stacks[newAddress]?.calledFromAddress = computerEntity.currentAddress
      
      // change the current address
      computerEntity.currentAddress = newAddress
      
      observer.onNext(computerEntity)
      observer.onCompleted()
      
      return cancel
    }
  }
  
}
