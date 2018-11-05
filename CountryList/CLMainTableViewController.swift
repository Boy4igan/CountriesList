import UIKit

class CLMainTableViewController: UITableViewController, CLModelSatelliteDellegate {
    static let cellIdentifier = "cell"
    
    let modelSatellite = CLModelSatellite()
    var countries      = [CLCountryModel]()
    
    //MARK: - Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)

        title = "Countries"
        
        modelSatellite.delegate = self
        modelSatellite.startBackgroundLoad()
    }
    
    //MARK: - Model Satelite delegate
    
    func didObtainModel(_ model: CLCountryModel) {
        DispatchQueue.main.async { [unowned self] in
            self.countries.append(model)
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCountryCell() ?? createCountryCell()

        updateCell(cell, from: countries[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = CLCountryViewController(countries[indexPath.row])
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    //MARK: - Private methods
    
    private func dequeueReusableCountryCell() -> UITableViewCell? {
        return tableView.dequeueReusableCell(withIdentifier: CLMainTableViewController.cellIdentifier)
    }
    
    private func createCountryCell() -> CLCountryCell {
        return CLCountryCell(style: .value1, reuseIdentifier: CLMainTableViewController.cellIdentifier)
    }
    
    private func updateCell(_ cell: UITableViewCell, from countryModel: CLCountryModel) {
        cell.imageView?.image      = UIImage(named: countryModel.flag)
        cell.textLabel?.text       = countryModel.title
        cell.detailTextLabel?.text = countryModel.capital
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
