import Alamofire

class DetailRemoteDataManager:DetailRemoteDataManagerInputProtocol {
    private let urlDetail = Endpoint.detail
    private let urlDescription = Endpoint.detailDescription
    var remoteRequestHandler: DetailRemoteDataManagerOutputProtocol?
    
    convenience init(remoteRequestHandler: DetailRemoteDataManagerOutputProtocol) {
        self.init()
        self.remoteRequestHandler = remoteRequestHandler
    }

    func externalDetailItem(idItem: String) {
        let urlParameter = urlDetail.replacingOccurrences(of: "{idItem}", with: idItem)
        AF.request(urlParameter, method: .get).responseJSON { response in
            if response.response?.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let getUrl =  try decoder.decode(Detail.self, from: response.data!)
                    self.remoteRequestHandler?.returnData(data: getUrl)
                } catch {
                    print(" \(error.localizedDescription)")
                    self.remoteRequestHandler?.errorData()
                }
            } else {
                let statusCode = response.response?.statusCode ?? .zero
                print("Ha ocurrido un error: \(statusCode)")
                self.remoteRequestHandler?.errorData()
            }
        }
    }

    func externalDescriptionItem(idItem: String) {
        let urlParameter = urlDescription.replacingOccurrences(of: "{idItem}", with: idItem)
        AF.request(urlParameter, method: .get).responseJSON { response in
            if response.response?.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let getUrl =  try decoder.decode(Description.self, from: response.data!)
                    self.remoteRequestHandler?.returnDescription(data: getUrl)
                } catch {
                    print(" \(error.localizedDescription)")
                    self.remoteRequestHandler?.errorDescription()
                }
            } else {
                let statusCode = response.response?.statusCode ?? .zero
                print("Ha ocurrido un error: \(statusCode)")
                self.remoteRequestHandler?.errorDescription()
            }
        }
    }
}
