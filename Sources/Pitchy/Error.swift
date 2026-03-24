enum PitchError: Error, Sendable {
  case invalidFrequency
  case invalidWavelength
  case invalidPeriod
  case invalidPitchIndex
  case invalidOctave
}
