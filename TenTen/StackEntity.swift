//
//  StackEntity.swift
//  TenTen
//
//  Created by Jérôme Cha on 29/03/2017.
//  Copyright © 2017 Jérôme Cha. All rights reserved.
//

import UIKit

struct StackEntity: Hashable {
  var address : Int = 0
  var calledFromAddress : Int? = nil
  var arg : Int?
  var instruction : ComputerInstructionEnum?
  
  init() {

  }
  
  init(address:Int) {
    self.address = address
  }
  
  init(arg:Int, instruction:ComputerInstructionEnum) {
    self.arg = arg
    self.instruction = instruction
  }
  
  init(instruction:ComputerInstructionEnum) {
    self.instruction = instruction
  }
  
  //MARK: - Hashable protocol
  public var hashValue: Int {
    return address
  }
  
  static func == (lhs: StackEntity, rhs: StackEntity) -> Bool {
    return lhs.address == rhs.address
  }
  
}
