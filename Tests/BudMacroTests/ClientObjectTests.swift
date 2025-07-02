import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import BudMacroCore


// MARK: TestMacros
let testMacros: [String: Macro.Type] = [
    "ClientObject": ClientObjectMacro.self
]


// MARK: Tests
final class ClientObjectTests: XCTestCase {
    func testMemberMacro() throws {
        assertMacroExpansion(
            """
            @ClientObject
            final class Mandoo {
            }
            """,
        expandedSource:
            """
            final class Mandoo {

                public nonisolated let id: ID = ID()

                public struct ID: Sendable, Hashable {
                    public let value: UUID

                    public init(_ value: UUID = UUID()) {
                        self.value = value
                    }

                    internal var isExist: Bool {
                        return MandooManager.container[self] != nil
                    }

                    public var ref: Mandoo? {
                        return MandooManager.container[self]
                    }
                }

                internal func delete() {
                    MandooManager.unregister(self)
                }
            }
            
            import Foundation
            import Observation

            @MainActor @Observable
            fileprivate final class MandooManager: Sendable {
                fileprivate static var container: [Mandoo.ID: Mandoo] = [:]
                fileprivate static func register(_ object: Mandoo) {
                    self.container[object.id] = object
                }
                fileprivate static func unregister(_ id: Mandoo.ID) {
                    self.container[id] = nil
                }
            }
            """, macros: testMacros)
    }
    
    func testWhenAttachedToStruct() throws {
        assertMacroExpansion(
            """
            @ClientObject
            struct Mandoo {
            }
            """,
            expandedSource:
            """
            struct Mandoo {
            }
            """,
            diagnostics: [
                DiagnosticSpec(message: "@ClientObject can only be applied to an class", line: 1, column: 1)
            ]
            ,
            macros: testMacros)
    }
}
