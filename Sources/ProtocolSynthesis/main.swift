#!/usr/bin/swift

import SwiftCLI

enum Access: String, ConvertibleFromString {
    static func val(from: String) -> Access? {
        return Access(rawValue: from)
    }
    
    case `public`
    case `private`
    case `internal`
    case `fileprivate`
}

infix operator ¬: AdditionPrecedence

func ¬(lhs: String, rhs: String) -> String {
    return "\(lhs)\n\(rhs)"
}

extension String {
    func indent(by amount: Int) -> String {
        let spaces = String(repeating: " ", count: amount)
        return split(separator: "\n").map { spaces + $0 }.joined(separator: "\n")
    }
}

struct CodeGenerator {
    var indent: Int
    var access: Access
    var type: String
    var components: [String]
    
    func gen(_ op: String) {
        
        let spaces = String(repeating: " ", count: 8)
        
        let args = components
            .map { arg in "\(arg): lhs.\(arg) \(op) rhs.\(arg)" }
            .joined(separator: ",\n\(spaces)")
        
        let code = "" +
            "\(access) static func \(op)(lhs: \(type), rhs: \(type)) -> \(type) {" ¬
            "    return \(type)(" ¬
            "        \(args)" ¬
            "    )" ¬
            "}"
        
        print(code.indent(by: indent), terminator: "\n\n")
    }
    
    func gen(mutating op: String) {
        let k = String(repeating: " ", count: 4)
        
        let args = components
            .map { arg in "lhs.\(arg) \(op) rhs.\(arg)" }
            .joined(separator: "\n\(k)")
        
        let code = "" +
            "\(access) static func \(op)(lhs: inout \(type), rhs: \(type)) {" ¬
            "    \(args)" ¬
            "}"
        
        print(code.indent(by: indent), terminator: "\n\n")
    }
    
    func gen(cmp op: String) {
        let k = String(repeating: " ", count: 11)
        
        let args = components
            .map { arg in "lhs.\(arg) \(op) rhs.\(arg)" }
            .joined(separator: " &&\n\(k)")
        
        let code = "" +
            "\(access) static func \(op)(lhs: inout \(type), rhs: \(type)) -> Bool {" ¬
            "    return \(args)" ¬
            "}"
        
        print(code.indent(by: indent), terminator: "\n\n")
    }
    
    func gen(prefix op: String) {
        let k = String(repeating: " ", count: 8)
        
        let args = components
            .map { arg in "\(arg): \(op)arg.\(arg)" }
            .joined(separator: ",\n\(k)")
        
        let code = "" +
            "\(access) static prefix func \(op)(arg: \(type)) -> \(type) {" ¬
            "    return \(type)(" ¬
            "        \(args)" ¬
            "    )" ¬
            "}"
        
        print(code.indent(by: indent), terminator: "\n\n")
    }
}

class SynthesisCommand: Command {
    let name = "operators"
    let indent = Key<Int>("-i", "--indent")
    let access = Key<Access>("-a", "--access")
    let componentType = Key<String>("-t", "--componentType")
    let emitType = Flag("--emitType")
    
    let type = Parameter()
    let components = CollectedParameter()
    
    func execute() throws {
        let indent = self.indent.value ?? 4
        let access = self.access.value ?? .public
        
        if emitType.value {
            let ctype = componentType.value ?? "Int"
            let spaces = String(repeating: " ", count: 4)
            
            let properties = components.value
                .map { arg in "var \(arg): \(ctype)\n" }
                .joined(separator: "\n\(spaces)")
            
            let code = "" +
                "\(access) struct \(type.value) {" ¬
                "    \(properties)" ¬
                "}"
            
            print(code)
        }
        
        let c = CodeGenerator(indent: indent,
                              access: access,
                              type: type.value,
                              components: components.value)
        
        print("\(access) extension \(type.value) {", terminator: "\n\n")
        
        for op in ["+", "-", "*", "/"] {
            c.gen(op)
        }
        
        c.gen(prefix: "-")
        
        for op in ["+=", "-=", "*=", "/="] {
            c.gen(mutating: op)
        }
        
        for op in ["==", "<", ">"] {
            c.gen(cmp: op)
        }
        
        print("}")
    }
}

let s = SynthesisCommand()
let cli = CLI(name: "synth")
cli.commands = [s]
cli.goAndExit()
