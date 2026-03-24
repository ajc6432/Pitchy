public struct WaveCalculator: Sendable {
  public static func wavelengthBounds() throws -> (minimum: Double, maximum: Double) {
    let minimum = try wavelength(forFrequency: FrequencyValidator.maximumFrequency)
    let maximum = try wavelength(forFrequency: FrequencyValidator.minimumFrequency)

    return (minimum: minimum, maximum: maximum)
  }

  public static func periodBounds() throws -> (minimum: Double, maximum: Double) {
    let bounds = try wavelengthBounds()
    let minimum = try period(forWavelength: bounds.minimum)
    let maximum = try period(forWavelength: bounds.maximum)

    return (minimum: minimum, maximum: maximum)
  }

  // MARK: - Validators

  public static func isValid(wavelength: Double) throws -> Bool {
    let bounds = try wavelengthBounds()

    return wavelength > 0.0
      && wavelength >= bounds.minimum
      && wavelength <= bounds.maximum
  }

  public static func validate(wavelength: Double) throws {
      guard let isValid = try? isValid(wavelength: wavelength), isValid else {
      throw PitchError.invalidWavelength
    }
  }

  public static func isValid(period: Double) throws -> Bool {
    let bounds = try periodBounds()
    return period > 0.0
      && period >= bounds.minimum
      && period <= bounds.maximum
  }

  public static func validate(period: Double) throws {
      guard let isValid = try? isValid(period: period), isValid else {
      throw PitchError.invalidPeriod
    }
  }

  // MARK: - Conversions

  public static func frequency(forWavelength wavelength: Double) throws -> Double {
    try WaveCalculator.validate(wavelength: wavelength)
    return AcousticWave.speed / wavelength
  }

  public static func wavelength(forFrequency frequency: Double) throws -> Double {
    try FrequencyValidator.validate(frequency: frequency)
    return AcousticWave.speed / frequency
  }

  public static func wavelength(forPeriod period: Double) throws -> Double {
    try WaveCalculator.validate(period: period)
    return period * AcousticWave.speed
  }

  public static func period(forWavelength wavelength: Double) throws -> Double {
    try WaveCalculator.validate(wavelength: wavelength)
    return wavelength / AcousticWave.speed
  }
}
