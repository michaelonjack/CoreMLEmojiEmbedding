import Cocoa
import CoreML
import NaturalLanguage

//
// Usage example:
// Find emoji most closely related to the word "dog"
//

// Step 1: Get the URL for the WordEmbedding model
guard let compiledEmbeddingUrl = Bundle.main.url(forResource: "EmojiWordEmbedding", withExtension: "mlmodelc") else { fatalError("Model not found") }

// Step 3: Load the custom embedding from the compiled url
guard let emojiEmbedding = try? NLEmbedding(contentsOf: compiledEmbeddingUrl) else { fatalError("Failed to instantiate NLEmbedding") }

// Step 4: Get the standard system WordEmbedding
guard let osEmbedding = NLEmbedding.wordEmbedding(for: .english) else { fatalError("OS Embedding not found") }

// Step 5: Get the nearest neighbors for the word in emoji-space
if let dogVector = osEmbedding.vector(for: "giraffe") {
    let neighbors = emojiEmbedding.neighbors(for: dogVector, maximumCount: 5)
    
    print(neighbors)
}
