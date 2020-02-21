import struct Foundation.Data
import class UIKit.UIImage

/**
Convenience `typealias` representing a `Result` type

A `success` case will return a `Pokémon`

A `failure` case will return a `ServiceCallError`
*/
public typealias PokémonResult = Result<Pokémon, ServiceCallError>

/// Object to be created and managed in the Pokédex App
public struct Pokémon: Codable {
    /// Unique identifier of a `Pokémon` retrieved from `PokéAPI`
    let id: Int
    /**
     The name of a `Pokémon` retrieved from `PokéAPI`
     
     Use this property when saving a `Pokémon` object to a file
     */
    public let name: String
    /// The height of a `Pokémon` retrieved from `PokéAPI`
    public let height: Int
    /// The types of a `Pokémon` retrieved from `PokéAPI`, ex: `["Rock", "Fighting"]`
    let types: [String]
    /// Binary data representing the `Pokémon` image
    let sprite: Data
    
    /// Convenience computed variable for formatting and displaying the `name` of a `Pokémon`
    public var displayName: String { name.split(separator: "-").map { String($0).firstLetterUppercased }.joined(separator: "-") }
    /// Convenience computed variable for formatting and displaying the `types` of a `Pokémon`
    public var displayTypes: String { types.map { $0.firstLetterUppercased }.joined(separator: ", ") }
    /// Convenience computed variable for converting a `Pokémon`s `sprite` `Data` to a `UIImage`
    public var image: UIImage { UIImage(data: sprite)! }
}

public extension Pokémon {
    /**
     Public initializer of a `Pokémon` object
     
     - Requires: A `ServicePokémon` and `sprite` `Data` retrieved from `PokéAPI`
     
     - Parameters:
        - servicePokémon: Retrieved from `PokéAPI`, used to set properties on the `Pokémon` object
        - sprite: Retrieved from `PokéAPI`, used to create a `UIImage` representation of the `Pokémon` object
     */
    init(servicePokémon: ServicePokémon, sprite: Data) {
        id = servicePokémon.id
        name = servicePokémon.name
        height = servicePokémon.height
        types = servicePokémon.types
        self.sprite = sprite
    }
}
