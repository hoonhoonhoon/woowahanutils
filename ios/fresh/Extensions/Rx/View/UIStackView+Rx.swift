//
//  UIStackView+Rx.swift
//  BaeminFresh
//
//  Created by hoonhoon on 2018. 1. 9..
//  Copyright © 2018년 woowahan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIStackView {

	func arrangedSubviews<V>() -> Binder<[V]> where V: UIView {
		return Binder.init(self.base, binding: { (stackView, arrangedSubviews) in
			arrangedSubviews.forEach(stackView.addArrangedSubview)
		})
	}

}
