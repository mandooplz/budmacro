//
//  Log.swift
//  BudClient
//
//  Created by 김민우 on 7/13/25.
//
import Foundation


// MARK: Log
public struct Log: Sendable {
    let objectName: String
    public init(by objectName: String) {
        self.objectName = objectName
    }
    
    // MARK: Success
    public func success(_ description: String? = nil,
                        _ workflow: WorkFlow.ID = WorkFlow.id,
                        _ routine: String = #function) -> String {
        if let description {
            return "[\(workflow)] ✅ \(self.objectName).\(routine) success\n\(description)"
        } else {
            return "[\(workflow)] ✅ \(self.objectName).\(routine) success"
        }
    }
    
    // MARK: Failure
    public func failure(_ description: String? = nil,
                        _ workflow: WorkFlow.ID = WorkFlow.id,
                        _ routine: String = #function) -> String {
        if let description {
            return "[\(workflow)] ⚠️ \(self.objectName).\(routine) failure\n\(description)"
        } else {
            return "[\(workflow)] ⚠️ \(self.objectName).\(routine) failure"
        }
    }
    
    
    
    
    // MARK: Critical
    public func critical(_ description: String? = nil,
                         _ workflow: WorkFlow.ID = WorkFlow.id,
                         _ routine: String = #function) -> String {
        if let description {
            return "[\(workflow)] ❌ \(self.objectName).\(routine) critical\n\(description)"
        } else {
            return "[\(workflow)] ❌ \(self.objectName).\(routine) critical"
        }
    }
    
}
