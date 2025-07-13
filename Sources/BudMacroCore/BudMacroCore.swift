//
//  BudMacroCore.swift
//  BudMacro
//
//  Created by 김민우 on 7/13/25.
//
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros


// MARK: Plugin
@main
public struct BudMacroPlugin: CompilerPlugin {
    public init() { }
    public let providingMacros: [Macro.Type] = [
        SuccessLogMacro.self,
        FailureLogMacro.self,
        CriticalLogMacro.self
    ]
}

