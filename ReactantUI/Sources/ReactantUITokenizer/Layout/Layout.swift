import Foundation
import SWXMLHash

public struct Layout: XMLIndexerDeserializable {
    public let id: String?
    public let constraints: [Constraint]

    public static func deserialize(_ node: XMLIndexer) throws -> Layout {
        if node["layout"].element != nil {
            return try deserializeNodeLayout(node["layout"])
        } else {
            return try deserializeAttributeLayout(node)
        }
    }

    private static func deserializeNodeLayout(_ node: XMLIndexer) throws -> Layout {
        return Layout(id:
            node.value(ofAttribute: "id"),
                      constraints: [])
    }

    private static func deserializeAttributeLayout(_ node: XMLIndexer) throws -> Layout {
        let layoutAttributes = node.element?.allAttributes
            .filter { $0.key.hasPrefix("layout:") && $0.key != "layout:id" }
            .map { ($0.replacingOccurrences(of: "layout:", with: ""), $1) }

        return try Layout(
            id: node.value(ofAttribute: "layout:id"),
            constraints: layoutAttributes?.flatMap(Constraint.constraints) ?? [])
    }
}
