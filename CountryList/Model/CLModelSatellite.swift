import Foundation

class CLModelSatellite {
    
    // MARK: Public property
    
    weak var delegate: CLModelSatelliteDellegate?
    
    // MARK: Public method
    
    func startBackgroundLoad() {
        DispatchQueue.global().async(execute: loadModel)
    }
    
    // MARK: Private property
    
    private var urlToSourceFile: URL {
        let url = Bundle.main.url(forResource: "countries", withExtension: "json")
        
        guard url != nil else {
            fatalError("Can't find sourse file: \"countries.json\"")
        }
        
        return url!
    }
    
    //MARK: Private methods
    
    private func loadModel() {
        let jsonDoc = jsonObject(from: loadData())
        
        for countryDict in jsonDoc {
            let country = createCountry(dict:countryDict)
            
            self.delegate?.didObtainModel(country)
        }
    }
    
    private func loadData() -> Data {
        let resultData: Data!
        
        do {
            resultData = try Data(contentsOf: urlToSourceFile)
        }
        catch {
            fatalError(error.localizedDescription)
        }
        
        return resultData
    }
    
    private func jsonObject(from data: Data) -> [Dictionary<String, AnyObject>] {
        let jsonDoc: [Dictionary<String, AnyObject>]
        
        do {
            jsonDoc = try JSONSerialization.jsonObject(with: data,
                                                       options: .allowFragments) as! [Dictionary<String, AnyObject>]
        }
        catch {
            fatalError(error.localizedDescription)
        }
        
        return jsonDoc
    }
    
    private func createCountry(dict : Dictionary<String, AnyObject>) -> CLCountryModel {
        let title = dict["title"] as! String
        
        return CLCountryModel(title: title,
                              capital: dict["Capital"] as! String,
                              population: dict["Population"] as! UInt,
                              area: dict["Total area"] as! UInt,
                              description: dict["Description"] as! String,
                              flag: title)
    }
}

// MARK: Delegate's protocol

protocol CLModelSatelliteDellegate : AnyObject {
    func didObtainModel(_ model: CLCountryModel)
}
