//
//  MULTInteractor.swift
//  TenTen
//
//  Created by Jérôme Cha on 29/03/2017.
//  Copyright © 2017 Jérôme Cha. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum MULTError : Error {
  case cannotPop2Arguments
}

class MULTInteractor: NSObject {

  func mult(from computerEntity:ComputerEntity) -> Observable<ComputerEntity> {
    return Observable.create { observer in
      let cancel = Disposables.create()
      
      // check from where we should pop
      var fromAddress = computerEntity.currentAddress
      
      // if the stack was called from a specific address, then go to it and take it
      if let calledFrom = computerEntity.stacks[computerEntity.currentAddress]?.calledFromAddress {
        fromAddress = calledFrom
      }
      
      let previousIndex1 = computerEntity.getPreviousAddress(fromAddress)
      
      // take the previous stack before the previousIndex1
      let previousIndex2 = computerEntity.getPreviousAddress(previousIndex1)
      
      // if both don't have arg to multiply -> Error
      guard previousIndex1 != previousIndex2, let args1 = computerEntity.stacks[previousIndex1]?.arg, let args2 = computerEntity.stacks[previousIndex2]?.arg else {
        // if we cannot pop 2 arguments, then we throw an error
        observer.onError(MULTError.cannotPop2Arguments)
        return cancel
      }
      
      // create a stack to put in
      var newStack = StackEntity()
      newStack.arg = args1 * args2
      newStack.address = computerEntity.currentAddress
      
      // push the new stack
      computerEntity.stacks[computerEntity.currentAddress] = newStack
      
      // update the current address
      computerEntity.currentAddress = computerEntity.getNextAddress()
      
      // Rx
      observer.onNext(computerEntity)
      observer.onCompleted()
      
      return cancel
    }
  }
  
}
