
import Foundation
import Alamofire

//////get
struct showMyCalneder
{
    static let shared = showMyCalneder()

    func getMyData(thisMonth imin : String ,completion : @escaping (NetworkResult<Any>) -> Void ){
        let URL = APIConstants.baseURL+"diarys/"+imin
        let header : HTTPHeaders = NetworkInfo.headerWithToken

        let dataRequest = AF.request(URL,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
       
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                let networkResult = self.judgeStatus(by: statusCode, value)
               completion(networkResult)
            case .failure:
               completion(.pathErr)

            }
        }

    }

    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(ReponseCalendar.self, from: data)
        else { return .pathErr }
        switch statusCode {
        case 200: return .success(decodedData)
        case 400:

            return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }

}

struct getDetailDiary
{
    static let shared = getDetailDiary()

    func getMyData(thisMonth idx : Int ,completion : @escaping (NetworkResult<Any>) -> Void)
    {
        let URL = APIConstants.baseURL+"diarys/\(idx)/details"
        let header : HTTPHeaders = NetworkInfo.headerWithToken

        let dataRequest = AF.request(URL, method: .get, encoding: JSONEncoding.default, headers: header)
        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
            case .failure:
                completion(.pathErr)
            }
        }
    }

    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(ReponseDetailCalendar.self, from: data)
        else { return .pathErr }
        switch statusCode {
        case 200: return .success(decodedData)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }

}

