import Foundation

public class FlashcardManager {
    static let baseUrl = "http://dolphinflashcards.com/api/"
    static let getAllCardsEndpoint = "get-all-cards"

    public static func getAllCardInfo(jwt: String) async throws -> [Folder] {
        guard let url = URL(string: baseUrl + getAllCardsEndpoint) else {
            throw ApiRequestError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let body = ["jwtToken": jwt]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            throw ApiRequestError.failedToRetrieveAllCards(message: "Error encoding request body")
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, _) = await URLSession.shared.data(for: request)
            let folders = JsonParser.parseFolders(data: data)
            return folders
        } catch {
            throw ApiRequestError.failedToRetrieveAllCards(message: error.localizedDescription)
        }
    }
}

public enum ApiRequestError: Error {
    case failedToRetrieveAllCards(message: String)
    case invalidURL
}
