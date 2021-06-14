import Alamofire

class SitesRemoteDataManager:SitesRemoteDataManagerInputProtocol {
    var remoteRequestHandler: SitesRemoteDataManagerOutputProtocol?
    
    func externalGetData() {
        AF.request("https://api.mercadolibre.com/sites", method: .get).responseJSON { response in
            if response.response?.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let getUrl =  try decoder.decode([Site].self, from: response.data!)
                    self.remoteRequestHandler?.returnData(sites: getUrl)
                } catch {
                    print("No se pudo parsear el archivo, error: \(error.localizedDescription)")
                }
            } else {
                print("Ha ocurrido un error: \(String(response.response!.statusCode))")
            }
        }
    }
}
