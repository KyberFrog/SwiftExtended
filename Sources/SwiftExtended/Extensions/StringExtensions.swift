//
//  StringExtensions.swift
//  
//
//  Created by vladIcedigital on 11.06.2021.
//

import Foundation
import UIKit

public extension String {
	var length: Int {
		return self.count
	}
	
	subscript (i: Int) -> String {
		return self[i ..< i + 1]
	}
	
	func substring(from: Int) -> String {
		return self[min(from, length) ..< length]
		
	}
	
	
	func substring(with nsrange: NSRange) -> Substring? {
		guard let range = Range(nsrange, in: self) else { return nil }
		return self[range]
	}
	
	
	func substring(to: Int) -> String {
		return self[0 ..< max(0, to)]
	}

	
	subscript (bounds: CountableClosedRange<Int>) -> String {
		let start = index(startIndex, offsetBy: bounds.lowerBound)
		let end = index(startIndex, offsetBy: bounds.upperBound)
		return String(self[start...end])
	}
	
	subscript (bounds: CountableRange<Int>) -> String {
		let start = index(startIndex, offsetBy: bounds.lowerBound)
		let end = index(startIndex, offsetBy: bounds.upperBound)
		return String(self[start..<end])
	}
	
	
	
	
	func replace(string:String, replacement:String) -> String {
		return self.replacingOccurrences(of: string, with: replacement, options: CompareOptions.literal, range: nil)
	}
	func removeWhitespace() -> String {
		return self.replace(string: " ", replacement: "")
	}

	static func convertStrToDate (_ strDate:String, withOriginalDateFormat odf:String) -> Date {
		
		let formatter = DateFormatter()
		let locale = Locale(identifier: "en_US_POSIX")
		formatter.dateFormat = odf
		formatter.locale = locale
		
		if let date = formatter.date(from: strDate) {
			return date
		}
		else {
			print()
			
			fatalError("Wrong format! Given format is '\(odf)'. And given string is '\(strDate)'!")
			
		}
	}
	
	static func convertStrDateToTimeStamp (_ oDate:String, withOriginalDateFormat odf:String) -> Double{
		let date = self.convertStrToDate(oDate, withOriginalDateFormat: odf)
		let timestamp = date.timeIntervalSince1970
		return timestamp
	}
	
	func convertStrToDate(withOriginalDateFormat odf:String) -> Date {
		return String.convertStrToDate(self, withOriginalDateFormat: odf)
	}
	
	func convertStrDateToTimeStamp (withOriginalDateFormat odf:String) -> Double {
		return String.convertStrDateToTimeStamp(self, withOriginalDateFormat: odf)
	}
	
	
	func matches(for regex: String) -> Bool {
		return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
	}
	
	func matches(for regex: String) -> [String] {
		
		do {
			let regex = try NSRegularExpression(pattern: regex)
			let nsString = self as NSString
			let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
			return results.map { nsString.substring(with: $0.range)}
		} catch let error {
			print("invalid regex: \(error.localizedDescription)")
			return []
		}
	}
	
	func removeCharacters(from forbiddenChars: CharacterSet) -> String {
		let passed = self.unicodeScalars.filter { !forbiddenChars.contains($0) }
		return String(String.UnicodeScalarView(passed))
	}
	
	func removeCharacters(from: String) -> String {
		return removeCharacters(from: CharacterSet(charactersIn: from))
	}
}


public extension UILabel {
	class func height(text: String, withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font : font], context: nil)
		
		return ceil(boundingBox.height)
	}
}
