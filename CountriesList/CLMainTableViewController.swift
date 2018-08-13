import UIKit

class CLMainTableViewController: UITableViewController {
    var countries       = [CLCountryModel]()
    let modelSatellite  = CLModelSatelite()
    
    // MARK: - Initialization
    
    init()  {
        super.init(nibName: nil, bundle: nil)
        title = "Countries"
        modelSatellite.loadModels(selector: didLoadModel(_:))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overriding table view controller

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier  = "cell"
        var cell            = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = CLCountryTableViewCell(reuseIdentifier: cellIdentifier)
        }
        updateCellContent(cell as! CLCountryTableViewCell, from: countries[indexPath.row])
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry = self.countries[indexPath.row]
        let nextController  = CLCountryViewController(country: selectedCountry)
        
        navigationController?.pushViewController(nextController, animated: true)
    }
    
    //MARK: Updating cell content
    
    func updateCellContent(_ cell: CLCountryTableViewCell, from country: CLCountryModel) {
        cell.flagImageView.image    = country.flag
        cell.countryLabel.text      = country.title
        cell.capitalLabel.text      = country.capital
    }
    
    func didLoadModel(_ country: CLCountryModel) {
        countries.append(country)
        self.tableView.reloadData()
    }
}
