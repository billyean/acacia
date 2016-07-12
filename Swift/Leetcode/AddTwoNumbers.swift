//
//  AddTwoNumbers.swift
//  Leetcode excercise:
//  https://leetcode.com/problems/add-two-numbers/
//  Created by Yan, Tristan on 5/12/16.
//
//

import Foundation

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.next = nil
 *     }
 * }
 */
class Solution {
    func len(l1: ListNode?) -> int {
        if let list = ListNode {
            return 1 + len(list.next)
        }
        return 0
    }
    
    func addTwoNumbers(l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var len1 = len(l1)
        var len2 = len(l2)
        
        switch (len1, len2) {
        case (0, 0):
            return []
        case (_, 0):
            return l2
        case (_, 0):
            return l1
        }
        
        var longer = len1 > len2 ? l1 : l2
        var shorter = len1 > len2 ? l2 : l1
        var sum = ListNode()
    }
}
