# CoreMLEmojiEmbedding 🤯 🐶 🤖 

## What is this?
CoreMLEmojiEmbedding is a [WordEmbedding](https://developer.apple.com/documentation/createml/mlwordembedding) specifically for emojis that's built to work with iOS's default [english word embedding](https://developer.apple.com/documentation/naturallanguage/nlembedding/3074352-wordembedding).

CoreMLEmojiEmbedding can be used in your app to recommend emojis to users based on an english word or another emoji

## Example
Display the most relevant emojis for the word "dog"
```
// Step 1: Get the URL for the WordEmbedding model
guard let compiledEmbeddingUrl = Bundle.main.url(forResource: "EmojiWordEmbedding", withExtension: "mlmodelc") else { fatalError("Model not found") }

// Step 2: Load the custom embedding from the compiled url
guard let emojiEmbedding = try? NLEmbedding(contentsOf: compiledEmbeddingUrl) else { fatalError("Failed to instantiate NLEmbedding") }

// Step 3: Get the standard system WordEmbedding
guard let osEmbedding = NLEmbedding.wordEmbedding(for: .english) else { fatalError("OS Embedding not found") }

// Step 4: Get the nearest neighbors for the word in emoji-space
if let dogVector = osEmbedding.vector(for: "dog") {
    let neighbors = emojiEmbedding.neighbors(for: dogVector, maximumCount: 5)
    
    print(neighbors)
    // [("🐶", 0.27594462037086487), ("🐕", 0.27594462037086487), ("🦮", 0.37312763929367065), ("🐩", 0.5896843671798706), ("🐈", 0.7106234431266785)]
}
```
