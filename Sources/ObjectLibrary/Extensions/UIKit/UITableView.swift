import class UIKit.UITableView
import class UIKit.UILabel

/// Convenience methods for adding/removing a visual indicator in the event of an empty list.
public extension UITableView {
    /**
     Adds a `UILabel` as a `backgroundView`
     
     - Parameters:
        - text: The text of the `UILabel` to be added
        - adjustSeparatorStyle: A flag indicating whether or not to adjust the `UITableView`'s `separatorStyle`.
            If true, the `separatorStyle` will be set to `.none`.
     */
    func addEmptyListLabel(withText text: String, adjustSeparatorStyle: Bool = false) {
        let label = UILabel(frame: bounds)
        label.text = text
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = label.font.withSize(28.0)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        backgroundView = label
        
        if adjustSeparatorStyle {
           separatorStyle = .none
        }
    }
    
    /**
     Sets a `UITableView`'s `backgroundView` to `nil`
     
     - Parameters:
        - adjustSeparatorStyle: A flag indicating whether or not to adjust the `UITableView`'s `separatorStyle`.
            If true, the `separatorStyle` will be set to `.singleLine`.
     */
    func removeEmptyListLabel(adjustSeparatorStyle: Bool = false) {
        backgroundView = nil
        if adjustSeparatorStyle {
           separatorStyle = .singleLine
        }
    }
}
