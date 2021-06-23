class PictureMapper {
    func reverseMap(value: Picture) -> String {
        let viewModel = String(value.url)
        return viewModel
    }
    
    func reverseMap(values: [Picture]) -> [String] {
        var newValues = [String]()
        values.forEach { value in
            newValues.append(reverseMap(value: value))
        }
        return newValues
    }
}
