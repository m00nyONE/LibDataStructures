LibDataStructures = LibDataStructures or {}

local LDS = LibDataStructures

LDS.Heap = {}

local Heap = LDS.Heap
Heap.__index = Heap

--- Creates a new Heap instance.
-- @param isMinHeap (Optional) If true, creates a Min-Heap; otherwise, a Max-Heap.
-- @return A new Heap object.
-- @usage
-- local heap = Heap:New(true) -- Create a Min-Heap
function Heap:New(isMinHeap)
    local obj = setmetatable({}, Heap)
    obj._data = {}
    obj._isMinHeap = isMinHeap == nil or true -- Default to Min-Heap
    return obj
end

--- Inserts a value into the heap.
-- @param value The value to be inserted.
-- @usage
-- heap:Insert(10)
-- heap:Insert(20)
function Heap:Insert(value)
    table.insert(self._data, value)
    self:_heapifyUp(#self._data)
end

--- Removes and returns the root of the heap.
-- @return The root value of the heap, or nil if the heap is empty.
-- @usage
-- local root = heap:Pop()
-- d(root) -- Outputs the smallest or largest value depending on heap type
function Heap:Pop()
    if #self._data == 0 then
        return nil
    end

    local root = self._data[1]
    self._data[1] = self._data[#self._data]
    table.remove(self._data)
    self:_heapifyDown(1)

    return root
end

--- Peeks at the root of the heap without removing it.
-- @return The root value of the heap, or nil if the heap is empty.
-- @usage
-- local top = heap:Peek()
-- d(top) -- Outputs the smallest or largest value depending on heap type
function Heap:Peek()
    return self._data[1]
end

--- Returns the number of elements in the heap.
-- @return The number of elements.
-- @usage
-- local count = heap:Len()
-- d(count) -- Outputs the number of elements in the heap
function Heap:Len()
    return #self._data
end

--- Checks if the heap is empty.
-- @return `true` if the heap is empty, `false` otherwise.
-- @usage
-- local isEmpty = heap:IsEmpty()
-- d(isEmpty) -- Outputs true if the heap is empty, otherwise false
function Heap:IsEmpty()
    return #self._data == 0
end

--- Restores the heap property by moving an element up.
-- @param index The index of the element to move up.
-- @usage
-- This function is used internally and does not need to be called directly.
function Heap:_heapifyUp(index)
    local parent = zo_floor(index / 2)
    if parent > 0 and self:_compare(index, parent) then
        self._data[index], self._data[parent] = self._data[parent], self._data[index]
        self:_heapifyUp(parent)
    end
end

--- Removes all elements from the heap.
-- @usage
-- heap:Clear()
-- d(heap:Len()) -- should be 0
function Heap:Clear()
    self._data = {}
end

--- Restores the heap property by moving an element down.
-- @param index The index of the element to move down.
-- @usage
-- This function is used internally and does not need to be called directly.
function Heap:_heapifyDown(index)
    local left = 2 * index
    local right = 2 * index + 1
    local smallestOrLargest = index

    -- Check the left child
    if left <= #self._data and self:_compare(left, smallestOrLargest) then
        smallestOrLargest = left
    end

    -- Check the right child
    if right <= #self._data and self:_compare(right, smallestOrLargest) then
        smallestOrLargest = right
    end

    if smallestOrLargest ~= index then
        self._data[index], self._data[smallestOrLargest] = self._data[smallestOrLargest], self._data[index]
        self:_heapifyDown(smallestOrLargest)
    end
end

--- Compares two elements based on the heap type.
-- @param i The first index.
-- @param j The second index.
-- @return `true` if the comparison is valid for the heap type.
-- @usage
-- This function is used internally and does not need to be called directly.
function Heap:_compare(i, j)
    if self._isMinHeap then
        return self._data[i] < self._data[j]
    else
        return self._data[i] > self._data[j]
    end
end
