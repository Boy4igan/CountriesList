import UIKit

//MARK: Любая сущность, что содержит в себе экземпляры UIView (или его наследников), дожна сам являться UIView (или его наследником)
//Исключение UIViewController и его наследники. 
struct CLPairLabels {
    let keyLabel    = UILabel()
    let valueLabel  = UILabel()
    let indent: CGFloat
    let position: Position
    
    var frame: CGRect {
        get {
            var size: CGSize
            
            if (self.position == .horizontal) {
                let totalWidth  = keyLabel.frame.size.width + indent + valueLabel.frame.size.width
                let totalHeight = max(keyLabel.frame.size.height, valueLabel.frame.size.height)
                
                size = CGSize(width: totalWidth, height: totalHeight)
            } else {
                let totalWidth  = max(keyLabel.frame.size.width, valueLabel.frame.size.width)
                let totalHeight = keyLabel.frame.size.height + indent + valueLabel.frame.size.height
                
                size = CGSize(width: totalWidth, height: totalHeight)
            }
            
            return CGRect(origin: keyLabel.frame.origin, size: size)
        }
        
        set {
            var keyLabelFrame, valueLabelFrame, remainder : CGRect
            let keySize     = keyLabel.sizeThatFits(newValue.size)
            let valueSize   = valueLabel.sizeThatFits(newValue.size)
            
            if position == .horizontal {
                (keyLabelFrame, remainder) = newValue.divided(atDistance: keySize.width,
                                                              from: CGRectEdge.minXEdge)
                (valueLabelFrame, _)  = remainder.divided(atDistance: valueSize.width,
                                                          from: CGRectEdge.minXEdge)
                valueLabelFrame = valueLabelFrame.offsetBy(dx: indent, dy: 0)
            } else {
                (keyLabelFrame, remainder) = newValue.divided(atDistance: keySize.height, from: CGRectEdge.minYEdge)
                (valueLabelFrame, _) = remainder.divided(atDistance: valueSize.height,
                                                         from: CGRectEdge.minYEdge)
                
                valueLabelFrame = valueLabelFrame.offsetBy(dx: 0, dy: indent)
            }
            
            keyLabel.frame      = keyLabelFrame
            valueLabel.frame    = valueLabelFrame
        }
    }
    
    //MARK: Initialization
    
    init() {
        self.init(key: "key not assigned", vaue: "value not assigned", indent: 0, position: .horizontal)
    }
    
    init(key: String, value: String, indent: CGFloat) {
        self.init(key: key, vaue: value, indent: indent, position: .horizontal)
    }
    
    init(key: String, vaue: String, indent: CGFloat, position: Position) {
        keyLabel.text   = key
        valueLabel.text = vaue
        self.indent     = indent
        self.position   = position
        
        keyLabel.font   = UIFont.boldSystemFont(ofSize: keyLabel.font.pointSize)
        
        if position == .vertical {
            valueLabel.numberOfLines = 0
            valueLabel.lineBreakMode = .byWordWrapping
        }
    }
    
    // MARK: Public methods
    
    func update(keyLabelText: String, valueLabelText: String) {
        keyLabel.text   = keyLabelText
        valueLabel.text = valueLabelText
    }
    
    func sizeThatFits(_ size: CGSize) -> CGSize {
        let keySize     = keyLabel.sizeThatFits(size)
        let valueSize   = valueLabel.sizeThatFits(size)
        
        if (self.position == .horizontal) {
            return CGSize(width: keySize.width + valueSize.width + indent,
                          height: max(keySize.height, valueSize.height))
        }
        return CGSize(width: max(keySize.width, valueSize.width),
                      height: keySize.height + valueSize.height + indent)
    }
}

//MARK: Declaration of nested enum - Position

extension CLPairLabels {
    enum Position {
        case vertical
        case horizontal
    }
}
