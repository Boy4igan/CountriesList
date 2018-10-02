import UIKit

class CLScrollView: UIScrollView {
    let contentView = CLContentView()
    
    var subviewsFrame : CGRect {
        return frame.inset(by: safeAreaInsets)
    }
    
    init() {
        super.init(frame: .zero)
        
        addSubview(contentView)
        backgroundColor                = .white
        contentInsetAdjustmentBehavior = .never
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let frame          = subviewsFrame
        let frameSize      = contentView.sizeThatFits(frame.size)
        let newContentSize = CGSize(width: frameSize.width + safeAreaInsets.left + safeAreaInsets.right,
                                    height: frameSize.height + safeAreaInsets.top + safeAreaInsets.bottom)
        
        contentView.frame = CGRect(origin: frame.origin, size: frameSize)
        contentSize       = newContentSize
    }
    
    
}
