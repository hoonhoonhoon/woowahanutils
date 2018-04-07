//
//  Optional+Additions.swift
//  BaeminFresh
//
//  Created by hoonhoon on 2018. 2. 19..
//  Copyright © 2018년 woowahan. All rights reserved.
//

import Foundation

extension Optional {
	func unwraped<Converted>(`default` value: Converted, handle: (Wrapped) -> Converted) -> Converted {
		guard let unwrapped = self else {
			return value
		}
		return handle(unwrapped)
	}
}
