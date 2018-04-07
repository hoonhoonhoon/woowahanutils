//
//  Observable+Additions.swift
//  BaeminFresh
//
//  Created by hoonhoon on 2018. 3. 2..
//  Copyright © 2018년 woowahan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Observable {

	func observeOnMain() -> Observable<Element> {
		return self.observeOn(MainScheduler.instance)
	}

}

extension Observable where Element == Void {

	func asDriver() -> Driver<Element> {
		return self.asDriver(onErrorJustReturn: ())
	}

}
