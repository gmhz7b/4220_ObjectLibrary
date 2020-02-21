/// Nested Object utilized by a `Contact`
struct Address {
    let street: String?
    let apartment: String?
    let city: String?
    let state: State?
    let zipcode: String?
    
    /// Property used by the UISearchbar on the ContactsList page in conjunction with the parent `Contact`'s `searchableStrings`
    let searchableStrings: [String]
    
    /// Failable `init` used for validation purposes in the event empty attributes are supplied
    init?(street: String?, apartment: String?, city: String?, state: State?, zipcode: String?) {
        let isEmpty: Bool = street == nil && apartment == nil && city == nil && state == nil && zipcode == nil
        
        guard !isEmpty else { return nil }
        
        self.street = street
        self.apartment = apartment
        self.city = city
        self.state = state
        self.zipcode = zipcode
        
        searchableStrings = [street, apartment, city, state?.rawValue, state?.postalAbbreviation, zipcode].compactMappedAndLowercased
    }
}
