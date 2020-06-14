import Cocoa
import CoreML
import NaturalLanguage

//
// Usage example:
// Find emoji most closely related to the word "dog"
//

// Step 1: Get the URL for the WordEmbedding model
guard let compiledEmbeddingUrl = Bundle.main.url(forResource: "EmojiWordEmbedding", withExtension: "mlmodelc") else { fatalError("Model not found") }

// Step 2: Load the custom embedding from the compiled url
guard let emojiEmbedding = try? NLEmbedding(contentsOf: compiledEmbeddingUrl) else { fatalError("Failed to instantiate NLEmbedding") }

// Step 3: Get the standard system WordEmbedding
guard let osEmbedding = NLEmbedding.wordEmbedding(for: .english) else { fatalError("OS Embedding not found") }

// Step 4: Get the nearest neighbors for the word in emoji-space
if let dogVector = osEmbedding.vector(for: "rice") {
    let neighbors = emojiEmbedding.neighbors(for: dogVector, maximumCount: 5)
    
    print(neighbors)
    // [("🐶", 0.27594462037086487), ("🐕", 0.27594462037086487), ("🦮", 0.37312763929367065), ("🐩", 0.5896843671798706), ("🐈", 0.7106234431266785)]
}
