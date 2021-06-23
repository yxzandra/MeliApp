import UIKit

class SearchCell: UITableViewCell {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    private typealias Constants = SearchViewConstants.SearchCell
    var textChangeAction: ((String) -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchTextField.delegate = self
        prepareSearchTextField()
        prepareSearchButton()
    }
    
    private func prepareSearchTextField() {
        searchTextField.placeholder = Constants.placeholderTextField
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.borderStyle = UITextField.BorderStyle.roundedRect
        searchTextField.autocorrectionType = UITextAutocorrectionType.no
        searchTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.marginSearch
            ),
            searchTextField.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.marginSearch
            ),
            searchTextField.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Constants.marginSearch
            )
        ])
    }
    
    private func prepareSearchButton() {
        self.searchButton.setTitle(Constants.titleSearchButton, for: .normal)
        self.searchButton.setTitleColor(.titleColor, for: .normal)
        self.searchButton.translatesAutoresizingMaskIntoConstraints = false
        self.searchButton.addTarget(self, action: #selector(searchTouchUpInside), for: .touchUpInside)

        NSLayoutConstraint.activate([
            searchButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.marginSearch
            ),
            searchButton.leadingAnchor.constraint(
                equalTo: searchTextField.trailingAnchor,
                constant: Constants.marginLeftTextField
            )
        ])

        Layout.centerYAnchor(of: searchButton, in: searchTextField)
    }
    
    @objc func searchTouchUpInside() {
        guard let text = searchTextField.text, !text.isEmpty else { return }
        textChangeAction?(text)
    }
}
extension SearchCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchTouchUpInside()
        return true
    }
}
