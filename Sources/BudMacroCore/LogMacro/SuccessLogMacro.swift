//
//  SuccessLogMacro.swift
//  BudMacro
//
//  Created by 김민우 on 7/13/25.
//
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros


// MARK: Macro
public struct SuccessLogMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext) throws -> ExprSyntax {
            let argument = node.arguments.first

            return "logger.debug(\"\\(log.success(\(argument)))\")"
    }
}
