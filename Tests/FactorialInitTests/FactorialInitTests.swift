//import SwiftSyntaxMacros
//import FactorialFuncMacros
//import SwiftSyntaxMacrosTestSupport
//import XCTest
//import FactorialFunc
//
//let testMacros: [String: Macro.Type] = [
//    "FactorialFunc": FactorialFuncMacro.self,
//]
//
//final class FactorialFuncTests: XCTestCase {
//    func testMacro() throws {
//        assertMacroExpansion(
//            """
//            @FactorialFunc
//            func a(_ name: Int, @ViewBuilder age: () -> Void, f: [Int], action: @escaping () async -> Void) {
//                
//            }
//            """,
//            expandedSource: """
//            (a + b, "a + b")
//            """,
//            macros: testMacros
//        )
//    }
//    
//    func testMacroWithStringLiteral() throws {
//        assertMacroExpansion(
//            #"""
//            #stringify("Hello, \(name)")
//            """#,
//            expandedSource: #"""
//            ("Hello, \(name)", #""Hello, \(name)""#)
//            """#,
//            macros: testMacros
//        )
//    }
//}
