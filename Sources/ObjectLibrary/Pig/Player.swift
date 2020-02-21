/// Object to be created and managed in the Pig App
public final class Player {
    /// `Identifier` of a `Player` object
    public let id: Identifier
    /// The total points accumulated by a `Player` object in a single game
    public private(set) var totalPoints: Int = 0
    
    /// Computed variable that returns display text representing the `Player` object's name
    public var name: String { "Player \(id.rawValue)" }
    
    /**
     Public initializer of a `Player` object
     
     - Parameters:
        - id: The `Identifier` of the player
     */
    public init(id: Identifier) {
        self.id = id
    }
    
    /**
     Convenience method for updating the `totalPoints` property of a `Player` object
     
     - Parameters:
        - points: The number of points to be added to a `Player` object's `totalPoints`
     */
    public func updateScore(byAdding points: Int) {
        totalPoints += points
    }
    
    /// Convenience method for resetting the `totalPoints` property of a `Player` object to `0`
    public func resetTotalPoints() {
        totalPoints = 0
    }
}

public extension Player {
    /// A convenience `enum` representing a `Player` object in a game session
    enum Identifier: String, CaseIterable {
        case one = "One"
        case two = "Two"
    }
}
