import UIKit

class CLMainTableViewController: UITableViewController, CLModelSatelliteDellegate {
    let modelSatellite = CLModelSatellite()
    var countries      = [CLCountryModel]()
    let cellIdentifier = "cell"
    
    // Initialization
    
    init() {
        super.init(nibName: nil, bundle: nil)

        title                  = "Countries"
        modelSatellite.delegate = self
        modelSatellite.startBackgroundLoad()
    }
    
    //MARK: Model Satelite delegate
    
    func didObtainModel(_ model: CLCountryModel) {
        DispatchQueue.main.async { [unowned self] in
            self.countries.append(model)
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCountryCell() ?? createCountryCell()

        updateCell(cell, from: countries[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(CLCountryViewController(countries[indexPath.row]),
                                                 animated: true)
    }
    
    //MARK: Private methods
    
    private func dequeueReusableCountryCell() -> UITableViewCell? {
        return tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
    }
    
    private func createCountryCell() -> CLCountryCell {
        return CLCountryCell(style: .value1, reuseIdentifier: cellIdentifier)
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
