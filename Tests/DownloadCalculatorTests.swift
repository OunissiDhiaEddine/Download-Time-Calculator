import Testing
import Foundation
@testable import Download_Time_Calculator

// Not yet part of an Xcode target: add a Unit Testing Bundle in Xcode, then include this folder.
struct DownloadCalculatorTests {
    @Test func oneGigabyteAtEightMbpsTakesOneThousandSeconds() {
        let size = DataSize(value: 1, unit: .GB, system: .decimal)
        let rate = DataRate(value: 8, unit: .Mbps)
        #expect(DownloadCalculator.timeToDownload(size: size, at: rate) == 1000)
    }

    @Test func megabytesPerSecondMatchesBits() {
        let size = DataSize(value: 80, unit: .MB, system: .decimal)
        let rate = DataRate(value: 10, unit: .MBps)
        #expect(DownloadCalculator.timeToDownload(size: size, at: rate) == 8)
    }

    @Test func efficiencyStretchesTime() {
        let size = DataSize(value: 1, unit: .GB, system: .decimal)
        let rate = DataRate(value: 8, unit: .Mbps)
        #expect(DownloadCalculator.timeToDownload(size: size, at: rate, efficiency: 0.5) == 2000)
    }

    @Test func zeroSpeedIsRejected() {
        let size = DataSize(value: 1, unit: .GB, system: .decimal)
        #expect(DownloadCalculator.timeToDownload(size: size, at: DataRate(value: 0, unit: .Mbps)) == nil)
    }

    @Test func binaryIsLargerThanDecimal() {
        let dec = DataSize(value: 1, unit: .GB, system: .decimal).bytes
        let bin = DataSize(value: 1, unit: .GB, system: .binary).bytes
        #expect(bin > dec)
    }

    @Test func parserAcceptsCommaAndDot() {
        #expect(NumberParser.parse("1.5", locale: Locale(identifier: "en_US")) == 1.5)
        #expect(NumberParser.parse("1,5", locale: Locale(identifier: "fr_FR")) == 1.5)
        #expect(NumberParser.parse("abc") == nil)
    }

    @Test func durationFormatting() {
        #expect(DurationFormatter.longString(seconds: 3661) == "1h 1m 1s")
        #expect(DurationFormatter.hmsString(seconds: 3661) == "1:01:01")
    }
}
