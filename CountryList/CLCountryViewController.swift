import UIKit

class CLCountryViewController: UIViewController {
    lazy var scrollView = view as! CLScrollView
    lazy var contentView = scrollView.contentView
    let countryModel: CLCountryModel
    
    init(_ country: CLCountryModel) {
        countryModel = country
        
        super.init(nibName: nil, bundle: nil)
        
        title = countryModel.title
    }
    
    // MARK: Override methods
    
    override func loadView() {
        view = CLScrollView()
    }
    
    override func viewDidLoad() {
        contentView.updateFlag(UIImage(named: countryModel.flag))
        contentView.updateValues(capital: countryModel.capital,
                                 area: countryModel.area,
                                 population: countryModel.population,
                                 description: countryModel.description)
    }
    
    //MARK: Private methods
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
