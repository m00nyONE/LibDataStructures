LibDataStructures = LibDataStructures or {}
local LDS = LibDataStructures

LDS.Tests = LDS.Tests or {}
LDS.Tests.Heap = function()
    local testHeap = LDS.Heap:New(true) -- Min-Heap

    -- Test: New heap is empty
    assert(testHeap:IsEmpty(), "New heap should be empty")
    assert(testHeap:Len() == 0, "New heap length should be 0")
    assert(testHeap:Peek() == nil, "Peek on empty heap should return nil")
    assert(testHeap:Pop() == nil, "Pop on empty heap should return nil")

    -- Test: Insert and Peek
    testHeap:Insert(10)
    assert(not testHeap:IsEmpty(), "Heap should not be empty after Insert")
    assert(testHeap:Len() == 1, "Heap length should be 1 after one Insert")
    assert(testHeap:Peek() == 10, "Peek should return the smallest value in the Min-Heap")

    testHeap:Insert(20)
    assert(testHeap:Len() == 2, "Heap length should be 2 after two Inserts")
    assert(testHeap:Peek() == 10, "Peek should still return the smallest value in the Min-Heap")

    testHeap:Insert(5)
    assert(testHeap:Len() == 3, "Heap length should be 3 after three Inserts")
    assert(testHeap:Peek() == 5, "Peek should return the new smallest value in the Min-Heap")

    -- Test: Pop
    local poppedValue = testHeap:Pop()
    assert(poppedValue == 5, "Pop should return the smallest value in the Min-Heap")
    assert(testHeap:Len() == 2, "Heap length should be 2 after one Pop")
    assert(testHeap:Peek() == 10, "Peek should return the next smallest value after Pop")

    poppedValue = testHeap:Pop()
    assert(poppedValue == 10, "Pop should return the next smallest value")
    assert(testHeap:Len() == 1, "Heap length should be 1 after another Pop")
    assert(testHeap:Peek() == 20, "Peek should return the last remaining value")

    poppedValue = testHeap:Pop()
    assert(poppedValue == 20, "Pop should return the last remaining value")
    assert(testHeap:IsEmpty(), "Heap should be empty after all elements are popped")
    assert(testHeap:Len() == 0, "Heap length should be 0 when empty")

    -- Test: Clear
    testHeap:Insert(10)
    testHeap:Insert(20)
    testHeap:Insert(30)
    assert(testHeap:Len() == 3, "Heap length should be 3 after three Inserts")
    testHeap:Clear()
    assert(testHeap:IsEmpty(), "Heap should be empty after Clear")
    assert(testHeap:Len() == 0, "Heap length should be 0 after Clear")

    -- Test: Min-Heap behavior
    testHeap:Insert(15)
    testHeap:Insert(10)
    testHeap:Insert(5)
    testHeap:Insert(20)
    assert(testHeap:Pop() == 5, "Min-Heap should return the smallest value first")
    assert(testHeap:Pop() == 10, "Min-Heap should return the next smallest value")

    -- Test: Max-Heap behavior
    local maxHeap = LDS.Heap:New(false) -- Max-Heap
    maxHeap:Insert(10)
    maxHeap:Insert(20)
    maxHeap:Insert(15)
    assert(maxHeap:Peek() == 20, "Max-Heap Peek should return the largest value")
    assert(maxHeap:Pop() == 20, "Max-Heap should return the largest value first")
    assert(maxHeap:Pop() == 15, "Max-Heap should return the next largest value")
    assert(maxHeap:Pop() == 10, "Max-Heap should return the smallest value last")
    assert(maxHeap:IsEmpty(), "Max-Heap should be empty after all elements are popped")

    -- Test: Insert negative and positive numbers
    testHeap:Clear()
    testHeap:Insert(0)
    testHeap:Insert(-10)
    testHeap:Insert(10)
    assert(testHeap:Peek() == -10, "Min-Heap should handle negative values correctly")
    assert(testHeap:Pop() == -10, "Min-Heap should return the smallest value, even if negative")
    assert(testHeap:Pop() == 0, "Min-Heap should return the next smallest value")
    assert(testHeap:Pop() == 10, "Min-Heap should return the largest value last")
    assert(testHeap:IsEmpty(), "Heap should be empty after all elements are popped")

    d("All heap tests passed!")
end
