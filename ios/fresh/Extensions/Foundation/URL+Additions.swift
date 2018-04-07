//
//  URL+Additions.swift
//  BaeminFresh
//
//  Created by hoonhoon on 2018. 1. 18..
//  Copyright © 2018년 woowahan. All rights reserved.
//

import Foundation

extension URL {
	
	struct From {
		
		func string(_ string: String) -> URL? {
			return URL(string: string)
		}
		
		func imageEntry(_ entry: Image) -> URL? {
			return self.string(entry.url)
		}
		
	}
	
	static var from: From {
		return From()
	}
	
	func url(relativeTo: URL?) -> URL? {
		guard let to = relativeTo else {
			return nil
		}
		switch self.scheme ?? "" {
		case "http", "https":
			break
		case "":
			break
		default:
			return self
		}

		if let host = self.host, ["baeminchan", "baeminfresh"].filter(host.contains).isEmpty {
			return self
		}

		var comps = URLComponents(url: self, resolvingAgainstBaseURL: true)
		comps?.scheme = nil
		comps?.user = nil
		comps?.password = nil
		comps?.host = nil
		comps?.port = nil
		return comps?.url(relativeTo: to)?.absoluteURL
	}
	
	var isURI: Bool {
		return self.scheme == nil && self.host == nil && self.port == nil && self.user == nil && self.password == nil
	}
}

extension URL: Comparable {
	public static func < (lhs: URL, rhs: URL) -> Bool {
		return lhs.absoluteString < rhs.absoluteString
	}
	public static func <= (lhs: URL, rhs: URL) -> Bool {
		guard lhs.path == rhs.path else {
			return false
		}
		let minus: (String, String) -> String = { (left, right) -> String in
			left.filter { !right.contains($0) }
		}
		return minus(lhs.query ?? "", rhs.query ?? "").isEmpty
	}
}

protocol URLConvertible {
	var url: URL? { get }
}

extension String: URLConvertible {
	var url: URL? {
		return URL(string: self)
	}
}
