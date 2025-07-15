//
//  ShowStateMacroTests.swift
//  BudMacro
//
//  Created by 김민우 on 7/15/25.
//
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import BudMacroCore

private let testMacros: [String: Macro.Type] = [
    "ShowState": ShowStateMacro.self
]

final class ShowStateMacroTests: XCTestCase {
    func testMacro() throws {
        assertMacroExpansion(
            """
            @ShowState
            struct Data: Hashable, Codable {
                var target: Int
                var name: String
                var location: Int
            }
            """,
            expandedSource:
                """
                struct Data: Hashable, Codable {
                    var target: Int
                    var name: String
                    var location: Int
                
                    static let target: String = "target"
                
                    static let name: String = "name"
                
                    static let location: String = "location"
                }
                """,
            macros: testMacros)
    }
    func testMacroWhenTypeNested() throws {
        assertMacroExpansion(
            """
            @ShowState
            struct Data: Hashable, Codable {
                var target: SystemID
                var name: String
                var location: Location
                var rootSource: RootSource
                
                @ShowState
                struct RootSource: Hashable, Codable {
                    let id: String
                    let target: ObjectID
                    let name: String
                }
            }
            """,
            expandedSource:
                """
                struct Data: Hashable, Codable {
                    var target: SystemID
                    var name: String
                    var location: Location
                    var rootSource: RootSource

                    struct RootSource: Hashable, Codable {
                        let id: String
                        let target: ObjectID
                        let name: String

                        static let id: String = "id"

                        static let target: String = "target"

                        static let name: String = "name"
                    }

                    static let target: String = "target"

                    static let name: String = "name"

                    static let location: String = "location"

                    static let rootSource: String = "rootSource"
                }
                """,
            macros: testMacros)
    }
}
