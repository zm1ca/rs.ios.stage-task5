import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    func findMaxKilometres() -> Int {
        let foodsMemoizationTable = memoizationTable(for: foods)
        let drinksMemoizationTable = memoizationTable(for: drinks)
        
        var maximumDistanceToCover = 0
        for weightOfFoodToTake in 1...maxWeight - 1 {
            let distanceToCover = min(
                foodsMemoizationTable[foods.count][weightOfFoodToTake],
                drinksMemoizationTable[drinks.count][maxWeight - weightOfFoodToTake]
            )
            
            if distanceToCover > maximumDistanceToCover {
                maximumDistanceToCover = distanceToCover
            }
        }
        
        return maximumDistanceToCover
    }
    
    private func memoizationTable(for suppliesPack: [Supply]) -> [[Int]] {
        var memoizationTable = Array(repeating: Array(repeating: 0, count: maxWeight + 1), count: suppliesPack.count + 1)
        for i in 0..<suppliesPack.count + 1 {
            for j in 0..<maxWeight + 1 {
                guard i != 0, j != 0 else { continue }
                if suppliesPack[i - 1].weight > j {
                    ///Если предмет i при ограничении веса j не помещается в принципе - то и считать нечего, нужно просто брать значение, как если бы этого предмета и не было
                    memoizationTable[i][j] = memoizationTable[i - 1][j]
                } else {
                    ///memoizationTable[i - 1][j - suppliesPack[i - 1].weight -- максимальная эфффективность, которую можно получить освободив место под suppliesPack[i - 1]
                    memoizationTable[i][j] = max(suppliesPack[i - 1].value + memoizationTable[i - 1][j - suppliesPack[i - 1].weight], memoizationTable[i - 1][j])
                }
            }
        }
        
        return memoizationTable
    }
}
