

import UIKit

class MySlider: UISlider {
    
    required init(coder: NSCoder) {
        super.init(coder:coder)
        
        let t = UITapGestureRecognizer(target: self, action: "tapped:")
        self.addGestureRecognizer(t)
        
        //    self.superview.tintColor = UIColor.redColor()
        //    self.minimumTrackTintColor = UIColor.yellowColor()
        //    self.maximumTrackTintColor = UIColor.greenColor()
        //    self.thumbTintColor = UIColor.orangeColor()
        
        self.setThumbImage(UIImage(named:"moneybag1.png")!, forState: .Normal)
        let coinEnd = UIImage(named:"coin2.png")!.resizableImageWithCapInsets(
            UIEdgeInsetsMake(0,7,0,7), resizingMode: .Stretch)
        self.setMinimumTrackImage(coinEnd, forState: .Normal)
        self.setMaximumTrackImage(coinEnd, forState: .Normal)
        
        // self.bounds.size.height += 30
    }
    
    override func intrinsicContentSize() -> CGSize {
        var sz = super.intrinsicContentSize()
        sz.height += 30
        return sz
    }
    
    func tapped(g:UIGestureRecognizer) {
        let s = g.view as UISlider
        if s.highlighted {
            return // tap on thumb, let slider deal with it
        }
        let pt = g.locationInView(s)
        let track = s.trackRectForBounds(s.bounds)
        if !CGRectContainsPoint(CGRectInset(track, 0, -10), pt) {
            return // not on track, forget it
        }
        let percentage = Float(pt.x / s.bounds.size.width)
        let delta = percentage * (s.maximumValue - s.minimumValue)
        let value = s.minimumValue + delta
        s.setValue(value, animated:true) // animation broken in iOS 7, still broken in iOS 8
    }
    
    override func maximumValueImageRectForBounds(bounds: CGRect) -> CGRect {
        return super.maximumValueImageRectForBounds(bounds).rectByOffsetting(dx: 31, dy: 0)
    }
    
    override func minimumValueImageRectForBounds(bounds: CGRect) -> CGRect {
        return super.minimumValueImageRectForBounds(bounds).rectByOffsetting(dx: -31, dy: 0)
    }
    
    override func trackRectForBounds(bounds: CGRect) -> CGRect {
        var result = super.trackRectForBounds(bounds)
        result.origin.x = 0
        result.size.width = bounds.size.width
        return result
    }

    override func thumbRectForBounds(bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
        return super.thumbRectForBounds(
            bounds, trackRect: rect, value: value)
            .rectByOffsetting(dx: 0, dy: -7)
    }

}
