//
//  PUSHInteractor.swift
//  TenTen
//
//  Created by Jérôme Cha on 29/03/2017.
//  Copyright © 2017 Jérôme Cha. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

enum PUSHError : Error {
  case cannotFindArg
}

class PUSHInteractor: NSObject {

  // push a new stack to the current stack
  // arg will be pushed to the stack
  // default instruction is none
  func push(arg:Int?, into computerEntity:ComputerEntity) -> Observable<ComputerEntity> {
    return Observable.create { observer in
      let cancel = Disposables.create()
      
      var computer = ComputerEntity(computerEntity.stacks.count)
      if let argument = arg {
        computer = computerEntity.insert(stack: StackEntity(arg: argument, instruction: .none))
      } else {
        computer = computerEntity.insert(stack: StackEntity(instruction: .none))
      }
      
      // Rx
      observer.onNext(computer)
      observer.onCompleted()
      
      return cancel
    }
  }
}
