//
//  ShowStateMacro.swift
//  BudMacro
//
//  Created by 김민우 on 7/15/25.
//
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros


// MARK: ShowStateMaco
public struct ShowStateMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext) throws -> [DeclSyntax] {
            let members = declaration.memberBlock.members
            
            let propertyNames = members.compactMap { $0.decl.as(VariableDeclSyntax.self) }
                .compactMap { $0.bindings.first }
                .compactMap { $0.pattern.as(IdentifierPatternSyntax.self) }
                .map { $0.identifier.text }
            
            let decls: [DeclSyntax] = propertyNames
                .map { name in
                    "static let \(raw: name): String = \"\(raw: name)\""
                }
        return decls
    }
}
