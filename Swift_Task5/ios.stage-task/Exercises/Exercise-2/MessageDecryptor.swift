import UIKit

extension String {
    subscript(_ range: NSRange) -> String {
        let start = self.index(self.startIndex, offsetBy: range.lowerBound)
        let end = self.index(self.startIndex, offsetBy: range.upperBound)
        let subString = self[start..<end]
        return String(subString)
    }
}

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        var msg = message
        let regex = try! NSRegularExpression(pattern: "(\\d{0,3})\\[(\\w+)\\]")
        
        while let match = regex.firstMatch(in: msg, options: [], range: NSRange(location: 0, length: msg.utf16.count)) {
            let numberOfRepetitions = Int(msg[match.range(at: 1)]) ?? 1
            let stringToRepeat      = msg[match.range(at: 2)]
            
            msg.replaceSubrange(Range(match.range, in: msg)!, with: String(repeating: stringToRepeat, count: numberOfRepetitions))
        }

        return msg
    }
}
