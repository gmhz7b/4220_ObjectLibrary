import class UIKit.UIViewController
import class UIKit.UIAlertController
import class UIKit.UIAlertAction

public extension UIViewController {
    /**
     A convenience method for displaying a single-action `UIAlert`
     
     - Parameters:
        - alerTitle: The title of the alert. Should be short and sweet.
        - message: The body of the alert. Supply an empty `String` if only a title is necessary
        - actionTitle: The text of the button displayed with the alert
        - completion: Closure called once the user taps the alert's action button
     
     The `completion` argument illustrated below is an instance of a closure (block of code that can be called later).
     A closure is said to escape a function when the closure is passed as an argument to the function, but is called
     after the function returns. When you declare a function that takes a closure as one of its parameters; you can
     write `@escaping` before the parameter’s type to indicate that the closure is allowed to escape.
     
     A trailing closure is written after the function call’s parentheses, even though it is still an argument to the
     function. When you use the trailing closure syntax; you don’t write the argument label for the closure as part
     of the function call.
     
     ```
     func someFunctionThatTakesAClosure(closure: () -> Void) {
         // function body goes here
     }

     // Here's how you call this function without using a trailing closure:

     someFunctionThatTakesAClosure(closure: {
         // closure's body goes here
     })

     // Here's how you call this function with a trailing closure instead:

     someFunctionThatTakesAClosure() {
         // trailing closure's body goes here
     }
     ```
     */
    func presentSingleActionAlert(alerTitle: String, message: String, actionTitle: String, completion: @escaping () -> ()) {
        let alert = UIAlertController(title: alerTitle, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: actionTitle, style: .default) { _ in completion() }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
