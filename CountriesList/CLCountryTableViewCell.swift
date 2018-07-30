import UIKit

class CLCountryTableViewCell: UITableViewCell {
    
    let countryLabel    = UILabel()
    let capitalLabel    = UILabel()
    let flagImageView   = UIImageView(frame: CGRect.zero)
    let indentBetweenElements: CGFloat = 7
    
    init(reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        
        flagImageView.contentMode           = .scaleAspectFit
        flagImageView.clipsToBounds         = true
        flagImageView.layer.cornerRadius    = 10
        
        countryLabel.font           = UIFont.boldSystemFont(ofSize: countryLabel.font.pointSize)
        
        capitalLabel.textAlignment  = .right
        capitalLabel.textColor      = UIColor.darkGray
        
        addSubview(countryLabel)
        addSubview(capitalLabel)
        addSubview(flagImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let (flagFrame, unusedFrame) = getflagFrame()
        let (lhFrame, rhFrame) = unusedFrame.divided(atDistance: unusedFrame.size.width / 2, from: CGRectEdge.minXEdge)
        
        flagImageView.frame = flagFrame
        countryLabel.frame  = lhFrame.insetBy(dx: indentBetweenElements, dy: 0)
        capitalLabel.frame  = rhFrame
    }
    
    func getflagFrame() -> (flagFrame: CGRect, unusedFrame: CGRect) {
        let subviewsFrame               = self.bounds
        let flagFrameConstraint         = subviewsFrame.insetBy(dx: indentBetweenElements,
                                                                dy: indentBetweenElements)
        let flagSize                    = fit(imageView: flagImageView, to: flagFrameConstraint.size)
        let (flagFrame, unusedFrame)    = flagFrameConstraint.divided(atDistance: flagSize.width,
                                                                      from: CGRectEdge.minXEdge)
        
        return (flagFrame, unusedFrame)
    }
    
    func fit(imageView: UIImageView, to cellSize: CGSize) -> CGSize {
        let imgSize             = imageView.image!.size
        let heightConstraint    = cellSize.height
        let ratio               = imgSize.height / heightConstraint
        let newWidth            = imgSize.width / ratio
        
        return CGSize(width: newWidth, height: heightConstraint)
    }
}
