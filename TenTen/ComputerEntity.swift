//
//  ComputerEntity.swift
//  TenTen
//
//  Created by Jérôme Cha on 29/03/2017.
//  Copyright © 2017 Jérôme Cha. All rights reserved.
//

import UIKit

enum ComputerInstructionEnum : Int {
  case none     = 0
  case mult     = 1
  case call     = 2
  case ret      = 3
  case stop     = 4
  case print    = 5
  case push     = 6
}

class ComputerEntity: NSObject {

  var limit : Int = 0
  var currentAddress : Int = 0
  var shouldReturnTo : Int? = nil
  var stacks : Array<StackEntity?> = []
  
  init(_ limit:Int) {
    self.stacks = Array<StackEntity?>(repeating: nil, count: limit)
  }
  
  // add the stack in the stack list, and update the current address
  func insert(stack:StackEntity) -> ComputerEntity {

    // check if we can add the newStack
    if self.currentAddress < self.stacks.count {
      
      // new stack
      var newStack = stack
      newStack.address = self.currentAddress
      
      // add it
      self.stacks[self.currentAddress] = newStack
      
      // update the currentAddress
      self.currentAddress = self.currentAddress + 1
    }
    
    return self
  }
  
  // get next valid address
  func getNextAddress(_ index:Int? = nil) -> Int {
    // if there is an specific address in param, take it, otherwise, take the current address
    let fromIndex = (index != nil ? index! : self.currentAddress)
    
    // check if we don't exceed the stack
    if fromIndex + 1 < self.stacks.count {
      
      // then go and get the next valid stack address
      for i in fromIndex + 1...self.stacks.count - 1 {
        if let _ = self.stacks[i] {
          return i
        }
      }
    }
    
    // if nothing was found, I return 0. I can return the last address, but I think it is not necessary
    return 0
  }
  
  // get previous valid address
  func getPreviousAddress(_ index:Int? = nil) -> Int {
    // if there is an specific address in param, take it, otherwise, take the current address
    var fromIndex = index != nil ? index! : self.currentAddress
    
    // if the stack was called from a specific address, then use the stack before this specific address instead
    if let calledFromAddress = self.stacks[fromIndex]?.calledFromAddress {
      fromIndex = calledFromAddress
    }
    
    // go reversed and take the previous valid stack
    for i in stride(from: fromIndex - 1, to: -1, by: -1){
      if let _ = self.stacks[i] {
        return i
      }
    }
    return 0
  }
  
  // remove from stack and return the next address of a valid stack
  func removeFromStack() -> Int {
    self.stacks[self.currentAddress] = nil
    return self.getNextAddress()
  }
  
  // remove the stack at a specific address
  func removeStack(at index:Int) {
    self.stacks[index] = nil
  }
  
  // change the currentAddress
  func setAddress(with newAddress:Int) {
    // we cannot set a new addres higher than the limit
    if newAddress < self.stacks.count {
      self.currentAddress = newAddress
    }
  }
}
