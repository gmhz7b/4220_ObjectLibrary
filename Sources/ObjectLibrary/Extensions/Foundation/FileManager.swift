import class Foundation.FileManager
import class Foundation.JSONEncoder
import class Foundation.JSONDecoder
import struct Foundation.Data
import struct Foundation.URL

/// Convenience methods for reading and writing objects in the Pokédex App
public extension FileManager {
    /**
     Writes an `Encodable` object to a specified `URL`
     
     - Parameters:
        - object: An object that conforms to the `Encodable` protcol
        - url: The location the object is to be written to
     
     - Returns: A `Bool` value representing the outcome of the write attempt
     */
    func save<T: Encodable>(object: T, to url: URL) -> Bool {
        do {
            let data = try JSONEncoder().encode(object)
            _ = try data.write(to: url, options: .atomicWrite)
            return true
        } catch {
            return false
        }
    }
    
    /**
     Reads a `Decodable` object from a specified `URL`
     
     - Parameters:
        - url: The location the object is to be read from
     
     - Returns: An object conforming to the `Decodable` protocol read from the specified `URL`.
     If the read is **NOT** successful; `nil` is returned.
     */
    func read<T: Decodable>(from url: URL) -> T? {
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            return nil
        }
    }
    
    /**
     Attempts to remove a file at the specified `URL`
     
     - Parameters:
        - url: The location the object to be removed
     
     - Returns: A `Bool` value representing the outcome of the removal attempt
     */
    func didDelete(itemAtURL url: URL) -> Bool {
        do {
            try removeItem(at: url)
            return true
        } catch {
            return false
        }
    }
    
    /**
     Returns the `URL`'s of all files located at a specified `URL` that match a given `pathExtension`
     
     - Parameters:
        - url: The location of the directory from which to fetch file `URL`s
        - type: A `String` representation of the `pathExtension` the returned file `URL`s must match
     
     - Returns: A `Collection` of `URL`s found in the directory `url` that match the specified `type`
     */
    func contentsOfDirectory(at url: URL, ofType type: String) -> [URL] {
        let contents = try? contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
        return contents.flatMap { $0.filter { $0.pathExtension == type }} ?? []
    }
    
    /**
     Returns the `URL` of a directory in an App's `UserLibrary` with a specified name
     
     - Parameters:
        - name: The name of the directory for which the returned `URL` corresponds
     
     - Returns: The `URL` of the directory. If the directory does **NOT** exist, it will be
     created and the resulting `URL` is returned
     */
    func directoryInUserLibrary(named name: String) -> URL {
        //swiftlint:disable:next force_try
        let libraryDirectoryURL = try! url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return directory(in: libraryDirectoryURL, named: name)
    }
    
    /**
     Returns the `URL` of a directory within a `baseDirectory` that matches a specified name
     
     - Parameters:
        - baseDirectory: The `URL` of the base directory to be searched
        - name: The name of the directory for which the returned `URL` corresponds
     
     - Returns: The `URL` of the directory. If the directory does **NOT** exist, it will be
     created and the resulting `URL` is returned
     */
    func directory(in baseDirectory: URL, named name: String) -> URL {
        let directoryURL = baseDirectory.appendingPathComponent(name)
        
        if !fileExists(atPath: directoryURL.path) {
            //swiftlint:disable:next force_try
            try! createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
        }
        
        return directoryURL
    }
}
