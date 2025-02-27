import Foundation

extension String {
    func padleft(toLength length: Int, withPad pad: Character) -> String {
        let current = count
        let distance = max(0, length - current)
        
        return String(repeating: pad, count: distance) + self
    }
}
