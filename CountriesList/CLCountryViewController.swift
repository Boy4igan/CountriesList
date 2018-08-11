import UIKit

class CLCountryViewController: UIViewController {
    //MARK: ME Вся полезная логика у тебя перекочевыала во вьюху
    
    let countryModel: CLCountryModel
    lazy var countryView = view as! CLCountryView
    
    init(country: CLCountryModel) {
        self.countryModel = country
        
        super.init(nibName: nil, bundle: nil)
        title = country.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = CLCountryView()
    }
    
    override func viewDidLoad() {
        countryView.flagImgView.image = countryModel.flag
        
        countryView.capital.update(keyLabelText: "Capital:", valueLabelText: countryModel.capital)
        countryView.area.update(keyLabelText: "Area:", valueLabelText: String(countryModel.area))
        countryView.population.update(keyLabelText: "Population:",
                                      valueLabelText: String(countryModel.population))
        countryView.countryDescription.update(keyLabelText: "Description:",
                                              valueLabelText: countryModel.countryDescription)
        countryView.updateFixedWidthOfPairLabels()
    }
    
    override func viewWillLayoutSubviews() {
        viewUpdateTopIndent()
    }
    
    func viewUpdateTopIndent() {
        if let navBarFrame = self.navigationController?.navigationBar.frame {
            countryView.topIndent = navBarFrame.origin.y + navBarFrame.size.height
        }
    }
}
