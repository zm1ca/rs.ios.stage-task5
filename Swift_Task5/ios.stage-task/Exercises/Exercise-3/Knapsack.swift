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
        let foodsEfficiencyTable = getEfficiencyTable(for: foods)
        let drinksEfficiencyTable = getEfficiencyTable(for: drinks)
        
        var max = 0
        for w in 1...maxWeight-1 {
            let distanceToCover = min(foodsEfficiencyTable[foods.count][w], drinksEfficiencyTable[drinks.count][maxWeight - w])
            if distanceToCover > max {
                max = distanceToCover
            }
        }
        
        return max
    }
    
    private func getEfficiencyTable(for suppliesPack: [Supply]) -> [[Int]] {
        let n = suppliesPack.count
        var efficiencyTable = Array(repeating: Array(repeating: 0, count: maxWeight + 1), count: n + 1)
        for i in 0..<n + 1 {
            for j in 0..<maxWeight + 1 {
                guard i != 0, j != 0 else { continue }
                if suppliesPack[i-1].weight <= j {
                    efficiencyTable[i][j] = max(suppliesPack[i - 1].value + efficiencyTable[i - 1][j - suppliesPack[i - 1].weight], efficiencyTable[i - 1][j])
                } else {
                    efficiencyTable[i][j] = efficiencyTable[i - 1][j]
                }
            }
        }
        
        return efficiencyTable
    }
}
