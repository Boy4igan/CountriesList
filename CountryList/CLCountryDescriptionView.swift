import UIKit

class CLCountryDescriptionView: UIView {
    let titleLabel       = UILabel()
    let descriptionLabel = UILabel()
    
    var subviewsFrame: CGRect {
        return bounds
    }
    
    init() {
        super.init(frame: .zero)
        
        addSubview(titleLabel)
        addSubview(descriptionLabel)

        descriptionLabel.numberOfLines = 0
        titleLabel.font                = UIFont.boldSystemFont(ofSize: titleLabel.font.pointSize)
        titleLabel.text                = "Description"
    }
    
    //MARK: Override methods
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let (titleSize, descriptionSize) = labelsSize(size)
        
        return CGSize(width: max(titleSize.width, descriptionSize.width),
                      height: titleSize.height + descriptionSize.height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let titleFrame, descriptionFrame: CGRect
        var frame                        = subviewsFrame
        let (titleSize, descriptionSize) = labelsSize(frame.size)

        (titleFrame, frame)   = frame.divided(atDistance: titleSize.height, from: .minYEdge)
        (descriptionFrame, _) = frame.divided(atDistance: descriptionSize.height, from: .minYEdge)

        titleLabel.frame       = titleFrame
        descriptionLabel.frame = descriptionFrame
    }
    
    //MARK: Private methods
    
    private func labelsSize(_ size: CGSize) -> (titleSize: CGSize, descriptionSize: CGSize) {
        let titleSize       = titleLabel.sizeThatFits(size)
        let descriptionSize = descriptionLabel.sizeThatFits(size)
        
        return (titleSize, descriptionSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
