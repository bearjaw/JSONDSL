import Cocoa

import Cocoa
import Foundation

enum JSONObject {
    indirect case json([JSONObject])
    indirect case object(String, [JSONObject])
    indirect case array(String, [JSONObject])
    case string(String, String)
    case integer(String, Int)
    case decimal(String, Double)
    case date(String, Date)
    case bool(String, Bool)
}

func json(_ value: [JSONObject]) -> JSONObject {
    return .json(value)
}

func object(_ key: String, _ value: [JSONObject]) -> JSONObject {
    return .object(key, value)
}

func string(_ key: String, _ value: String) -> JSONObject {
    return .string(key, value)
}

func integer(_ key: String, _ value: Int) -> JSONObject {
    return .integer(key, value)
}

func decimal(_ key: String, _ value: Double) -> JSONObject {
    return .decimal(key, value)
}

func date(_ key: String, _ value: Date) -> JSONObject {
    return .date(key, value)
}

func array(_ key: String, _ value: [JSONObject]) -> JSONObject {
    return .array(key, value)
}

func bool(_ key: String, _ value: Bool) -> JSONObject {
    return .bool(key, value)
}

let doc = json([
    .string("name", "Doc"),
    .integer("dogCount", 1)
])

let marty = json([
    .string("name", "Marty"),
    .integer("dogCount", 0)
])

let jsonString = render(
    json([
        string("model", "Dolorian"),
        bool("isNew", true),
        integer("seats", 2),
        array("owners", [
            doc,
            marty
        ])
    ])
)

print(jsonString)
//
//print(
//    json([
//        string("model", "Dolorian"),
//        integer("seats", 2),
//        bool("isNew", true),
//        array("owners", [
//            doc,
//            marty
//        ])
//    ])
//)

func join(_ value: String, _ separaror: String) -> String {
    value + separaror
}

func quotes(_ string: String) -> String {
    #" ""# + string + #"" "#
}

func render(_ json: JSONObject) -> String {
    switch json {
    case let .json(objects):
        let formattedObjects = objects
            .map { join(render($0), ",") }.reduce(into: "", { $0 = $0 + $1 }).dropLast()
        return "{ \(formattedObjects) }"
    case let .object(key, objects):
        let value = objects.map { join(render($0), ",") }.reduce(into: "", { $0 = $0 + $1 }).dropLast()
        return quotes(key) + "{" + value + "}"
    case let .array(key, objects):
        let value = objects.map { join(render($0), ",") }.reduce(into: "", { $0 = $0 + $1 }).dropLast()
        print(value)
        return quotes(key) + ":" + "[" + value + "]"
    case let .string(key, value):
         return quotes(key) + ":" + quotes(value)
    case let .integer(key, value):
         return quotes(key) + ":" + "\(value)"
    case let .decimal(key, value):
         return quotes(key) + ":" + "\(value)"
    case let .date(key, value):
        return quotes(key) + ":" + "\(value)"
    case let .bool(key, value):
        return quotes(key) + ":" + "\(value)"
    }

}
