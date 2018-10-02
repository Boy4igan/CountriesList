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
        
        for (title, countryAttributes) in jsonDoc {
            let country = createCountryWithTitle(title, and: countryAttributes)
            
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
    
    private func jsonObject(from data: Data) -> Dictionary<String, Dictionary<String, AnyObject> > {
        let jsonDoc: Dictionary<String, Dictionary<String, AnyObject> >
        
        do {
            jsonDoc = try JSONSerialization.jsonObject(with: data,
                                                       options: .allowFragments) as! Dictionary<String, Dictionary<String, AnyObject> >
        }
        catch {
            fatalError(error.localizedDescription)
        }
        
        return jsonDoc
    }
    
    private func createCountryWithTitle(_ title: String,
                                        and attributes: Dictionary<String, AnyObject>) -> CLCountryModel {
        return CLCountryModel(title: title,
                              capital: attributes["Capital"] as! String,
                              population: attributes["Population"] as! UInt,
                              area: attributes["Total area"] as! UInt,
                              description: attributes["Description"] as! String,
                              flag: title)
    }
}

// MARK: Delegate's protocol

protocol CLModelSatelliteDellegate : AnyObject {
    func didObtainModel(_ model: CLCountryModel)
}
