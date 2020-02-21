import struct Foundation.URL

/**
Convenience `typealias` representing a `Result` type

A `success` case will return a `Pokédex`

A `failure` case will return a `ServiceCallError`
*/
public typealias PokédexResult = Result<Pokédex, ServiceCallError>

/// Object to be created and managed in the Pokédex App
public struct Pokédex: Codable {
    /// A list of `Pokémon` available for download from `PokéAPI`
    public let entries: [Entry]
    
    private enum CodingKeys: String, CodingKey {
        case entries = "results"
    }
}

public extension Pokédex {
    /// A convenience class for parsing and utilizing data return from `PokéAPI`
    final class Entry: Codable {
        /// The name of `Pokémon`/ list item retrieved from `PokéAPI`
        @objc public let name: String
        /// The web `URL` necessary to retrieve more data on the given `Pokémon`
        public let url: URL
        
        /// Convenience computed var for displaying the list item in a `UITableView`
        public var displayText: String { name.split(separator: "-").map { String($0).firstLetterUppercased }.joined(separator: "-") }
    }
}
