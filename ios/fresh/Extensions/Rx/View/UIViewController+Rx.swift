//
//  UIViewController+Rx.swift
//  BaeminFresh
//
//  Created by hoonhoon on 2017. 6. 13..
//  Copyright © 2017년 woowahan. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {

  func dismiss(animated: Bool = true) -> Binder<Void> {
    return Binder(self.base, binding: { (viewController: UIViewController, _) in
      viewController.dismiss(animated: animated, completion: nil)
    })
  }

}
