//
//  Invalidator.swift
//  BaeminFresh
//
//  Created by hoonhoon on 2018. 3. 27..
//  Copyright © 2018년 woowahan. All rights reserved.
//

import Foundation

/// WKWebView의 navigationDelegate에서
/// decisionHandle함수를 호출 하지 않으면 에러를 발생하는데, 이걸 어떻게 구현했을까 생각하다.
/// 아마 이것인거 같아 언젠가 써먹어 보자 하고 만들어 봤습니다.
class Invalidator {

	let lock: NSRecursiveLock = NSRecursiveLock()
	private var _invalidated: Bool = false

	private var file: String
	private var line: Int
	private var function: String
	private var message: String

	static func invalidator(file: String = #file, line: Int = #line, function: String = #function, message: String) -> Invalidator {
		return Invalidator(file: file, line: line, function: function, message: message)
	}
	private init(file: String, line: Int, function: String, message: String) {
		self.file = file
		self.line = line
		self.function = function
		self.message = message
	}

	func invalidate() {
		lock.lock()
		defer { lock.unlock() }
		_invalidated = true
	}

	deinit {
		lock.lock()
		defer { lock.unlock() }
		guard _invalidated else {
			fatalError("\(file)(:\(line)).\(function) -> \(message)")
		}
	}
}
