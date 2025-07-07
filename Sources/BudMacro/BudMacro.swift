


// named: 매크로로 생성되는 이름?
@attached(member, names: arbitrary)
@attached(peer, names: suffixed(Manager))
@attached(extension)
public macro FirebaseData() = #externalMacro(module: "BudMacroCore", type: "FirebaseDataMacro")


