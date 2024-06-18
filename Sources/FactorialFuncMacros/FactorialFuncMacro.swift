import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public enum Error: Swift.Error {
    case notInit
}

public struct FactorialFuncMacro: PeerMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        
        guard let function = declaration.as(FunctionDeclSyntax.self) else {
            throw Error.notInit
        }
        let signature = function.signature
        let originParams = signature.parameterClause
        let paramLength = originParams.parameters.count
        
        var result: [[Int]] = []
        
        /**
         result: just result
         i: current index
         myArr: current index list
         length: paramLength
         */
        func dfs(remain: [Int], i: Int, myArr: [Int], length: Int) {
            if i == length {
                result.append(myArr)
                return
            }
            for r in remain {
                var newMyArr = myArr
                newMyArr.append(r)
                
                var newRemain = remain
                newRemain.removeAll { $0 == r }
                
                dfs(remain: newRemain, i: i + 1, myArr: newMyArr, length: length)
            }
        }
        
        dfs(remain: Array(0..<paramLength), i: 0, myArr: [], length: paramLength)
        
        result.removeFirst()
        
        let decl = result
            .map { idxArr in
                generateFunctionParamClause(originParamClause: originParams, idxArr: idxArr)
            }
            .map { param in
                try? FunctionDeclSyntax("func \(function.name)\(param)") {
                    let str = generateFunctionCall(originParamClause: originParams)
                    return "\(function.name)(\(raw: str))"
                }
            }
            .compactMap { $0 }
            .map { DeclSyntax($0) }
        result = []
        return decl
    }
    
    
    static func generateFunctionParamClause(originParamClause: FunctionParameterClauseSyntax, idxArr: [Int]) -> FunctionParameterClauseSyntax {
        let parameters = originParamClause.parameters
        let generatedParams = idxArr.indices.map { idx in
            var p = parameters[idxArr[idx]]
            if idx == parameters.count - 1 {
                p?.trailingComma = nil
            } else {
                p?.trailingComma = .commaToken()
            }
            return FunctionParameterSyntax(p)!
        }
        let parameterList = FunctionParameterListSyntax(generatedParams)
        return FunctionParameterClauseSyntax(parameters: parameterList)
    }
    
    static func generateFunctionCall(originParamClause: FunctionParameterClauseSyntax) -> String {
        originParamClause.parameters
            .map {
                if let name = $0.secondName {
                    if $0.firstName.tokenKind == .wildcard {
                        "\(name)"
                    } else {
                        "\($0.firstName): \(name)"
                    }
                } else {
                    "\($0.firstName): \($0.firstName)"
                }
            }
            .joined(separator: ", ")
    }
}

@main
struct FactorialFuncPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        FactorialFuncMacro.self
    ]
}

extension Sequence {
    subscript(index: Int) -> Self.Iterator.Element? {
        return enumerated().first(where: {$0.offset == index})?.element
    }
}
