//
//  FailureLogMacroTests.swift
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
    "failure": FailureLogMacro.self
]


final class FailureLogMacroTests: XCTestCase {
    func testFailureMacro() throws {
        assertMacroExpansion(
            "#failure",
            expandedSource:"logger.error(\"\\(log.failure())\")",
            macros: testMacros
        )
    }
}
