@testable import Pitchy
import Quick
import Nimble

final class WaveCalculatorSpec: QuickSpec {
    override class func spec() {
        let waves = [
            (frequency: 440.0,
             wavelength: 0.7795,
             period: 0.00227259
            ),
            (frequency: 1000.0,
             wavelength: 0.343,
             period: 0.001
            )
        ]

        describe("WaveCalculator") {
            describe(".wavelengthBounds") {
                it("has bounds based on min and max frequencies from the config") {
                    let minimum = try! WaveCalculator.wavelength(forFrequency: FrequencyValidator.maximumFrequency)
                    let maximum = try! WaveCalculator.wavelength(forFrequency: FrequencyValidator.minimumFrequency)
                    let expected = (minimum: minimum, maximum: maximum)
                    let result = try! WaveCalculator.wavelengthBounds()

                    expect(result.minimum).to(equal(expected.minimum))
                    expect(result.maximum).to(equal(expected.maximum))
                }
            }

            describe(".periodBounds") {
                it("has bounds based on min and max frequencies from the config") {
                    let bounds = try! WaveCalculator.wavelengthBounds()
                    let minimum = try! WaveCalculator.period(forWavelength: bounds.minimum)
                    let maximum = try! WaveCalculator.period(forWavelength: bounds.maximum)
                    let expected = (minimum: minimum, maximum: maximum)
                    let result = try! WaveCalculator.periodBounds()

                    expect(result.minimum).to(equal(expected.minimum))
                    expect(result.maximum).to(equal(expected.maximum))
                }
            }

            describe(".isValid:wavelength") {
                it("is invalid if value is higher than maximum") {
                    let wavelength = 1000.0
                    let result = try! WaveCalculator.isValid(wavelength: wavelength)
                    expect(result).to(beFalse())
                }

                it("is invalid if value is lower than minimum") {
                    let wavelength = 0.01
                    let result = try! WaveCalculator.isValid(wavelength: wavelength)
                    expect(result).to(beFalse())
                }

                it("is invalid if value is zero") {
                    let wavelength = 0.0
                    let result = try! WaveCalculator.isValid(wavelength: wavelength)
                    expect(result).to(beFalse())
                }

                it("is valid if value is within valid bounds") {
                    let wavelength = 16.0
                    let result = try! WaveCalculator.isValid(wavelength: wavelength)
                    expect(result).to(beTrue())
                }
            }

            describe(".isValidPeriod") {
                it("is invalid if value is higher than maximum") {
                    let period = 10.0
                    let result = try! WaveCalculator.isValid(period: period)
                    expect(result).to(beFalse())
                }

                it("is invalid if value is lower than minimum") {
                    let period = 0.0001
                    let result = try! WaveCalculator.isValid(period: period)
                    expect(result).to(beFalse())
                }

                it("is invalid if value is zero") {
                    let period = 0.0
                    let result = try! WaveCalculator.isValid(period: period)
                    expect(result).to(beFalse())
                }

                it("is valid if value is within valid bounds") {
                    let period = 0.02
                    let result = try! WaveCalculator.isValid(period: period)
                    expect(result).to(beTrue())
                }
            }

            describe(".frequency:forWavelength") {
                it("returns a correct frequency for the specified wavelength") {
                    waves.forEach {
                        let result = try! WaveCalculator.frequency(forWavelength: $0.wavelength)
                        expect(result) ≈ ($0.frequency, 0.1)
                    }
                }
            }

            describe(".wavelength:forFrequency") {
                it("returns a correct wavelength for the specified frequency") {
                    waves.forEach {
                        let result = try! WaveCalculator.wavelength(forFrequency: $0.frequency)
                        expect(result) ≈ ($0.wavelength, 0.1)
                    }
                }
            }

            describe(".wavelength:forPeriod") {
                it("returns a correct wavelength for the specified period") {
                    waves.forEach {
                        let result = try! WaveCalculator.wavelength(forPeriod: $0.period)
                        expect(result) ≈ ($0.wavelength, 0.0001)
                    }
                }
            }

            describe(".period:forWavelength") {
                it("returns a correct period for the specified wavelength") {
                    waves.forEach {
                        let result = try! WaveCalculator.period(forWavelength: $0.wavelength)
                        expect(result) ≈ ($0.period, 0.0001)
                    }
                }
            }
        }
    }
}
