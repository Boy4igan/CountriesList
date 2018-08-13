import UIKit

class CLCountryTableViewCell: UITableViewCell {
    let indent: CGFloat = 5
    
    lazy var flagImageView  = self.imageView!
    lazy var countryLabel   = self.textLabel!
    lazy var capitalLabel   = self.detailTextLabel!
    
    // MARK: Initialization
    
    init(reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.value1, reuseIdentifier: reuseIdentifier)
        
        imageView!.clipsToBounds        = true
        imageView!.layer.cornerRadius   = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        //MARK: ME Вот эту штуку я обычно пихаю к приватным методам
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Layout subviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        reduceFlagFrame()
    }
    
    func reduceFlagFrame() {
        let aspectRatio = flagImageView.bounds.width / flagImageView.bounds.height
        
        flagImageView.frame = flagImageView.frame.insetBy(dx: indent * aspectRatio, dy: indent)
    }
}
