//
//  UIControl+Rx.swift
//  BaeminFresh
//
//  Created by hoonhoon on 2018. 3. 30..
//  Copyright © 2018년 woowahan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIControl {

	var state: Observable<UIControlState> {
		return self.observe(keyPath: \Base.state).map { (value) in  value.1.newValue }.desire.cast.unwrap
	}

}
