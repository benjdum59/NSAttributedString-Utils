import Foundation

extension NSAttributedString {
    public func exponentize(searchTexts: [String], font: UIFont?, baselineOffset: Int) -> NSAttributedString {
        exponentize(ranges: string.ranges(of: searchTexts), font: font, baselineOffset: baselineOffset)
    }
    
    public func exponentize(ranges: [NSRange], font: UIFont?, baselineOffset: Int) -> NSAttributedString {
        guard !string.isEmpty, ranges.count > 0 else {
            return self
        }
        var rangePointer = NSRange(location: 0, length: 1)
        guard ranges.count > 0,
            let newFont: UIFont = font ?? attribute(NSAttributedString.Key.font, at: 1, effectiveRange: &rangePointer) as? UIFont else {
            return self
        }
        let attributedText = NSMutableAttributedString(attributedString: self)
        let sortedRanges = ranges.sorted(by: { $0.location < $1.location })
        sortedRanges.forEach { range in
            if range.location + range.length <= attributedText.length {
                attributedText.setAttributes([NSAttributedString.Key.font: newFont,
                                              NSAttributedString.Key.baselineOffset: baselineOffset],
                                             range: range)
            }
        }
        return attributedText
    }
    
    public func exponentize(ranges: [Range<String.Index>], font: UIFont?, baselineOffset: Int) -> NSAttributedString {
        exponentize(ranges: ranges.map({ $0.nsRange(in: string) }), font: font, baselineOffset: baselineOffset)
    }

    public func changeFont(searchTexts: [String], font: UIFont?) -> NSAttributedString {
        guard let font = font else {
            return self
        }
        return exponentize(searchTexts: searchTexts, font: font, baselineOffset: 0)
    }
}

private extension RangeExpression where Bound == String.Index  {
    func nsRange<S: StringProtocol>(in string: S) -> NSRange {
        NSRange(self, in: string)
    }
}

private extension String {
    private func ranges(of text: String, options: CompareOptions = [], locale: Locale? = nil) -> [Range<Index>] {
        var ranges: [Range<Index>] = []
        while let range = range(of: text, options: options, range: (ranges.last?.upperBound ?? self.startIndex)..<self.endIndex, locale: locale) {
            ranges.append(range)
        }
        return ranges
    }

    func ranges(of texts: [String]) -> [Range<Index>] {
        texts.flatMap({ ranges(of: $0) })
    }
}
