import UIKit

class CLLabelsColumnView: UIView {
    let capitalLabel      = UILabel()
    let areaLabel         = UILabel()
    let populationLabel   = UILabel()
    let spasing : CGFloat = 5
    
    init() {
        super.init(frame: .zero)
        
        addSubview(capitalLabel)
        addSubview(areaLabel)
        addSubview(populationLabel)
    }
    
    //MARK: Override methods
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let (capitalSize, areaSize, populationSize) = labelsSize(size)
        let maxWidth    = max(capitalSize.width, areaSize.width, populationSize.width)
        let totalHeight = capitalSize.height + areaSize.height + populationSize.height + spasing * 2
        
        return CGSize(width: maxWidth, height: totalHeight)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var capiitalFrame, areaFrame, populationFrame: CGRect
        var frame                                   = bounds
        let (capitalSize, areaSize, populationSize) = labelsSize(frame.size)

        (capiitalFrame, frame) = frame.divided(atDistance: capitalSize.height, from: .minYEdge)
        frame                  = frame.offsetBy(dx: 0, dy: spasing)
        (areaFrame, frame)     = frame.divided(atDistance: areaSize.height, from: .minYEdge)
        frame                  = frame.offsetBy(dx: 0, dy: spasing)
        (populationFrame, _)   = frame.divided(atDistance: populationSize.height, from: .minYEdge)

        capitalLabel.frame    = capiitalFrame
        areaLabel.frame       = areaFrame
        populationLabel.frame = populationFrame
    }
    
    //MARK: Private methods
    
    private func labelsSize(_ size: CGSize) -> (capitalSize: CGSize, areaSize: CGSize, populationSize: CGSize) {
        let capitalSize    = capitalLabel.sizeThatFits(size)
        let areaSize       = areaLabel.sizeThatFits(size)
        let populationSize = populationLabel.sizeThatFits(size)
        
        return (capitalSize, areaSize, populationSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
