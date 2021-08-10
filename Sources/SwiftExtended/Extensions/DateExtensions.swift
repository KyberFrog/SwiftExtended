//
//  DateExtenstions.swift
//  
//
//  Created by vladIcedigital on 11.06.2021.
//

import Foundation

public extension NSDate {
	func isBetweeen(date date1: NSDate, andDate date2: NSDate) -> Bool {
		return date1.compare(self as Date).rawValue >= self.compare(date2 as Date).rawValue
	}
}


public extension Date {
	func format(_ format:String) -> String {
		return Date.format(self, format: format)
	}
	
	static func format(_ date: Date, format:String) -> String {
		let formatter = DateFormatter()
		let locale = Locale(identifier: "en_US_POSIX")
		formatter.locale = locale
		formatter.dateFormat = format
		let string = formatter.string(from: date)
		return string
	}
	
}
