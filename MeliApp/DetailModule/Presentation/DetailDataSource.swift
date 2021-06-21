import UIKit

class DetailDataSource: NSObject {
    typealias Constants = DetailViewConstants.NibCell
    weak var viewController: DetailViewController?
    var cellTypes = DetailCellTypes.default
}
extension DetailDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
}
