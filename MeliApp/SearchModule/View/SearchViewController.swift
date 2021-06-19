import Foundation
import UIKit

class SearchViewController: UIViewController {
    typealias Constants = SearchViewConstants
    internal var presenter: SearchPresenterProtocol?
    
    let inputSearch = UITextField()
    let buttonSearch = UIButton()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareInputSearch()
        prepareSearchButton()
    }
    
    private func prepareView() {
        self.view.backgroundColor = .backgroundColor
        self.navigationItem.title = Constants.titleView
    }
    
    private func prepareInputSearch() {
        inputSearch.placeholder = Constants.placeholderTextField
        inputSearch.translatesAutoresizingMaskIntoConstraints = false
        inputSearch.borderStyle = UITextField.BorderStyle.roundedRect
        inputSearch.autocorrectionType = UITextAutocorrectionType.no
        inputSearch.clearButtonMode = UITextField.ViewMode.whileEditing
        inputSearch.delegate = self
        self.view.addSubview(inputSearch)
        
        inputSearch.topAnchor.constraint(equalTo: self.view.topAnchor, constant: CGFloat(125)).isActive = true
        Layout.centerXAnchor(of: inputSearch, in: self.view)
        Layout.marginPin(of: inputSearch, in: self.view, constant: Constants.marginItems)
    }
    
    private func prepareSearchButton() {
        self.buttonSearch.setTitle(Constants.titleSearchButton, for: .normal)
        self.buttonSearch.setTitleColor(.titleColor, for: .normal)
        self.buttonSearch.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.buttonSearch)
        
        self.buttonSearch.addTarget(self, action: #selector(searchTouchUpInside), for: .touchUpInside)
        
        buttonSearch.topAnchor.constraint(equalTo: self.inputSearch.bottomAnchor, constant: CGFloat(12)).isActive = true
        Layout.centerXAnchor(of: buttonSearch, in: self.view)
        Layout.marginPin(of: buttonSearch, in: self.view, constant: Constants.marginItems)
    }
    
    @objc func searchTouchUpInside() {
        guard let text = inputSearch.text else { return }
        presenter?.searchItem(item: text)
    }
}

extension SearchViewController: SearchViewProtocol {
    // TODO: implement view output methods
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchTouchUpInside()
        return true
    }
}
