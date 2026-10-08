import Foundation

enum NumberParser {
    /// Parses user-typed numbers in the current locale, tolerating a
    /// comma or dot as the decimal separator.
    static func parse(_ text: String, locale: Locale = .current) -> Double? {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }

        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .decimal
        if let n = formatter.number(from: trimmed) {
            return n.doubleValue
        }
        // Fallback: the other decimal separator.
        let swapped = trimmed.contains(",")
            ? trimmed.replacingOccurrences(of: ",", with: ".")
            : trimmed.replacingOccurrences(of: ".", with: ",")
        return formatter.number(from: swapped)?.doubleValue ?? Double(trimmed)
    }

    /// Formats a number for a text field (no grouping, locale decimal separator).
    static func string(from value: Double, locale: Locale = .current) -> String {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = false
        formatter.maximumFractionDigits = 3
        return formatter.string(from: NSNumber(value: value)) ?? String(value)
    }
}
