import UIKit

class CLCountryPropertiesView: UIView {
    let titleColumnView = CLLabelsColumnView()
    let valueColumnView = CLLabelsColumnView()
    let spasing: CGFloat = 10
    
    init() {
        super.init(frame: .zero)
        
        addSubview(titleColumnView)
        addSubview(valueColumnView)
        
        assignBoldFontForTitleColumn()
        addTextToTitleColumn()
    }
    
    //MARK: Override
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let (titleSize, valueSize) = subviewsSize(size)
        
        return CGSize(width: titleSize.width + valueSize.width + spasing,
                      height: max(titleSize.height, valueSize.height))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let titleFrame, valueFrame: CGRect
        var frame                  = bounds
        let (titleSize, valueSize) = subviewsSize(frame.size)

        (titleFrame, frame) = frame.divided(atDistance: titleSize.width, from: .minXEdge)
        (_ , frame)         = frame.divided(atDistance: spasing, from: .minXEdge)
        (valueFrame, _)     = frame.divided(atDistance: valueSize.width, from: .minXEdge)
        
        titleColumnView.frame = titleFrame
        valueColumnView.frame = valueFrame
    }
    
    //MARK: Private methods
    
    private func subviewsSize(_ size: CGSize) -> (titleColumnSize: CGSize, valueColumnSize: CGSize) {
        let titleSize = titleColumnView.sizeThatFits(size)
        let valueSize = valueColumnView.sizeThatFits(size)
        
        return (titleSize, valueSize)
    }
    
    private func assignBoldFontForTitleColumn() {
        setBoldFontForLabel(titleColumnView.capitalLabel)
        setBoldFontForLabel(titleColumnView.areaLabel)
        setBoldFontForLabel(titleColumnView.populationLabel)
    }
    
    private func addTextToTitleColumn() {
        titleColumnView.capitalLabel.text    = "Capital:"
        titleColumnView.areaLabel.text       = "Area:"
        titleColumnView.populationLabel.text = "Population:"
    }
    
    private func setBoldFontForLabel(_ label: UILabel) {
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
