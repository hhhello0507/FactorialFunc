//import SwiftSyntaxMacros
//import FactorialInitMacros
//import SwiftSyntaxMacrosTestSupport
//import XCTest
//import FactorialInit
//
//let testMacros: [String: Macro.Type] = [
//    "FactorialInit": FactorialInitMacro.self,
//]
//
//final class FactorialInitTests: XCTestCase {
//    func testMacro() throws {
//        assertMacroExpansion(
//            """
//            @FactorialInit
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
