/*
 *  MLLogger.swift
 *  https://github.com/magnolialogic/ml-common
 *
 *  © 2021-Present @magnolialogic
 */

import Foundation
import os.log

public enum MLLogger {
	
	// MARK: Public interface
	
	public static func debug(_ message: String, logContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
		MLLogger.write(.debug, string: message, context: Context(file: file, function: function, line: line))
	}
   
	public static func console(_ message: String, logContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
		MLLogger.write(string: message, context: Context(file: file, function: function, line: line))
	}
	
	public static func warning(_ message: String, logContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
		MLLogger.write(.fault, string: message, context: Context(file: file, function: function, line: line))
	}
	
	public static func error(_ message: String, logContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
		MLLogger.write(.error, string: message, context: Context(file: file, function: function, line: line))
	}
	
	// MARK: Dirty work
	
	fileprivate struct Context {
		let file: String
		let function: String
		let line: Int
		var summary: String {
			return "\((file as NSString).lastPathComponent):\(line) \(function)"
		}
	}
	
	fileprivate static func write(_ priority: OSLogType = .default, string: String, context: Context) {
		var message = ""
#if DEBUG
		message += "\(context.summary) ➜ "
#endif
		message += string
		
		switch priority {
		case .error:
			Logger(subsystem: "net.magnolialogic.MLCommon", category: "Error").error("\(message)")
		case .fault:
			Logger(subsystem: "net.magnolialogic.MLCommon", category: "Warning").warning("\(message)")
		case .debug:
#if DEBUG
			Logger(subsystem: "net.magnolialogic.MLCommon", category: "Debug").error("\(message)")
#endif
		default:
			Logger(subsystem: "net.magnolialogic.MLCommon", category: "Console").log("\(message)")
		}
	}
}
