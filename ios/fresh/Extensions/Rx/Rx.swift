//
//  Rx.swift
//  BaeminFresh
//
//  Created by hoonhoon on 2017. 5. 17..
//  Copyright © 2017년 woowahan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType {

	public func doNext(_ next: @escaping (E) -> Void) -> Observable<E> {
		return self.do(onNext: next)
	}

	public func bool(_ value: Bool, errorValue: Bool? = nil) -> Observable<Bool> {
		var observable = map { _ in value }
		if let errorValue = errorValue {
			observable = observable.catchErrorJustReturn(errorValue)
		}
		return observable
	}

	public func cast<C>(_ type: C.Type) -> Observable<C> {
		return map {
			guard let casted = $0 as? C else {
				fatalError()
			}
			return casted
		}
	}

	func map<T>(keyPath: KeyPath<E, T>) -> Observable<T> {
		return self.map {
			$0[keyPath: keyPath]
		}
	}

	public func void() -> Observable<Void> {
		return map { _ in }
	}

	public func doDebug(tag: String) -> Observable<E> {
		if ProcessInfo().environment["RXDEBUG"] == "enable" {
			return self.do(onNext: { (value) in Logger.log("😦 \(tag) next -> \(value)") },
						   onError: { (error) in Logger.log("😦 \(tag) error -> \(error)") },
						   onCompleted: { Logger.log("😦 \(tag) completed") },
						   onSubscribe: { Logger.log("😦 \(tag) subscribe") },
						   onSubscribed: { Logger.log("😦 \(tag) subscribed") },
						   onDispose: { Logger.log("😦 \(tag) disposed") }
			)
		} else {
			return self.do()
		}
	}

	public func subscribeDebug(tag: String) -> Disposable {
		return subscribe({ (e) in
			switch e {
			case .completed: print("\(tag) completed")
			case .next: print("\(tag) next")
			case .error: print("\(tag) error")
			}
		})
	}
}

extension ObservableType where E: Entry {

	func nullable() -> Observable<E?> {
		return map { $0.isEmpty ? nil : $0 }
	}

	func null<T>(_ type: T.Type) -> Observable<T?> {
		return map { _ -> T? in nil }
	}

}

extension ObservableType where E == String {
    func trim() -> Observable<E> {
        return map { $0.trimmedInWhitespacesAndNewLines() }
    }
}

extension Reactive where Base: NSObject {

	func observe<Value>(keyPath: KeyPath<Base, Value>) -> Observable<(Base, NSKeyValueObservedChange<Value>)> {
		return Observable<(Base, NSKeyValueObservedChange<Value>)>.create { (observer) -> Disposable in
			let observation = self.base.observe(keyPath, options: [.new, .old, .initial, .prior]) { (base, change) in
				observer.onNext((base, change))
			}
			return Disposables.create {
				observation.invalidate()
			}
		}
	}
}
