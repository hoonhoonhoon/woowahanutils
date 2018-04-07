import Foundation

internal extension String {

	func trimmedInWhitespacesAndNewLines() -> String {
		return self.trimmingCharacters(in: .whitespacesAndNewlines)
	}

}

protocol StringColorConvertible {

	var color: UIColor? { get }

}

extension StringColorConvertible where Self: CustomStringConvertible {

	var colorForRgba: UIColor? {
		return UIColor.init(rgba: self.description)
	}

}

extension String {

	struct URLString {

		let string: String

		private var nsString: NSString {
			return string as NSString
		}

		var removingPercentageEncoding: String {
			return nsString.removingPercentEncoding ?? ""
		}

		func added(scheme: String) -> String {
			let string = self.removingPercentageEncoding.trimmedInWhitespacesAndNewLines()
			if scheme == "" {
				return string
			} else if string.hasPrefix("\(scheme):") {
				return string
			} else if string.hasPrefix(":") {
				return "\(scheme)\(string)"
			}
			return "\(scheme):\(string)"
		}

	}

	var urlString: URLString {
		return URLString(string: self)
	}
}
