import enum UIKit.UIKeyboardType

/// Convenience `enum` for the attributes available for a user to input in the UI
public enum InputField: String, CaseIterable {
    case firstName = "First Name"
    case lastName = "Last Name"
    
    case phone = "Phone"
    case email = "Email"
    
    case street = "Street"
    case apartment = "Apartment"
    case city = "City"
    case state = "State"
    case zipcode = "Zipcode"
    
    case emergency = "Emergency Contact"
    
    /**
     Convenience variable for the required `UIKeyboardType` of each case
     
     Does **NOT** include `UIPickerView` (See Contacts App project requirements)
     */
    public var keyboardType: UIKeyboardType {
        switch self {
        case .firstName, .lastName, .street, .city, .state, .emergency: return .default
        case .apartment: return .namePhonePad
        case .phone: return .phonePad
        case .email: return .emailAddress
        case .zipcode: return .numberPad
        }
    }
    
    /// Convenience collections for grouping various `InputField`s
    public static let nameFields: [InputField] = [.firstName, .lastName]
    public static let contactFields: [InputField] = [.phone, .email]
    public static let addressFields: [InputField] = [.street, .apartment, .city, .state, .zipcode]
    public static let groupFields: [InputField] = [.emergency]
    public static let sections: [[InputField]] = [nameFields, contactFields, addressFields, groupFields]
}
