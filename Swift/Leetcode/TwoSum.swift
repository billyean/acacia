//
//  TwoSum.swift
//  Leetcode excercise:
//  https://leetcode.com/problems/two-sum/
//  Created by Yan, Tristan on 5/12/16.
//
//

import Foundation

class Solution {
    func twoSum(nums: [Int], _ target: Int) -> [Int] {
        var i = 0
        var j = 0
        for (i = 0; i < nums.count - 1; i = i + 1) {
            for (j = i + 1; j < nums.count; j = j + 1) {
                if (nums[i] + nums[j] = target) {
                    return [i, j]
                }
            }
        }
        return []
    }
}