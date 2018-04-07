//
//  Date+Additions.swift
//  BaeminFresh
//
//  Created by hoonhoon on 2017. 9. 26..
//  Copyright © 2017년 woowahan. All rights reserved.
//

import Foundation

enum DateElement {
  case year(Int)
  case month(Int)
  case day(Int)
  case hour(Int)
  case minute(Int)
  case second(Int)
}

extension Optional where Wrapped: SignedInteger {
  fileprivate var valueOrZero: Int {
    let value = self as? Int
    return value ?? 0
  }
}

extension DateComponents {

  func added(with dateElement: DateElement) -> DateComponents {

    var comps = self

    switch dateElement {
    case .year(let value):
      comps.year = comps.year.valueOrZero + value
    case .month(let value):
      comps.month = comps.month.valueOrZero + value
    case .day(let value):
      comps.day = comps.day.valueOrZero + value
    case .hour(let value):
      comps.hour = comps.hour.valueOrZero + value
    case .minute(let value):
      comps.minute = comps.minute.valueOrZero + value
    case .second(let value):
      comps.second = comps.second.valueOrZero + value
    }

    return comps
  }

  func set(with dateElement: DateElement) -> DateComponents {

    var comps = self

    switch dateElement {
    case .year(let value):
      comps.year = value
    case .month(let value):
      comps.month = value
    case .day(let value):
      comps.day = value
    case .hour(let value):
      comps.hour = value
    case .minute(let value):
      comps.minute = value
    case .second(let value):
      comps.second = value
    }

    return comps

  }
}

extension Date {

  var UTCString: String {
    return DateFormatter.UTC.string(from: self)
  }

  func components(_ components: Set<Calendar.Component>) -> DateComponents {
    return Calendar.current.dateComponents(components, from: self)
  }

  var yearMonthDay: Date? {
    return Calendar.current.date(from: self.components([.year, .month, .day]))
  }

  func added(with dateElement: DateElement) -> Date? {
    return Calendar.current.date(from: self.components([.year, .month, .day]).added(with: dateElement))
  }

  func set(with dateElement: DateElement) -> Date? {
    return Calendar.current.date(from: self.components([.year, .month, .day]).set(with: dateElement))
  }

}

extension DateFormatter {

	static let UTC: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
		formatter.timeZone = TimeZone(abbreviation: "UTC")
		return formatter
	}()

	static let JSONDate: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy'-'MM'-'dd"
		return formatter
	}()

	static let JSONDateTime: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy'-'MM'-'dd'\t'HH':'mm':'ss"
		return formatter
	}()
}
