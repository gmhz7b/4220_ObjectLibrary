import class Foundation.NSCoder
import class UIKit.UIButton
import class UIKit.UITouch
import class UIKit.UIEvent
import struct CoreGraphics.CGSize
import struct CoreGraphics.CGFloat
import class QuartzCore.CABasicAnimation

/// Stylized `UIButton` modeled after Android's `FloatingActionButton` component
public final class RoundButton: UIButton {
    /// `@IBInspectable` for setting the button's `layer.cornerRadius` property
    @IBInspectable public var cornerRadiusFactor: CGFloat = 0.25 { didSet { updateCornerRadius() }}
    
    /// May only be implemented in `InterfaceBuilder`
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: -1.0, height: 1.0)
        layer.masksToBounds = false
        imageView?.contentMode = .scaleAspectFit
        updateCornerRadius()
    }
    
    /// Touch overrides for emulating `UIButton.system` behavior
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        layer.shadowOpacity = 0.0
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        updateShadowOpacity(show: titleLabel?.alpha == 1.0)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        updateShadowOpacity(show: true)
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        updateShadowOpacity(show: true)
    }
}

extension RoundButton {
    /// Updates the `cornerRadius` attribute of the layer by a `cornerRadiusFactor`
    private func updateCornerRadius() {
        layer.cornerRadius = cornerRadiusFactor * bounds.height
    }
    
    /**
     Updates the `shadowOpacity` of `layer` using a `CABasicAnimation`
     
     - Parameters:
        - show: A `Bool` value indicating whether or not to show the layer's shadow
     */
    private func updateShadowOpacity(show: Bool) {
        let shadowOpacity: Float = show ? 0.4 : 0.0
        
        guard layer.shadowOpacity != shadowOpacity else { return }
        
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "shadowOpacity")
        animation.fromValue = layer.shadowOpacity
        animation.toValue = shadowOpacity
        animation.duration = 0.35
        layer.add(animation, forKey: "shadowOpacity")
        layer.shadowOpacity = shadowOpacity
    }
}
