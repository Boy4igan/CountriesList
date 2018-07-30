import UIKit

class CLCountryViewController: UIViewController {
    //MARK: ME Вся полезная логика у тебя перекочевыала во вьюху
    
    let country: CLCountryModel
    
    init(country: CLCountryModel) {
        self.country = country
        
        super.init(nibName: nil, bundle: nil)
        title = country.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = CLCountryView(countryModel: country)
    }
}
