//
//  OptionalType.swift
//  BaeminFresh
//
//  Created by hoonhoon on 2018. 3. 14..
//  Copyright © 2018년 woowahan. All rights reserved.
//

import Foundation

protocol OptionalType {
	associatedtype Wrapped
	var value: Wrapped? { get }
}

extension Optional: OptionalType {
	var value: Wrapped? {
		return self
	}
}
