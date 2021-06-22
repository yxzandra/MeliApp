import UIKit

class DetailDataSource: NSObject {
    typealias Constants = DetailViewConstants
    weak var viewController: DetailViewController?
    var cellTypes = DetailCellTypes.default
    
    private func prepareCarousel(_ viewModel: DetailViewModel, _ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NibCell.nibCarouselDetailCell, for: indexPath) as? CarouselDetailCell
        else { return UITableViewCell() }
        cell.loadData(imageList: viewModel.pictures)
        return cell
    }
    
    private func prepareHeader(_ viewModel: DetailViewModel, _ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NibCell.nibHeaderDetailCell, for: indexPath) as? HeaderDetailCell
        else { return UITableViewCell() }
        cell.titleLabel.text = viewModel.title
        cell.priceLabel.text = viewModel.price
        cell.warantyLabel.text = viewModel.warranty
        cell.soldQuantityLabel.text = String(format: Constants.soldFormat, viewModel.soldQuantity)
        cell.avalilableQuantityLabel.text = String(format: Constants.availableFormat, viewModel.availableQuantity)
        
        return cell
    }
    
    private func prepareDescription(_ viewModel: DetailViewModel, _ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NibCell.nibDescriptionDetailCell, for: indexPath) as? DescriptionDetailCell
        else { return UITableViewCell() }
        
        cell.setDescription(
            description: viewModel.description ?? "",
            isShow: viewController?.showDescription ?? false
        )
        
        return cell
    }
}
extension DetailDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewController?.viewModel else { return UITableViewCell() }
        
        let cellSection = cellTypes[indexPath.row]
        let cell: UITableViewCell
        
        switch cellSection {
        case .carousel:
            cell = prepareCarousel(viewModel, tableView, indexPath)
        case .header:
            cell = prepareHeader(viewModel, tableView, indexPath)
            cell.backgroundColor = .clear
        case .description:
            cell = prepareDescription(viewModel, tableView, indexPath)
            cell.backgroundColor = .clear
        }
        cell.selectionStyle = .none
        return cell
    }
    
}
