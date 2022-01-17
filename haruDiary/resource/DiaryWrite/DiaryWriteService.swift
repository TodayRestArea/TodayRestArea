

import Foundation
import Alamofire

struct WriteDiary{
    static let shared = WriteDiary()

    private func makeParameter(weatherIdx : Int, contents : String, cratedAt : String) -> Parameters
    {
        return ["weatherIdx" : weatherIdx,
                "contents" : contents,
                "cratedAt" : cratedAt
            ]
    }

    func saveDiary(weatherIdx : Int, contents : String, cratedAt : String , completion : @escaping(NetworkResult<Any>) -> Void) {
        let url: String = APIConstants.baseURL + APIConstants.writeDiary
        let header : HTTPHeaders = NetworkInfo.headerWithToken
        let dataRequest = AF.request(url,
                                     method: .post,
                                     parameters: makeParameter(weatherIdx: weatherIdx, contents: contents, cratedAt: cratedAt),
                                     encoding: JSONEncoding.default,
                                     headers: header)
        dataRequest.responseData { dataResponse in
            dump(dataResponse)
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
            case .failure: completion(.pathErr)

            }
        }

    }

    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {

        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(DiaryWriteResponse.self, from: data)
        else { return .pathErr}
        switch statusCode {

        case 200: return .success(decodedData)
        case 400: return .requestErr(decodedData)
        case 500: return .serverErr
        default: return .networkFail
        }
    }
}

////get
struct AnalyzeDiary
{
    static let shared = AnalyzeDiary()

    func getMyData(diaryId: String ,completion : @escaping (NetworkResult<Any>) -> Void)
    {
        let URL = APIConstants.baseURL + "/diarys/\(diaryId)/analysis"
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
        guard let decodedData = try? decoder.decode(AnalyzeDiaryResponse.self, from: data)
        else { return .pathErr }
        switch statusCode {
        case 200: return .success(decodedData)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }

}

struct EditDiary {
    
    static let shared = EditDiary()

    private func makeParameter(weatherIdx : Int, contents : String, cratedAt : String) -> Parameters
    {
        return ["weatherIdx" : weatherIdx,
                "contents" : contents,
                "cratedAt" : cratedAt
            ]
    }

    func saveDiary(weatherIdx : Int, contents : String, cratedAt : String, diaryId : String , completion : @escaping(NetworkResult<Any>) -> Void) {
       
        let url: String = APIConstants.baseURL +  "/diarys/\(diaryId)"
        let header : HTTPHeaders = NetworkInfo.headerWithToken
        let dataRequest = AF.request(url,
                                     method: .put,
                                     parameters: makeParameter(weatherIdx: weatherIdx, contents: contents, cratedAt: cratedAt),
                                     encoding: JSONEncoding.default,
                                     headers: header)
        dataRequest.responseData { dataResponse in
            dump(dataResponse)
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else {return}
                guard let value = dataResponse.value else {return}
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
            case .failure: completion(.pathErr)

            }
        }

    }

    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {

        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(DiaryWriteResponse.self, from: data)
        else { return .pathErr}
        switch statusCode {

        case 200: return .success(decodedData)
        case 400: return .requestErr(decodedData)
        case 500: return .serverErr
        default: return .networkFail
        }
    }
}

struct DeleteDiary
{
    static let shared = DeleteDiary()

    func getMyData(diaryId: String ,completion : @escaping (NetworkResult<Any>) -> Void)
    {
        let URL = APIConstants.baseURL + "/diarys/\(diaryId)"
        let header : HTTPHeaders = NetworkInfo.headerWithToken
        
        let dataRequest = AF.request(URL,
                                     method: .delete,
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
        guard let decodedData = try? decoder.decode(DiaryWriteResponse.self, from: data)
        else { return .pathErr }
        switch statusCode {
        case 200: return .success(decodedData)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }

}


