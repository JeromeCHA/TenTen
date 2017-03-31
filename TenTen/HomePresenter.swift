//
//  HomePresenter.swift
//  TenTen
//
//  Created by Jérôme Cha on 29/03/2017.
//  Copyright © 2017 Jérôme Cha. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class HomePresenter: NSObject {
  
  var viewDelegate : HomeViewDelegate?
  var router : HomeRouter?
  
  var callInteractor : CALLInteractor?
  var retInteractor : RETInteractor?
  var printInteractor : PRINTInteractor?
  var stopInteractor : STOPInteractor?
  var pushInteractor : PUSHInteractor?
  var multInteractor : MULTInteractor?
  
  private let disposeBag = DisposeBag()
  
  private let PRINT_TENTEN_BEGIN = 50
  private let MAIN_BEGIN = 0
  
  // Create new computer with a stack of 100 addresses
  var computer = ComputerEntity(100)
  
  func createStack() {
    // Instructions for the print_tenten function
    computer.currentAddress = PRINT_TENTEN_BEGIN
    computer = computer.insert(stack: StackEntity(instruction: .mult))
      .insert(stack: StackEntity(instruction: .print))
      .insert(stack: StackEntity(instruction: .ret))
    
    // The start of the main function
    computer.currentAddress = MAIN_BEGIN
    computer = computer.insert(stack: StackEntity(arg:1009, instruction: .push))
      .insert(stack: StackEntity(instruction: .print))
    
    // Return address for when print_tenten function finishes
    computer = computer.insert(stack: StackEntity(arg:6, instruction: .push))
    
    // Setup arguments and call print_tenten
    computer = computer.insert(stack: StackEntity(arg:101, instruction: .push))
      .insert(stack: StackEntity(arg:10, instruction: .push))
      .insert(stack: StackEntity(arg:PRINT_TENTEN_BEGIN, instruction: .call))
    
    // Stop the program
    computer = computer.insert(stack: StackEntity(instruction: .stop))
    
    print("test : \(computer.stacks)")
    self.computer.currentAddress = MAIN_BEGIN
    self.run()
  }
  
  func run() {
    // Used rx to schedule the instruction each 0.5 second
    Observable<Int>.interval(0.5, scheduler: MainScheduler.instance).flatMap({ (index) -> Observable<ComputerEntity> in
      // check the instruction
      return self.managed(self.computer)
    }).observeOn(MainScheduler.instance)
      .subscribe(onError: { (error) in
        // if it stopped, print why
        print("STOPPED : \(error)")
      }).addDisposableTo(self.disposeBag)
  }
  
  // manage all instructions
  func managed(_ computer:ComputerEntity) -> Observable<ComputerEntity> {
    print("currentAddress : \(computer.currentAddress)")
    
    // if there is no instruction in the next stack, there is a problem.. should stop
    guard let stack = computer.stacks[computer.currentAddress], let instruction = stack.instruction else {
      return (self.stopInteractor?.stop(from: self.computer))!
    }
    
    // use a specific interactor, for the specific instruction
    switch instruction {
    case .mult:
      return (self.multInteractor?.mult(from: self.computer))!
    case .call:
      return (self.callInteractor?.call(index:stack.arg, from: self.computer))!
    case .ret:
      return (self.retInteractor?.ret(from: self.computer))!
    case .stop:
      return (self.stopInteractor?.stop(from: self.computer))!
    case .print:
      // TODO: - We can make a delegate Presenter <-> PRINTInteractor to avoid this
      // the print is done here because the interactor don't have the access to the view
      if let arg = self.computer.stacks[self.computer.currentAddress - 1]?.arg {
        // print it if there is an arg
        self.viewDelegate?.print(arg)
      }
      // remove the print value from stack
      self.computer.removeStack(at: self.computer.currentAddress - 1)
      
      return (self.printInteractor?.print(from: self.computer))!
    case .push:
      return (self.pushInteractor?.push(arg: stack.arg, into: self.computer))!
    case .none:
      // do nothing else such as pop the current stack
      return (self.printInteractor?.print(from: self.computer))!
    }
  }
  
}
