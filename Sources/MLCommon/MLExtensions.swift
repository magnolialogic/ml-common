/*
 *  MLExtensions.swift
 *  https://github.com/magnolialogic/ml-common
 *
 *  © 2021-Present @magnolialogic
 */

import Foundation
#if os(Linux)
import Crypto
#else
import CryptoKit
#endif

public extension Bool {
	@discardableResult mutating func guarantee(matches bool: Bool) -> Bool {
		var valueChanged = false
		if self != bool {
			self = bool
			valueChanged = true
		}
		return valueChanged
	}
}

public extension Int {
	func bool() -> Bool {
		return self == 1 ? true : false
	}

	func isValidBool() -> Bool {
		return [0, 1].contains(self)
	}
	
	@discardableResult mutating func guarantee(matches int: Int) -> Bool {
		var valueChanged = false
		if self != int {
			self = int
			valueChanged = true
		}
		return valueChanged
	}
}

public extension String {
#if !os(Linux)
	var isValidURL: Bool {
		let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
		if let match = detector?.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
			return match.range.length == self.utf16.count
		} else {
			return false
		}
	}
#endif
	
	func saltedMD5Digest(prefix: String? = nil, suffix: String? = nil) -> String {
		let salted = (prefix ?? "") + self + (suffix ?? "")
		let digest = Insecure.MD5.hash(data: salted.data(using: .utf8)!)
		return digest.map {
			String(format: "%02hhx", $0)
		}.joined()
	}

	fileprivate func capitalizingFirstLetter() -> String {
		return prefix(1).capitalized + dropFirst()
	}

	mutating func capitalizeFirstLetter() {
		self = self.capitalizingFirstLetter()
	}
	
	@discardableResult mutating func guarantee(matches string: String) -> Bool {
		var valueChanged = false
		if self != string {
			self = string
			valueChanged = true
		}
		return valueChanged
	}
}

public extension Dictionary {
	func jsonData() throws -> Data {
		return try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
	}
}

public extension Data {
	var bytes: [UInt8] {
		return [UInt8](self)
	}
}
