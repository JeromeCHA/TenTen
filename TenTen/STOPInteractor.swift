//
//  STOPInteractor.swift
//  TenTen
//
//  Created by Jérôme Cha on 29/03/2017.
//  Copyright © 2017 Jérôme Cha. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

enum STOPEnum : Error {
  case stopped
}

class STOPInteractor: NSObject {

  // Stop Rx
  func stop(from computerEntity:ComputerEntity) -> Observable<ComputerEntity> {
    return Observable.create { observer in
      let cancel = Disposables.create()
      
      // the only way to stop a chain of Rx is to send an error
      observer.onError(STOPEnum.stopped)
      
      return cancel
    }
  }
  
}
