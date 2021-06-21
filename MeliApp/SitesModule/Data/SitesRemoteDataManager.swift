import Alamofire

class SitesRemoteDataManager: SitesRemoteDataManagerInputProtocol {
    private let url = Endpoint.site
    var remoteRequestHandler: SitesRemoteDataManagerOutputProtocol?
    
    convenience init(remoteRequestHandler: SitesRemoteDataManagerOutputProtocol) {
        self.init()
        self.remoteRequestHandler = remoteRequestHandler
    }
    
    func externalGetData() {
        AF.request(url, method: .get).responseJSON { response in
            if response.response?.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let getUrl =  try decoder.decode([Site].self, from: response.data!)
                    self.remoteRequestHandler?.returnData(sites: getUrl)
                } catch {
                    let statusCode = response.response?.statusCode ?? .zero
                    self.genericError(statusCode: statusCode, message: error.localizedDescription)
                }
            } else {
                do {
                    let decoder = JSONDecoder()
                    let getUrl =  try decoder.decode(Error.self, from: response.data!)
                    self.remoteRequestHandler?.errorData(statusCode: response.response!.statusCode, error: getUrl)
                    print("Ha ocurrido un error: \(String(response.response!.statusCode))")
                } catch {
                    let statusCode = response.response?.statusCode ?? .zero
                    self.genericError(statusCode: statusCode, message: error.localizedDescription)
                }
            }
        }
    }
    
    private func genericError(statusCode: Int, message: String) {
        let error = Error(
            error: "No se pudo parsear el archivo",
            message: message
        )
        self.remoteRequestHandler?.errorData(statusCode: statusCode, error: error)
    }
}
