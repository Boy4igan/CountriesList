import UIKit

class CLMainTableViewController: UITableViewController {
    var countries = [CLCountryModel]()
    //MARK: ME эта переменная нужна лишь в 1 методе, имеет смысл перенести ее туда
    let cellIdentifier = "cell"
    
    // MARK: - Initialization
    
    init()  {
        super.init(nibName: nil, bundle: nil)
        title = "Countries"
        self.loadModelAsync()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = CLCountryTableViewCell(reuseIdentifier: cellIdentifier)
        }
        addContent(from: countries[indexPath.row], to: cell as! CLCountryTableViewCell)
        
        return cell!
    }
    
    //MARK: ME этот метод не относится к Table view data source. Это приватный метод и должен быть определен с себе подобными.
    func addContent(from country: CLCountryModel, to cell: CLCountryTableViewCell) {
        cell.flagImageView.image    = country.flag
        cell.countryLabel.text      = country.title
        cell.capitalLabel.text      = country.capital
    }
    
    // MARK: Table view delegate
    //MARK: ME не вижу смысла разделять Delegate и Data Source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry = self.countries[indexPath.row]
        let nextController  = CLCountryViewController(country: selectedCountry)
        
        navigationController?.pushViewController(nextController, animated: true)
    }
}

//MARK: Model builder
//MARK: ME Заяем Extension?
extension CLMainTableViewController {
    
    var urlToFilePath: URL {
        let urlToJson = Bundle.main.url(forResource: "countries", withExtension: "json")
        
        assert(urlToJson != nil, "Can't find file with named: counties.json")
        
        return urlToJson!
    }
    
    func loadModelAsync() {
        DispatchQueue.global().async {
            [unowned self] in
            
            let jsonDoc = self.jsonObject(with: self.readFile())
            
            self.addCountriesFrom(jsonDocument: jsonDoc)
        }
    }
    
    func readFile() -> Data {
        var data: Data!
        
        do {
            data = try Data(contentsOf: urlToFilePath)
        }
        catch {
            //MARK: ME fatalError(error.localizedDescription)
            assert(false, error.localizedDescription)
        }
        return data
    }
    
    func jsonObject(with data: Data) -> Dictionary<String, Dictionary<String, AnyObject> > {
        var jsonDoc: Any!
        
        do {
            jsonDoc = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
        }
        catch {
            assert(false, error.localizedDescription)
        }
        
        return jsonDoc as! Dictionary<String, Dictionary<String, AnyObject> >
    }
    
    func addCountriesFrom(jsonDocument: Dictionary<String, Dictionary<String, AnyObject> >) {
        for (title, countriesProperty) in jsonDocument {
            let country = createCountry(with: title, countryProperties: countriesProperty)
            
            self.didObtainCountry(country)
        }
    }
    
    func didObtainCountry(_ country: CLCountryModel) {
        DispatchQueue.main.async {
            [unowned self] in
//MARK: ME Тут все верно, работа с UI должна выполняться только в UI потоке
            self.countries.append(country)
            self.tableView.reloadData()
        }
    }
    
    //MARK: ME Создание модели из dict можно перенести в саму модель или в ее Satelite (мы так делали со stmt из БД)
    func createCountry(with title: String, countryProperties: Dictionary<String, AnyObject>) -> CLCountryModel {
            return CLCountryModel(title: title,
                                  capital: countryProperties["Capital"] as! String,
                                  area: countryProperties["Total area"] as! UInt,
                                  population: countryProperties["Population"] as! UInt,
                                  countryDescription: countryProperties["Description"] as! String,
                                  flag: UIImage(named: title)!)
        }
    
}
