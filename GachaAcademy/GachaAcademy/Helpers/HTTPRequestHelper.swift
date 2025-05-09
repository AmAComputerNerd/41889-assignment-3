import Foundation

class HTTPRequestHelper {
    static let baseUrl = "http://dolphinflashcards.com/api/"
    
    static func makePostRequest(endpoint: String, body: [String: String]) async throws -> (Data, HTTPURLResponse) {
        guard let url = URL(string: baseUrl + endpoint) else {
            throw ApiRequestError.invalidURL
        }
        
        var request = URLRequest(url: url);
        request.httpMethod = "POST";
        request.addValue("application/json", forHTTPHeaderField: "Content-Type");

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: []);
        } catch {
            throw ApiRequestError.requestFailed(message: "Error encoding request body");
        }
        
        let (data, response): (Data, URLResponse);
        do {
            (data, response) = try await URLSession.shared.data(for: request);
        }
        catch {
            throw ApiRequestError.requestFailed(message: error.localizedDescription);
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            return (data, httpResponse);
        }
        
        throw ApiRequestError.invalidResponse
    }
}

enum ApiRequestError: Error, LocalizedError {
    case requestFailed(message: String)
    case invalidURL
    case invalidResponse
    
    var errorDescription: String? {
        switch self {
        case .requestFailed(let message):
            return message;
            
        case .invalidURL:
            return "URL is invalid";
            
        case .invalidResponse:
            return "HTTP response was invalid";
    }
}
