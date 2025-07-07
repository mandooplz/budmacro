import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import BudMacroCore


// MARK: TestMacros
let testMacros: [String: Macro.Type] = [
    "FirebaseData": FirebaseDataMacro.self
]


// MARK: Tests
final class ClientObjectTests: XCTestCase {
    func testPeerMacro() throws {
        assertMacroExpansion(
            """
            package struct Data: Hashable, Codable {
                @DocumentID var id: String?
                package var name: String
                package var creator: UserID
                package var target: ProjectID
            }
            """,
        expandedSource:
            """
            """, macros: testMacros)
    }
}
