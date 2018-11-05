import UIKit

class CLScrollView: UIView {
    let contentView = CLContentView()
    let scrollView = UIScrollView()
    let contentViewInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    
    init() {
        super.init(frame: .zero)

        backgroundColor = .white

        scrollView.addSubview(contentView)
        addSubview(scrollView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func safeAreaInsetsDidChange() {
        print("...")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame    = bounds
        
        let frame           = scrollView.bounds.inset(by: safeAreaInsets).inset(by: contentViewInset)
        let contentSize     = contentView.sizeThatFits(frame.size)

        contentView.frame       = CGRect(origin: frame.origin, size: contentSize)
        scrollView.contentSize  = contentSize
    }
}
