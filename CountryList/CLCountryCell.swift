import UIKit

class CLCountryCell: UITableViewCell {
    //MARK: Override methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        imageView?.clipsToBounds      = true
        imageView?.layer.cornerRadius = 5
        imageView?.layer.borderWidth  = 0.5
        imageView?.layer.borderColor  = UIColor.gray.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let cImageView = imageView {
            let imageSize = cImageView.sizeThatFits(self.bounds.size)
            var imageFrame = contentView.bounds.inset(by: self.safeAreaInsets)
            
            imageFrame = bounds.insetBy(dx: 0, dy: (imageFrame.size.height - imageSize.height)/2)
            imageFrame.size.width = imageSize.width
            
            cImageView.frame = imageFrame
        }
    }
    
    //MARK: Private methods
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
