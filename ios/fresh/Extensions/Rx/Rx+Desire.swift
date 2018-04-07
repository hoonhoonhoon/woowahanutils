//
//  RxElse.swift
//  BaeminFresh
//
//  Created by hoonhoon on 2018. 3. 14..
//  Copyright © 2018년 woowahan. All rights reserved.
//

import RxSwift

extension Observable {

	var desire: Desire<Element> {
		return Desire(self)
	}

}

protocol Desireable: ObservableType {
	associatedtype Element
	var observable: Observable<Element> { get }
}

extension Desireable {
	func asObservable() -> Observable<Element> {
		return observable
	}
	func subscribe<O: ObserverType>(_ observer: O) -> Disposable where O.E == Element {
		return self.observable.subscribe(observer)
	}
}

struct Desire<Element>: Desireable {
	var observable: Observable<Element>
	internal init(_ observable: Observable<Element>) {
		self.observable = observable
	}
}

struct Stop<Element>: Desireable {
	var observable: Observable<Element>
	internal init(_ observable: Observable<Element>) {
		self.observable = observable
	}

	func stop(_ transform: @escaping (Element) throws -> Bool) -> Observable<Element> {
		return self.observable.filter(transform)
	}
}

extension Stop where Element: OptionalType {
	var ifNil: Observable<Element> {
		return self.stop { $0.value != nil }
	}
}

extension Desire {
	var stop: Stop<Element> {
		return Stop<Element>.init(self.observable)
	}
}

struct Cast<Element>: Desireable {
	var observable: Observable<Element>
	internal init(_ observable: Observable<Element>) {
		self.observable = observable
	}
}

extension Cast where Element: OptionalType {
	var unwrap: Observable<Element.Wrapped> {
		return self.observable.flatMap { (element) -> Observable<Element.Wrapped> in
			guard let unwrapped = element.value else {
				return .never()
			}
			return .just(unwrapped)
		}
	}
}

extension Desire {
	var cast: Cast<Element> {
		return Cast(self.observable)
	}
}
