import typealias Foundation.TimeInterval

/// Convenience `typealias` for managing a change to the `Die` image displayed in the Pig App
public typealias DieChange = (die: Die, duration: TimeInterval)

public struct Roll {
    /// The duration of time taken to transition the `Die` image from one face to another
    public let totalDuration: TimeInterval
    /// A `Collection` of `DieChange`s to be performed in a single `Roll`
    public let dieChanges: [DieChange]
    
    /**
     Public initializer of a `Roll` object
     
     - Parameters:
        - totalDuration: The total amount of time the `Roll` will take
        - dieChanges: The `Collection` of `DieChange`s to be performed when executing the `Roll`
     */
    public init(totalDuration: TimeInterval, dieChanges: [DieChange]) {
        self.totalDuration = totalDuration
        self.dieChanges = dieChanges
    }
}
