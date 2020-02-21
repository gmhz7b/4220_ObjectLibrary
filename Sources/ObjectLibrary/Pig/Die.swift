/// A convenience `enum` representing a 6-faced Die
public enum Die: String, CaseIterable {
    case one, two, three, four, five, six
    
    /// Computed variable that returns the `Int` value of the specified `Die` case
    public var value: Int { Die.allCases.firstIndex(of: self)! + 1 }
}
