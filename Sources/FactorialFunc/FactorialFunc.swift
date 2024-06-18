@attached(peer, names: named(overloaded), arbitrary)
public macro FactorialFunc() = #externalMacro(module: "FactorialFuncMacros", type: "FactorialFuncMacro")
