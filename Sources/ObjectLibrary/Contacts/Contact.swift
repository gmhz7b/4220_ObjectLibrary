import struct Foundation.UUID
import struct Foundation.NSRange
import class Foundation.NSString
import class Foundation.NSAttributedString
import class Foundation.NSMutableAttributedString

/// Object to be created and managed in the Contacts App
public final class Contact {
    /// `static` convenience attribute for instantiating an empty `Contact`
    public static func instance() -> Contact {
        Contact(id: UUID(), firstName: nil, lastName: nil, address: nil, phone: nil, email: nil, isEmergencyContact: false)
    }
    
    /// Object's unique identifier
    public let id: UUID
    
    private let firstName: String?
    private let lastName: String?
    private let address: Address?
    private let phone: String?
    private let email: String?
    
    public let isEmergencyContact: Bool
    
    /// Used by the UISearchbar on the ContactsList page
    public let searchableStrings: [String]
    /// Used by the UITableView on the ContactsList page
    public let attributedDisplayText: NSAttributedString
    /// Used for sorting the data-set the `ContactsListModel`.
    @objc public let collationString: String
    
    /// Convenience attribute for validation
    public let isEmpty: Bool
    
    private init(id: UUID, firstName: String?, lastName: String?, address: Address?, phone: String?, email: String?, isEmergencyContact: Bool) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.phone = phone
        self.email = email
        self.isEmergencyContact = isEmergencyContact
        
        isEmpty = firstName == nil && lastName == nil && address == nil && phone == nil && email == nil
        
        /**
         `isEmergencyContact` must be preserved
         
         However; the remaining attributes of the object cannot be parsed if the rest of the object is "empty"
         */
        guard !isEmpty else { searchableStrings = []; attributedDisplayText = .emptyString; collationString = ""; return }
        
        searchableStrings = [firstName, lastName, phone, email].compactMappedAndLowercased + (address?.searchableStrings ?? [])
        
        let firstNameLastName = firstName.flatMap({ "\($0) \(lastName ?? "")" })
        let lastNameFirstName = lastName.flatMap { "\($0)\(firstName ?? "")" }
        let defaultDisplayText = "No Name"
        let displayText: String = firstNameLastName ?? lastName ?? phone ?? email ?? defaultDisplayText
        
        guard displayText != defaultDisplayText else {
            attributedDisplayText = defaultDisplayText.italicLabelSize
            collationString = lastNameFirstName ?? ""
            return
        }
        
        let boldText = lastName ?? displayText
        let range: NSRange = NSString(string: displayText).range(of: boldText)
        let attributedDisplayText: NSMutableAttributedString = NSMutableAttributedString(attributedString: displayText.systemLabelSize)
        attributedDisplayText.replaceCharacters(in: range, with: boldText.boldLabelSize)
        
        self.attributedDisplayText = attributedDisplayText
        collationString = lastNameFirstName ?? displayText
    }
    
    /**
     Convenience method for accessing attributes of a `Contact`
     
     - Parameters:
        - inputField: An `enum` representing the field to which the returned value corresponds
     
     - Returns: A `String?` representation of the stored value for the specified field
     */
    public func value(for inputField: InputField) -> String? {
        switch inputField {
        case .firstName: return firstName
        case .lastName: return lastName
        case .phone: return phone
        case .email: return email
        case .street: return address?.street
        case .apartment: return address?.apartment
        case .city: return address?.city
        case .state: return address?.state?.rawValue
        case .zipcode: return address?.zipcode
        case .emergency: return isEmergencyContact.description
        }
    }
    
    /**
     Copies a `Contact` with a new value for a specified attribute
     
     - Parameters:
        - value: The new/updated input to be included in the object returned
        - inputField: An `enum` representing the field to which the new/updated value corresponds
     
     - Returns: A copy of the `Contact` object on which this function is called with a new/updated
    value for the specified attribute
     */
    public func copy(withNewValue value: String, for inputField: InputField) -> Contact {
        let value = value.isEmpty ? nil : value
        
        let street = inputField == .street ? value : address?.street
        let apartment = inputField == .apartment ? value : address?.apartment
        let city = inputField == .city ? value : address?.city
        let state = inputField == .state ? State(rawValue: value ?? "") : address?.state
        let zipcode = inputField == .zipcode ? value : address?.zipcode
        let address = Address(street: street, apartment: apartment, city: city, state: state, zipcode: zipcode)
        
        return Contact(
            id: self.id,
            firstName: inputField == .firstName ? value : self.firstName,
            lastName: inputField == .lastName ? value : self.lastName,
            address: address,
            phone: inputField == .phone ? value : self.phone,
            email: inputField == .email ? value : self.email,
            isEmergencyContact: inputField == .emergency
                ? Bool(value?.description ?? "") ?? self.isEmergencyContact
                : self.isEmergencyContact
        )
    }
}
