import struct Foundation.URL

/// Object to be created and managed in the Pokédex App
public struct ServicePokémon: Decodable {
    /// Attributes returned from service, necessary to create a `Pokédex` object
    let id: Int
    let name: String
    let height: Int
    let types: [String]
    /// `URL` containing the `sprite` `Data` required to create a `Pokémon` object
    public let spriteUrl: URL
    
    private enum CodingKeys: String, CodingKey {
        case id, name, types, height
        case spriteUrl = "sprites"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        height = try container.decode(Int.self, forKey: .height)
        
        let types = try container.decode([Type].self, forKey: .types)
        self.types = types.map { $0.name }

        let sprite = try container.decode(Sprite.self, forKey: .spriteUrl)
        spriteUrl = sprite.url
    }
}

extension ServicePokémon {
    /// Convenience `struct` used to decode data retrieved from service
    struct `Type` {
        let name: String
    }
}

/// Decoding logic for `ServicePokémon.Type`
extension ServicePokémon.`Type`: Decodable {
    private enum CodingKeys: String, CodingKey {
        case type, name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self).nestedContainer(keyedBy: CodingKeys.self, forKey: .type)
        name = try container.decode(String.self, forKey: .name)
    }
}

extension ServicePokémon {
    /// Convenience `struct` used to decode data retrieved from service
    struct Sprite {
        let url: URL
    }
}

/// Decoding logic for `ServicePokémon.Sprite`
extension ServicePokémon.Sprite: Decodable {
    private enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decode(URL.self, forKey: .frontDefault)
    }
}
