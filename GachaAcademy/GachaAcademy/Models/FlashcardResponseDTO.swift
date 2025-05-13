struct FlashcardResponseDTO: Decodable {
    let flashcardDTO: FlashcardDTO
    let statusCode: Int

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        flashcardDTO = try container.decode(FlashcardDTO.self)
        statusCode = try container.decode(Int.self)
    }
}
