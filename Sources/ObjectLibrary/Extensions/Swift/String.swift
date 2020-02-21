import class Foundation.NSAttributedString
import class UIKit.UIFont

/// Convenience variables for converting a `String` to a formatted `NSAttributedString`
extension String {
    var boldLabelSize: NSAttributedString { NSAttributedString(string: self, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)]) }
    var systemLabelSize: NSAttributedString { NSAttributedString(string: self, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: UIFont.labelFontSize)]) }
    var italicLabelSize: NSAttributedString { NSAttributedString(string: self, attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: UIFont.labelFontSize)]) }
}

public extension String {
    /// Returns the `String` with its first `Character` uppercased
    var firstLetterUppercased: String { "\(first?.uppercased() ?? "")\(dropFirst())" }
    
    /**
     Checks whether or not a `String` contains a `Collection` of `String`s
     
     - Parameters:
        - elements: A list of strings to search for in a given `String`
     
     - Returns: A `Bool` value representing the outcome of the check
     */
    func contains(elements: [String]) -> Bool {
        for element in elements {
            guard contains(element) else { return false }
        }
        
        return true
    }
}
