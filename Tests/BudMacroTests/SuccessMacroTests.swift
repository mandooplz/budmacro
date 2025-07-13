//
//  LogTests.swift
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


// MARK: TestMacros
private let testMacros: [String: Macro.Type] = [
    "success": SuccessLogMacro.self
]


// MARK: Tests
final class SuccessLogMacroTests: XCTestCase {
    func testExpression() throws {
        assertMacroExpansion(
            "#success",
            expandedSource:"logger.debug(\"\\(log.success())\")",
            macros: testMacros
        )
    }
    
    func testExpressionWhenNil() throws {
        assertMacroExpansion(
            "#success()",
            expandedSource:"logger.debug(\"\\(log.success())\")",
            macros: testMacros
        )
    }
    
    
    func testExpressionWithInfo() throws {
        assertMacroExpansion(
            "#success(\"Good!\")",
            expandedSource:"logger.debug(\"\\(log.success(\"Good!\"))\")",
            macros: testMacros
        )
    }
    
}




