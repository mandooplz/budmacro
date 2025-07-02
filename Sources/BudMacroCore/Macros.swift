import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros


// MARK: Plugin
@main
struct BudMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        ClientObjectMacro.self
        ]
}



// MARK: Macro
public struct ClientObjectMacro: MemberMacro, PeerMacro {
    // MARK: member
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext) throws -> [DeclSyntax] {
            // 1. id의 구현 -> public
            // 2. ID의 구현 -> public
            return []
    }
    
    // MARK: peer
    static public func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext) throws -> [DeclSyntax] {
            // 1. ObjectManager의 구현 -> internal
            return []
    }
}


public struct ServerObjectMacro {
    
}





