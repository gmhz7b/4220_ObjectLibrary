import struct Foundation.URL
import struct Foundation.URLComponents
import struct Foundation.URLQueryItem

/// Convenience `struct` for creating `URL`s to used in performing service calls
public struct URLProvider {
    /// Public initializer of a `URLProvider` object requires `0` parameters
    public init() {}

    /**
     Creates a `URL` based upon the specified parameters
     
     An example of **pathComponents** would be **docs** in
     
     `https://pokeapi.co/docs/`
     
     An example of **parameters** would be `["offset": "0", "limit": "964"]` in
     
     `https://pokeapi.co/api/v2/pokemon?offset=0&limit=964`

     - Parameters:
        - baseURL: The root `URL` to which `pathComponents` and `queryItems` will be added
        - pathComponents: Components to be added to the `baseURL`
        - parameters: Any `queryItems` to be added to the resulting `URL`
     
     - Returns: The resulting `URL` object after adding the `pathComponents` and `parameters` to the `baseURL`
     */
    public func url(forBaseURL baseURL: URL, pathComponents: [String], parameters: [String: String]) -> URL {
        let baseUrlWithPathComponents = url(for: baseURL, pathComponents: pathComponents)
        return url(for: baseUrlWithPathComponents, parameters: parameters) ?? baseUrlWithPathComponents
    }
}

/// Private helper methods
extension URLProvider {
    /**
     Returns a resulting `URL` from adding `queryItems` to the `url` parameter
     
     An example of **parameters** would be `["offset": "0", "limit": "964"]` in
     
     `https://pokeapi.co/api/v2/pokemon?offset=0&limit=964`
     
     - Parameters:
        - url: The root `URL` to which `queryItems` will be added
        - parameters: Any `queryItems` to be added to the resulting `URL`
     
     - Returns: The resulting `URL` object after adding the `parameters` to the `url`
     */
    private func url(for url: URL, parameters: [String: String]) -> URL? {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        return urlComponents?.url
    }
    
    /**
     Returns a resulting `URL` from adding `pathComponents` to the `url` parameter
     
     An example of **pathComponents** would be **docs** in
     
     `https://pokeapi.co/docs/`
     
     - Parameters:
        - url: The root `URL` to which `pathComponents` will be added
        - pathComponents: Components to be added to the `baseURL`
     
     - Returns: The resulting `URL` object after adding the `pathComponents` to the `url`
     */
    private func url(for url: URL, pathComponents: [String]) -> URL {
        return pathComponents.reduce(url) { result, pathComponent in
            return result.appendingPathComponent(pathComponent)
        }
    }
}
