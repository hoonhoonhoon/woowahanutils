//
//  Operators.swift
//  BaeminFresh
//
//  Created by hoonhoon on 2018. 4. 5..
//  Copyright © 2018년 woowahan. All rights reserved.
//

import Foundation

func *<V>(lhs: V, rhs: Int) -> [V] {
	return [V].init(repeating: lhs, count: rhs)
}
