import class Foundation.FileManager
import struct Foundation.URL

/// Protocol containing convenience methods for interfacing with `Foundation.FileManager`
public protocol FileStoragePersistence {
    /// The directory used by the persistence layer
    var directoryURL: URL { get }
    /// The `pathExtension` of the files handled by the persistence layer
    var fileType: String { get }
}

public extension FileStoragePersistence {
    /// The files contained within the persistence layer's `directoryURL` matching the persistence layer's `fileType`
    var files: [URL] { return FileManager.default.contentsOfDirectory(at: directoryURL, ofType: fileType) }
    
    /**
     Attempts to remove a file with a specified `id`
     
     - Parameters:
        - id: The identifier (name) of the file to be removed
     
     - Returns: A `Bool` value representing the outcome of the removal attempt
     */
    @discardableResult
    func remove(fileWithId id: String) -> Bool {
        let url = fileURL(withId: id)
        return fileManager.didDelete(itemAtURL: url)
    }
    
    /**
     Writes an `Encodable` object to the persistence layer's `directoryURL` with a specified `id`
     
     - Parameters:
        - object: An object that conforms to the `Encodable` protcol
        - id: The identifier (name) of the file to be updated/created
     
     - Returns: A `Bool` value representing the outcome of the write attempt
     */
    @discardableResult
    func save<T: Encodable>(_ object: T, withId id: String) -> Bool {
        let url = fileURL(withId: id)
        return fileManager.save(object: object, to: url)
    }
    
    /**
     Reads a `Decodable` object from a specified `URL`
     
     - Parameters:
        - url: The location the object is to be read from
     
     - Returns: An object conforming to the `Decodable` protocol read from the specified `URL`.
     If the read is **NOT** successful; `nil` is returned.
     */
    func read<T: Decodable>(url: URL) -> T? {
        return fileManager.read(from: url)
    }
    
    /**
     Returns the name of a file at a specified `URL`
     
     - Parameters:
        - url: The location the ofile
     
     - Returns: A `String` representation of the file
     */
    func fileName(of url: URL) -> String {
        return url.deletingPathExtension().lastPathComponent
    }
}

/// Private helper methods
extension FileStoragePersistence {
    /// Wrapper around the default `Foundation.FileManager` configuration
    fileprivate var fileManager: FileManager { FileManager.default }
    
    /**
     Returns the name of a file at a specified `URL`
     
     - Parameters:
        - url: The location the ofile
     
     - Returns: A `String` representation of the file
     */
    private func fileURL(withId id: String) -> URL {
        return directoryURL.appendingPathComponent(id).appendingPathExtension(fileType)
    }
}
