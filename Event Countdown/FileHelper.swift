import Foundation

class FileHelper {
    static func save(_ events: [Event]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(events)
            let documentsURL = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            let fileURL = documentsURL.appendingPathComponent("events.json")
            try data.write(to: fileURL)
        } catch {
        }
    }
    
    static func load() -> [Event]? {
        do {
            let documentsURL = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            )
            let fileURL = documentsURL.appendingPathComponent("events.json")
            
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            return try decoder.decode([Event].self, from: data)
            
            
        } catch {
            return nil
        }
    }
    
    
}
