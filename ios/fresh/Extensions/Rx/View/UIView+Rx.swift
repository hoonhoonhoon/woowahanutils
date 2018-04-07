//
//  UIView+Rx.swift
//  BaeminFresh
//
//  Created by hoonhoon on 2018. 1. 23..
//  Copyright © 2018년 woowahan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIView {

	var backgroundColor: Binder<UIColor?> {
		return Binder.init(self.base, binding: { (view, backgroundColor) in
			view.backgroundColor = backgroundColor
		})
	}

}
