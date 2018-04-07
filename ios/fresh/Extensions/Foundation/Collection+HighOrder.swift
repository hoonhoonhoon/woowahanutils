//
//  Collection+HighOrder.swift
//  BaeminFresh
//
//  Created by hoonhoon on 2018. 3. 14..
//  Copyright © 2018년 woowahan. All rights reserved.
//

import Foundation

protocol HighOrderable: Collection {}

extension HighOrderable where Element: Collection {
	var flatten: [Element.Element] {
		return self.flatMap { $0 }
	}
}

extension HighOrderable where Element: OptionalType {
	var flatten: [Element.Wrapped] {
		return self.compactMap { $0.value }
	}
}

extension Array: HighOrderable {}
