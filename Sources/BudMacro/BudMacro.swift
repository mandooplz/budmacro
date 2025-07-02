


// names를 어떻게 작성하는가.
// 클래스의 이름을 어떻게 추출하는가. 
@attached(member, names: arbitrary)
@attached(peer, names: suffixed(name))
public macro ClientObject() = #externalMacro(module: "BudMacroCore", type: "ClientObjectMacro")


