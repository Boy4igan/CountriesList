import UIKit

struct CLCountryModel {
    let title: String
    let capital: String
    let area: UInt
    let population: UInt
    let countryDescription: String
    let flag: UIImage
    
    init(countryTitle: String, countryAttributes: [String : AnyObject]) {
        self.title              = countryTitle
        self.capital            = countryAttributes["Capital"]      as! String
        self.area               = countryAttributes["Total area"]   as! UInt
        self.population         = countryAttributes["Population"]   as! UInt
        self.countryDescription = countryAttributes["Description"]  as! String
        self.flag               = UIImage(named: title)!
    }
    
}
