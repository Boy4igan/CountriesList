import UIKit

class CLContentView: UIView {
    let flagImageView          = UIImageView()
    let countryPropertiesView  = CLCountryPropertiesView()
    let countryDescriptionView = CLCountryDescriptionView()
    let spasing: CGFloat       = 20
    
    var subviewsFrame: CGRect {
        return bounds
    }
    
    init() {
        super.init(frame: .zero)
        
        addSubview(flagImageView)
        addSubview(countryPropertiesView)
        addSubview(countryDescriptionView)

        flagImageView.layer.cornerRadius = 8
        flagImageView.clipsToBounds      = true
        flagImageView.layer.borderWidth  = 1.0
        flagImageView.layer.borderColor  = UIColor.black.cgColor
    }
    
    //MARK: Override methods
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let (flagSize, propertiesSize, descriptionSize) = subviewsSize(size)
        
        return CGSize(width: max(flagSize.width, propertiesSize.width, descriptionSize.width),
                      height: flagSize.height + propertiesSize.height + descriptionSize.height + spasing * 2)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let flagFrame, propertiesFrame, descriptionFrame: CGRect
        var frame                                       = subviewsFrame
        let (flagSize, propertiesSize, descriptionSize) = subviewsSize(frame.size)

        (flagFrame, frame)       = frame.divided(atDistance: flagSize.height, from: .minYEdge)
        frame                    = frame.offsetBy(dx: 0, dy: spasing)
        (propertiesFrame, frame) = frame.divided(atDistance: propertiesSize.height, from: .minYEdge)
        frame                    = frame.offsetBy(dx: 0, dy: spasing)
        (descriptionFrame, _)    = frame.divided(atDistance: descriptionSize.height, from: .minYEdge)

        flagImageView.frame          = flagFrame.insetBy(dx: (frame.size.width - flagSize.width)/2, dy: 0)
        countryPropertiesView.frame  = propertiesFrame
        countryDescriptionView.frame = descriptionFrame
    }
    
    //MARK: Public view
    
    func updateFlag(_ flagImage: UIImage?) {
        flagImageView.image = flagImage
    }

    func updateValues(capital: String, area: UInt, population: UInt, description: String) {
        countryPropertiesView.valueColumnView.capitalLabel.text    = capital
        countryPropertiesView.valueColumnView.areaLabel.text       = "\(area)"
        countryPropertiesView.valueColumnView.populationLabel.text = "\(population)"
        countryDescriptionView.descriptionLabel.text               = description
    }

    //MARK: Private methods
    
    private func subviewsSize(_ size: CGSize) -> (flagSize: CGSize, propertiesSize: CGSize, descriptionSize: CGSize) {
        let flagSize        = flagImageView.sizeThatFits(size)
        let properiesSize   = countryPropertiesView.sizeThatFits(size)
        let descriptionSize = countryDescriptionView.sizeThatFits(size)
        
        return (flagSize, properiesSize, descriptionSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
