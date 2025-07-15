//
//  CriticalLogMacroTests.swift
//  BudMacro
//
//  Created by 김민우 on 7/13/25.
//
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import BudMacroCore

private let testMacros: [String: Macro.Type] = [
    "critical": CriticalLogMacro.self
]


final class CriticalLogMacroTests: XCTestCase {
    func testCriticalWithInfo() throws {
        assertMacroExpansion(
            "#critical(\"Reason\")",
            expandedSource:"logger.fault(\"\\(log.critical(\"Reason\"))\")",
            macros: testMacros
        )
    }
    
    func testCriticalMacro() throws {
        assertMacroExpansion(
            "#critical()",
            expandedSource:"logger.fault(\"\\(log.critical())\")",
            macros: testMacros
        )
    }
    
    func testCriticalMacroWhenNil() throws {
        assertMacroExpansion(
            "#critical",
            expandedSource:"logger.fault(\"\\(log.critical())\")",
            macros: testMacros
        )
    }
}



