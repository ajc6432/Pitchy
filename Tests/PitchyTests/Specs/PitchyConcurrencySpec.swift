@testable import Pitchy
import Quick
import Nimble
import Foundation

class PitchyConcurrencySpec: AsyncSpec {
    override class func spec() {
        describe("Pitchy Concurrency") {
            
            it("can pass a Pitch across thread boundaries") {
                let pitch = try? Pitch(frequency: 440.0)
                
                // Wrap the logic in a Task to simulate a background worker
                let task = Task.detached {
                    // Accessing properties on a background thread
                    return pitch?.note.letter
                }
                
                let letter = await task.value
                expect(letter).to(equal(.A))
            }
            
            it("calculates frequencies correctly from an Actor") {
                actor PitchWorker {
                    func getFrequency(for index: Int) throws -> Double {
                        return try NoteCalculator.frequency(forIndex: index)
                    }
                }

                let worker = PitchWorker()

                let safeIndex = 0

                await expect {
                    try await worker.getFrequency(for: safeIndex)
                }.toNot(throwError())
            }

            it("handles FrequencyValidator constants without data races") {
                let results = await withTaskGroup(of: Bool.self) { group in
                    for _ in 0..<100 {
                        group.addTask {
                            // Multiple threads reading the same static constants
                            return FrequencyValidator.isValid(frequency: 440.0)
                        }
                    }
                    
                    var allPassed = true
                    for await result in group {
                        if !result { allPassed = false }
                    }
                    return allPassed
                }
                
                expect(results).to(beTrue())
            }
        }
    }
}
