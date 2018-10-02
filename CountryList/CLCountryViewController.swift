import UIKit

class CLCountryViewController: UIViewController {
    lazy var scrollView = view as! CLScrollView
    lazy var contentView = scrollView.contentView
    let countryModel: CLCountryModel
    
    init(_ country: CLCountryModel) {
        countryModel = country
        
        super.init(nibName: nil, bundle: nil)
        
        title                    = countryModel.title
        additionalSafeAreaInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    // MARK: Override methods
    
    override func loadView() {
        view = CLScrollView()
    }
    
    override func viewDidLoad() {
        addSwipeGesture()
        
        contentView.updateFlag(UIImage(named: countryModel.flag))
        contentView.updateValues(capital: countryModel.capital,
                                 area: countryModel.area,
                                 population: countryModel.population,
                                 description: countryModel.description)
    }
    
    //MARK: private methods
    
    func addSwipeGesture() {
        let swipe = UISwipeGestureRecognizer.init(target: self, action: #selector(handleSwipe(_:)))
        
        scrollView.addGestureRecognizer(swipe)
    }
    
    //MARK: Handle gesture
    
    @objc func handleSwipe(_ swipe: UISwipeGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: Private methods
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
