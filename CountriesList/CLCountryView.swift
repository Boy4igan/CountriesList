import UIKit

class CLCountryView: UIView {
    let indent: CGFloat     = 10
    
    let flagImgView         = UIImageView()
    var capital             = CLPairLabels()
    var area                = CLPairLabels()
    var population          = CLPairLabels()
    var countryDescription  = CLPairLabels(position: .vertical, indent: 0)
    
    // MARK: Initialization
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        setStylesForSubviews()
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(flagImgView)
        addSubview(capital)
        addSubview(area)
        addSubview(population)
        addSubview(countryDescription)
    }
    
    func setStylesForSubviews() {
        flagImgView.contentMode = .scaleAspectFit
        
        setStylesForPairLabels(pairLabels: capital)
        setStylesForPairLabels(pairLabels: area)
        setStylesForPairLabels(pairLabels: population)
        setStylesForPairLabels(pairLabels: countryDescription)
        
        countryDescription.valueLabel.numberOfLines = 0
        countryDescription.indent                   = 0
    }
    
    func setStylesForPairLabels(pairLabels: CLPairLabels) {
        pairLabels.keyLabel.font    = UIFont.boldSystemFont(ofSize: pairLabels.font.pointSize)
        pairLabels.indent           = indent
    }
    
    // MARK: Layout subviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let viewsFrame  = UIScreen.main.bounds.insetBy(dx: indent, dy: indent)
        var unusedFrame = assignLocateFlag(in: viewsFrame)
        
        unusedFrame = assignLocateFor(&capital, in: unusedFrame)
        unusedFrame = assignLocateFor(&area, in: unusedFrame)
        unusedFrame = assignLocateFor(&population, in: unusedFrame)
        unusedFrame = assignLocateFor(&countryDescription, in: unusedFrame)
    }
    
    func assignLocateFlag(in viewsFrame: CGRect) -> CGRect {
        let flagSize                    = flagImgView.sizeThatFits(viewsFrame.size)
        let (flagFrame, unusedFrame)    = viewsFrame.divided(atDistance: flagSize.height,
                                                             from: CGRectEdge.minYEdge)
        
        flagImgView.frame = flagFrame.insetBy(dx: (flagFrame.size.width - flagSize.width)/2, dy: 0)
        
        return unusedFrame.offsetBy(dx: 0, dy: indent)
    }
    
    func assignLocateFor( _ pairLabels: inout CLPairLabels, in subviewFrame: CGRect) -> CGRect {
        let pairSize                    = pairLabels.sizeThatFits(subviewFrame.size)
        let (pairFrame, unusedFrame)    = subviewFrame.divided(atDistance: pairSize.height,
                                                               from: CGRectEdge.minYEdge)
        
        pairLabels.frame = pairFrame
        
        return unusedFrame.offsetBy(dx: 0, dy: indent)
    }
}
