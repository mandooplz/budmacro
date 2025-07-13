//
//  WorkFlow.swift
//  BudClient
//
//  Created by 김민우 on 7/11/25.
//
import Foundation
import os


// MARK: WorkFlow
public struct WorkFlow: Sendable {
    static let system = "Bud"
    @TaskLocal public static var id: ID = ID()
    
    
    // MARK: core
    @discardableResult
    public init(id: WorkFlow.ID? = nil, task: @Sendable @escaping () async throws -> Void) async rethrows {
        let workflow = id ?? WorkFlow.ID(value: UUID())
        
        try await WorkFlow.$id.withValue(workflow) {
            try await task()
        }
    }

    
    public static func logging(for objectName: String) -> (Logger, Log) {
        let logger = Logger(subsystem: "Bud", category: objectName)
        let log = Log(by: objectName)
        
        return (logger, log)
    }
    
    
    // MARK: value
    public struct ID: Sendable, Hashable, CustomStringConvertible, Codable {
        public let value: UUID?
        public init(value: UUID? = nil) {
            self.value = value
        }
        
        public var description: String {
            if let value {
                return value.uuidString.prefix(8).description
            } else {
                return "--------"
            }
        }
    }
}


