import UIKit

class CLCountryCell: UITableViewCell {

    let imageViewIndent = UIEdgeInsets.init(top: 3, left: 3, bottom: 3, right: 3)

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

        imageView!.bounds = imageView!.bounds.inset(by: imageViewIndent)
    }
    
    //MARK: Private methods
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
