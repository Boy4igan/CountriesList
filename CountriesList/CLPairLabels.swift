import UIKit

class CLPairLabels: UILabel {
    let keyLabel    = UILabel()
    let valueLabel  = UILabel()
    
    let position: Position!
    var indent: CGFloat!
    var keyLabelFixedWidth: CGFloat?
    
    // MARK: Overriding properties
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        
        set {
            let (keyFrame, valueFrame) = dividedRect(rect: newValue)
            
            valueLabel.frame    = valueFrame
            keyLabel.frame      = keyFrame
            super.frame         = newValue
        }
    }
    
    // MARK: Initialization
    
    init(position: Position, indent: CGFloat) {
        self.position   = position
        self.indent     = indent
        
        super.init(frame: .zero)
    }
    
    convenience init() {
        self.init(position: .horizontal, indent: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Overriding methods
    
    override func drawText(in rect: CGRect) {
        let (keyFrame, valueFrame) = dividedRect(rect: rect)
        
        keyLabel.drawText(in: keyFrame)
        valueLabel.drawText(in: valueFrame)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let rectangels = rectangelsSize(size)
        
        if position == .horizontal {
            return CGSize(width: rectangels.keyLabelSize.width + rectangels.valueLabelSize.width + indent,
                          height: rectangels.keyLabelSize.height)
        }
        return CGSize(width: max(rectangels.keyLabelSize.width, rectangels.valueLabelSize.width),
                      height: rectangels.keyLabelSize.height + indent + rectangels.valueLabelSize.height)
    }
    
    // MARK: Calculating labels size
    
    func rectangelsSize(_ size: CGSize) -> (keyLabelSize: CGSize, valueLabelSize: CGSize) {
        if position == .horizontal {
            let (leftRectangle, rightRectangle) = splitHorizontally(size)
            let keySize                         = keyLabel.sizeThatFits(leftRectangle)
            let valueSize                       = valueLabel.sizeThatFits(rightRectangle)
            let totalHeight                     = max(keySize.height, valueSize.height)
            
            return (CGSize(width: leftRectangle.width, height: totalHeight),
                    CGSize(width: valueSize.width, height: totalHeight))
        }
        return (keyLabel.sizeThatFits(size), valueLabel.sizeThatFits(size))
    }
    
    func splitHorizontally(_ sourceSize: CGSize) -> (leftRectangle: CGSize, rightRectangle: CGSize) {
        let labelsSize          = CGSize(width: sourceSize.width - indent, height: sourceSize.height)
        let leftRictangleWidth  = keyLabelFixedWidth ?? keyLabel.sizeThatFits(labelsSize).width
        let rightRectangleWidth = labelsSize.width - leftRictangleWidth
        
        return (CGSize(width: leftRictangleWidth, height: sourceSize.height),
                CGSize(width: rightRectangleWidth, height: sourceSize.height))
    }
    
    // MARK: Frame division
    
    func dividedRect(rect: CGRect) -> (keyLabelFrame: CGRect, valueLabelFrame: CGRect) {
        var keyFrame, valueFrame, remainder: CGRect
        let (keyLabelSize, _)  = rectangelsSize(rect.size)
        
        if position == .horizontal {
            (keyFrame, remainder)   = rect.divided(atDistance: keyLabelSize.width, from: .minXEdge)
            (_, valueFrame)         = remainder.divided(atDistance: indent, from: .minYEdge)
            
            return (keyFrame, valueFrame)
        }
        
        (keyFrame, remainder)   = rect.divided(atDistance: keyLabelSize.height, from: .minYEdge)
        (_, valueFrame)         = remainder.divided(atDistance: indent, from: .minYEdge)
        
        return (keyFrame, valueFrame)
    }
    
    // MARK: Update label content
    
    func update(keyLabelText: String, valueLabelText: String) {
        keyLabel.text   = keyLabelText
        valueLabel.text = valueLabelText
    }
}

// MARK: Position of labels

extension CLPairLabels {
    enum Position {
        case horizontal
        case vertical
    }
}
