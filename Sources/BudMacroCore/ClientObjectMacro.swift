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
public struct ClientObjectMacro: MemberMacro, PeerMacro, ExtensionMacro {
    // MARK: extension
    public static func expansion(
        of node: AttributeSyntax,
        attachedTo: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
      ) throws -> [ExtensionDeclSyntax] {
        // you might want to assert that 'protocols' is empty here if your macro does not add conformances

        let decl: DeclSyntax =
          """
          extension \(type.trimmed): SampleProtocol { 
              var name: String { return "sample" }
              var age: Int { return 123123 }
          }
          """

        guard let extensionDecl = decl.as(ExtensionDeclSyntax.self) else {
            throw Error.onlyApplicableForClass
        }

        return [extensionDecl]
      }
    
    
    // MARK: member
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext) throws -> [DeclSyntax] {
            // check class
            guard let classDecl = declaration.as(ClassDeclSyntax.self) else {
                throw Error.onlyApplicableForClass
            }
            
            let objectName = classDecl.name.text
            
            
            // IDStruct
            let IDStruct: DeclSyntax =  {
                """
                @MainActor
                public struct ID: Sendable, Hashable {
                    public let value: UUID
                
                    public init(_ value: UUID = UUID()) {
                        self.value = value
                    }
                
                    internal var isExist: Bool {
                        return \(raw:objectName)Manager.container[self] != nil
                    }
                
                    public var ref: \(raw: objectName)? {
                        return \(raw: objectName)Manager.container[self]
                    }
                }
                """
            }()
            
            // deleteObject
            let deleteObject: DeclSyntax = {
                """
                internal func delete() { 
                    \(raw: objectName)Manager.unregister(self.id) 
                }
                """
            }()
            

            return []
    }
    
    
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
    
    // MARK: error
    public enum Error: CustomStringConvertible, Swift.Error {
        case onlyApplicableForClass
        
        public var description: String {
            switch self {
            case .onlyApplicableForClass:
                return "@ClientObject can only be applied to an class"
            }
        }
    }
}
