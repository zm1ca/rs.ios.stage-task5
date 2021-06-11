import Foundation

class StockMaximize {

    func countProfit(prices: [Int]) -> Int {
        var mutablePrices = prices
        var profit = 0
        var maxIndex = 0

        while let max = mutablePrices.max() {
            maxIndex = mutablePrices.firstIndex(of: max)!
            for i in 0..<maxIndex {
                profit -= mutablePrices[i]
            }
            profit += maxIndex * prices[prices.firstIndex(of: max)!]
            mutablePrices.removeFirst(maxIndex + 1)
        }

        return profit
    }
}
