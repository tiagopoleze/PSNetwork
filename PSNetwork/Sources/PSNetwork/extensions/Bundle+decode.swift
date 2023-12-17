import Foundation

extension Bundle {
    func decode<T: Decodable>(
        _ type: T.Type,
        from file: String,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys
    ) throws -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            throw BundleDecodeError.noValidURL("Failed to locate \(file) in bundle.")
        }
        guard let data = try? Data(contentsOf: url) else {
            throw BundleDecodeError.noContentTo(url)
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            // swiftlint:disable:next line_length
            print("Failed to decode \(file) from bundle due to missing key '\(key.stringValue) - \(context.debugDescription)")
            throw DecodingError.keyNotFound(key, context)
        } catch DecodingError.typeMismatch(let key, let context) {
            print("Failed to decode \(file) from bundle due to type mismatch - \(context.debugDescription)")
            throw DecodingError.typeMismatch(key, context)
        } catch DecodingError.valueNotFound(let type, let context) {
            print("Failed to decode \(file) from bundle due to missing \(type) value - \(context.debugDescription)")
            throw DecodingError.valueNotFound(type, context)
        } catch DecodingError.dataCorrupted(let error) {
            print("Failed to decode \(file) from bundle because it appears to be invalid JSON.")
            throw DecodingError.dataCorrupted(error)
        } catch {
            print("Failed to decode \(file) from bundle: \(error.localizedDescription)")
            throw error
        }
    }
}

enum BundleDecodeError: Error {
    case noValidURL(String)
    case noContentTo(URL)
}
