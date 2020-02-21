import struct Foundation.URL
import class Foundation.FileManager

/// Example persistence layer for storing data retrieved from `PokéAPI` detailing `Pokémon` available for download
public final class PokédexPersistence: FileStoragePersistence {
    private let identifier = "Pokédex"
    
    /// The `URL` of the Directory utilized by the persistence layer for reading/writing
    public let directoryURL: URL
    /// The `pathExtension` of the files the persistence layer will read/write
    public let fileType: String = "json"
    
    /// Convenience computed variable that returns a stored `Pokédex` object if one exists
    public var pokédex: Pokédex? { files.first.flatMap { read(url: $0) }}
    
    /**
     Public initializer of a `PokédexPersistence` object
     
     - Parameters:
        - directoryName: The name of the Directory utilized by the persistence layer for reading/writing
     */
    public init(directoryName: String) {
        self.directoryURL = FileManager.default.directoryInUserLibrary(named: directoryName)
    }
    
    /**
     Writes an `Pokédex` object to the persistence layer's `directoryURL`
     
     - Parameters:
        - pokédex: The `Pokédex` object to be saved
     */
    public func save(_ pokédex: Pokédex) {
        save(pokédex, withId: identifier)
    }
}
