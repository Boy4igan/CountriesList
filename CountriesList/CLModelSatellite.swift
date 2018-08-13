import Foundation

class CLModelSatellite {
    private var  callback: (( _: CLCountryModel) -> ())!
    
    private var urlToFilePath: URL {
        let urlToJson = Bundle.main.url(forResource: "countries", withExtension: "json")
        
        assert(urlToJson != nil, "Can't find file with named: counties.json")
        
        return urlToJson!
    }
    
    // MARK: Public method
    
    func loadModels(selector: @escaping (_ model: CLCountryModel) -> ()) {
        self.callback = selector
        
        DispatchQueue.global().async {
            [unowned self] in
            let jsonDoc = self.jsonObject(with: self.readFile())
            
            for (title, attributes) in jsonDoc {
                let country = CLCountryModel(countryTitle: title, countryAttributes: attributes)
                
                self.didObtain(country)
            }
        }
    }
    
    // MARK: Reading file
    
    private func readFile() -> Data {
        var data: Data!
        
        do {
            data = try Data(contentsOf: urlToFilePath)
        }
        catch {
            fatalError(error.localizedDescription)
        }
        return data
    }
    
    // MARK: Converting loaded data to JSON
    
    private func jsonObject(with data: Data) -> Dictionary<String, Dictionary<String, AnyObject> > {
        var jsonDoc: Any!
        
        do {
            jsonDoc = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
        }
        catch {
            fatalError(error.localizedDescription)
        }
        
        return jsonDoc as! Dictionary<String, Dictionary<String, AnyObject> >
    }
    
    // MARK: Callback
    
    private func didObtain( _ country: CLCountryModel) {
        DispatchQueue.main.async {
            [unowned self] in
            self.callback(country)
        }
    }
}
