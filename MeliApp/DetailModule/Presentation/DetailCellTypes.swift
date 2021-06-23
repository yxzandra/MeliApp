enum DetailCellTypes {
    case carousel
    case header
    case description
    case error

    static let `default` = [carousel, header, description, error]
}

extension DetailCellTypes {
    static func filteredCellTypes(viewModel: DetailViewModel?, showError: Bool) -> [DetailCellTypes] {
        var options = [carousel]
        if viewModel != nil {
            options.append(header)
            options.append(description)
        } else if showError {
            options.append(error)
        }
        return options
    }
}
