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
        
        //MARK: ME Обрати внимание на такие свойства как:
        [textLabel, detailTextLabel, imageView]
//        MARK: ME убедись что ни 1 из стандартных стилей ячейки тебе не подходит
    }
    
    required init?(coder aDecoder: NSCoder) {
        //MARK: ME Вот эту штуку я обычно пихаю к приватным методам
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ME Куда делись комфортные марки разделающие привтные методы, методи жизненного цикла и пр.?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //MARK: ME Layout subviews потренеруемся писать с тобой вместе, напомнишь мне на занятии
        
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
