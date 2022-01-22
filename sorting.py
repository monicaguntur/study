"""
Implementing sorting algorithms 
"""

# Insertion Sort

"""
Algorithm: iterate over all elements. 
If element is smaller than the previous elements go backwards by swapping
with previous element till it reaches it's correct position
"""


def insertion_sort(list_nums):
    for i in range(1,len(list_nums)):
        while (list_nums[i] < list_nums[i-1]) and i > 0:
            list_nums[i], list_nums[i-1] = list_nums[i-1], list_nums[i]
            i -= 1
    return list_nums

if __name__ == '__main__':
    listnums  = [5,6,2,7,1,9]
    print(insertion_sort(listnums))




# Merge Sort 

"""
Algorithm: recursive 
split into 2 and sort the two halves 
"""

def merge(l,r):
    i = j = 0
    arr = []
    while i < len(l) and j < len(r):
        if l[i] < r[j]:
            arr.append(l[i])
            i += 1
        else:
            arr.append(r[j])
            j += 1
    if i != len(l):
        arr.extend(l[i:len(l)])
    if j != len(r):
        arr.extend(r[j:len(r)])
    
    return arr

def merge_sort(arr):
    if len(arr) == 1:
        return arr
    mid = len(arr)//2
    l = arr[:mid]
    r = arr[mid:]

    l = merge_sort(l)
    r = merge_sort(r)

    out_arr = merge(l,r)

    return out_arr


    
test_case = [5,6,2,7,1,9]

print(merge_sort(test_case))


# Quick sort 

"""
Algprithm: pick one item and place all items less than it before it and all items greater than it after it.
Do this for all items 
"""

def quick_sort(arr):
    if len(arr) <= 1:
        return arr
    item = arr.pop()
    lesser = []
    greater = []
    for i in arr:
        if i < item:
            lesser.append(i)
        else:
            greater.append(i)
    return(quick_sort(lesser)+[item]+quick_sort(greater))

print(quick_sort(test_case))




# Selection sort

"""
Algorithm: Find the smallest element and place it at the beginning of the list
"""

def select_sort(arr):
    for i in range(len(arr)):
        min_ind = i
        for j in range(i+1, len(arr)):
            if arr[min_ind] > arr[j]:
                min_ind = j

        arr[i], arr[min_ind] =  arr[min_ind], arr[i]
    return arr

test_case2 = [5,6,2,7,1,9]
print(select_sort(test_case2))
        


# Bubble Sort 

"""
Algorithm: swap adjacent items and push the greater items to the right

"""

def bubble_sort(arr):
    for i in range(len(arr)):
        for j in range(0,len(arr) - i - 1):
            if arr[j] > arr[j+1]:
                arr[j], arr[j+1] = arr[j+1], arr[j]

    return arr 

test_case3 = [5,6,2,7,1,9]
print(bubble_sort(test_case3))
