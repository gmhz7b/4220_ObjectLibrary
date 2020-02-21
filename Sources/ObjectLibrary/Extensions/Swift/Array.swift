public extension Array where Element == String {
    /**
     Checks whether or not a `[String]` contains a `Collection` of `String`s
     
     - Parameters:
        - elements: A list of strings to search for in a given `Collection`
     
     - Returns: A `Bool` value representing the outcome of the check
     */
    func containsAll(elements: [String]) -> Bool {
        for element in elements {
            guard contains(where: { $0.contains(element) }) else { return false }
        }
        
        return true
    }
}

extension Array where Element == String? {
    /// A convenience method for lowercasing elements in a `[String?]`
    var compactMappedAndLowercased: [String] { compactMap { $0?.lowercased() }}
}
