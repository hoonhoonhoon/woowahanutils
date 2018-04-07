//
//  Array+IndexPath.swift
//  BaeminFresh
//
//  Created by hoonhoon on 2017. 6. 9..
//  Copyright © 2017년 woowahan. All rights reserved.
//

import Foundation
import Attributes

protocol IndexPathSubscriptor {

}

extension Array: IndexPathSubscriptor {

    subscript (index: IndexPath) -> Element {

        get {
            return self[index.row]
        }

        set {
            self[index.row] = newValue
        }

    }

}

extension Array where Element == Int {

	func shuffled() -> [Element] {
		guard self.isEmpty == false else { return self }
		var temp = self
		for _ in 0..<self.count {
			temp = temp.sorted { _, _ in
				arc4random() < arc4random()
			}
		}
		return temp
	}

}

extension Array {

	var safe: SafeArray<Array.Element> {
		return SafeArray<Array.Element>(values: self)
	}

}

protocol SafeCollection {

	associatedtype Element

	var values: [Element] { get }

	subscript(_ index: Int) -> Element? { get }

}

struct SafeArray<Element>: SafeCollection {

	let values: [Element]

	subscript(_ index: Int) -> Element? {
		guard index >= 0 else {
			return nil
		}
		guard index < self.values.count else {
			return nil
		}
		return values[index]
	}

}

extension Array where Element == NSAttributedString {

	func joined(seperator: NSAttributedString) -> NSAttributedString {
		return self.reduce(NSAttributedString(), { (prev, next) -> NSAttributedString in
			if prev.string.isEmpty == false {
				return prev + seperator + next
			}
			return next
		})
	}

}

extension Array {

	func map<T>(keyPath: KeyPath<Element, T>) -> [T] {
		return self.map { $0[keyPath: keyPath] }
	}

	func flatMap<T>(keyPath: KeyPath<Element, T?>) -> [T] {
		return self.compactMap { $0[keyPath: keyPath] }
	}

	func flatten<T>() -> [T] where Element == T? {
		return compactMap { $0 }
	}

}

extension Array where Element: Hashable {
	
	var set: Set<Element> {
		return Set(self)
	}
	
}
