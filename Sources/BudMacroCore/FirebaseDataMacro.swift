import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros


// MARK: Plugin
@main
struct BudMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        FirebaseDataMacro.self
        ]
}




// MARK: Macro
public struct FirebaseDataMacro: PeerMacro {
    // MARK: peer
    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext) throws -> [DeclSyntax] {
            // check class
            guard let classDecl = declaration.as(ClassDeclSyntax.self) else {
                return []
            }
            let objectName = classDecl.name.text
            
            
            // objectManager
            let objectManager: DeclSyntax = {
                """
                @MainActor @Observable
                fileprivate final class \(raw: objectName)Manager: BudClient {
                    fileprivate static var container: [\(raw: objectName).ID:\(raw: objectName)] = [:]
                    fileprivate static func register(_ object: \(raw: objectName)) {
                        self.container[object.id] = object
                    }
                    fileprivate static func unregister(_ id: \(raw: objectName).ID) {
                        self.container[id] = nil
                    }
                }
                """
            }()
            
            // return
            return []
    }
}
