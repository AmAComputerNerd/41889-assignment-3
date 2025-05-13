import Foundation

class FlashcardManager {
    static let getAllFlashcardsEndpoint = "get-all-cards"
    static let getFlashcardEndpoint = "get-flashcard-item"
    
    static func getAllFlashcards(jwt: String) async throws -> FlashcardFolder {
        let allFlashcardInfo = try await retrieveAllFlashcardInfo(jwt: jwt);
        return try await getFlashcardsFromDTOs(folderDTOs: allFlashcardInfo);
    }

    static func retrieveAllFlashcardInfo(jwt: String) async throws -> [FolderDTO] {
        let (data, response): (Data, HTTPURLResponse);
        do {
            (data, response) = try await HTTPRequestHelper.makePostRequest(endpoint: getAllFlashcardsEndpoint, body: ["jwtToken": jwt]);
        } catch{
            throw FlashcardManagerError.unableToRetrieveAllFlashcardInfo(message: error.localizedDescription)
        }
        
        if (response.statusCode < 200 || response.statusCode >= 300) {
            throw FlashcardManagerError.unableToRetrieveAllFlashcardInfo(message: "API response is not successful")
        }
        
        do {
            return try JsonParser.parseFolders(data: data);
        }
        catch {
            throw FlashcardManagerError.unableToRetrieveAllFlashcardInfo(message: "Retrieved data is invalid");
        }
    }
    
    static func retrieveFlashcard(cardID: String) async throws -> FlashcardDTO {
        let (data, response): (Data, HTTPURLResponse);
        do {
            (data, response) = try await HTTPRequestHelper.makePostRequest(endpoint: getFlashcardEndpoint, body: ["cardID": cardID]);
        } catch{
            throw FlashcardManagerError.unableToRetrieveFlashcard(message: "Card ID: \(cardID), Error: \(error.localizedDescription)");
        }
        
        if (response.statusCode < 200 || response.statusCode >= 300) {
            throw FlashcardManagerError.unableToRetrieveFlashcard(message: "API response is not successful");
        }
        
        do {
            let response = try JSONDecoder().decode(FlashcardResponseDTO.self, from: data);
            return response.flashcardDTO;
        }
        catch {
            throw FlashcardManagerError.unableToRetrieveFlashcard(message: "Retrieved data is invalid");
        }
    }
    
    static func flashcardInfoDtoToFlashcard(flashcardInfoDTO: FlashcardInfoDTO) async throws -> Flashcard {
        let flashcardDTO = try await retrieveFlashcard(cardID: flashcardInfoDTO.cardID);
        return Flashcard(front: flashcardDTO.front, back: flashcardDTO.back);
    }
    
    static func getFlashcardsFromDTOs(folderDTOs: [FolderDTO], folderName: String? = nil) async throws -> FlashcardFolder {
        let flashcardFolder = FlashcardFolder(name: folderName);
        
        for folderDTO in folderDTOs {
            if (folderDTO.flashcards.count > 0) {
                let flashcardSet = FlashcardSet(name: folderDTO.name)
                for flashcardInfoDTO in folderDTO.flashcards {
                    flashcardSet.flashcards.append(try await flashcardInfoDtoToFlashcard(flashcardInfoDTO: flashcardInfoDTO));
                }
                
                flashcardFolder.flashcardSets.append(flashcardSet);
            }
            
            if (folderDTO.subfolders.count > 0) {
                flashcardFolder.subFolders.append(try await getFlashcardsFromDTOs(folderDTOs: folderDTO.subfolders, folderName: folderDTO.name));
            }
        }
        
        return flashcardFolder
    }
}

enum FlashcardManagerError: Error {
    case unableToRetrieveAllFlashcardInfo(message: String)
    case unableToRetrieveFlashcard(message: String)
}
