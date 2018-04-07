//
//  UIViewAnimation+Rx.swift
//  BaeminFresh
//
//  Created by hoonhoon on 2017. 5. 15..
//  Copyright © 2017년 woowahan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIView {

    public func animation(duration: TimeInterval = 0.25, animation: @escaping (Base) -> Void) -> Driver<Void> {
        return Single<Void>.create(subscribe: { (event) -> Disposable in
            UIView.animate(withDuration: duration,
                           animations: {animation(self.base)},
                           completion: { _ in event(SingleEvent.success(()))})
            return Disposables.create()
        }).subscribeOn(MainScheduler.instance).asDriver(onErrorJustReturn: ())
    }

}
