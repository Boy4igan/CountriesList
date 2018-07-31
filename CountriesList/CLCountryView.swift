import UIKit

class CLCountryView: UIView {
    let flagImgView         = UIImageView()
    var country             = CLPairLabels()
    var capital             = CLPairLabels()
    var area                = CLPairLabels()
    var population          = CLPairLabels()
    var countryDescription  = CLPairLabels()
    let indent: CGFloat     = 10
    
    // MARK: Initialization
    
    //MARK: ME Вьюха ничеvarо не должна знать о модели. Она должна просто создавать свои сабьвюхи, а конкретные значения в них должен записывать контроллер
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor         = .white
        flagImgView.contentMode = .scaleAspectFit
        
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(flagImgView)
        addSubview(country.keyLabel)
        addSubview(country.valueLabel)
        addSubview(capital.keyLabel)
        addSubview(capital.valueLabel)
        addSubview(area.keyLabel)
        addSubview(area.valueLabel)
        addSubview(population.keyLabel)
        addSubview(population.valueLabel)
        addSubview(countryDescription.keyLabel)
        addSubview(countryDescription.valueLabel)
    }
    
    // MARK: Layout subviews
    
    //MARK: ME поставь лог и посмотри, как часто вызыввается метод layoutSubviews внутри UIScrollView
    //Откажись пока от UIScrollView, сначала решим задачу так, а потом будем думать как жить с UIScrollView
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let viewsFrame  = UIScreen.main.bounds.insetBy(dx: indent, dy: indent)
        var unusedFrame = assignLocateFlag(in: viewsFrame)
        
        unusedFrame = assignLocateFor(&country, in: unusedFrame)
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
