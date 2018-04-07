//
//  Int+NumberFormat.swift
//  BaeminFresh
//
//  Created by hoonhoon on 2017. 12. 28..
//  Copyright © 2017년 woowahan. All rights reserved.
//

import Foundation

extension Int {

	var formatted: FormattedNumber {
		return FormattedNumber(value: self)
	}

}

struct FormattedNumber {

	private let value: NSNumber

	init(value: Int) {
		self.value = NSNumber(value: value)
	}

	var commaPerThree: String {
		let priceFormatter = NumberFormatter()
		priceFormatter.groupingSeparator = ","
		priceFormatter.groupingSize = 3
		priceFormatter.usesGroupingSeparator = true
		return priceFormatter.string(from: value) ?? ""
	}

    var money: String {
        return commaPerThree
    }

    var count: String {
        return commaPerThree
    }

}
