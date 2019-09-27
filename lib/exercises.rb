require "pry"

# This method will return an array of arrays.
# Each subarray will have strings which are anagrams of each other
# Time Complexity: O(n)^2
# Space Complexity: O(n)

def grouped_anagrams(strings)
  if strings.empty? || strings.nil?
    return []
  elsif strings.length == 1
    return [[strings[0]]]
  else 
    anagram_hash = {}
    
    i = 0 
    while i < strings.length
      unique_word = strings[i].split('').sort.join
      if anagram_hash[unique_word]
        anagram_hash[unique_word] << strings[i]
      else
        anagram_hash[unique_word] = []
        anagram_hash[unique_word] = [strings[i]].to_a
      end
      i += 1
    end

    grouped_array = []
    anagram_hash.each do |k,v|
        grouped_array << anagram_hash[k]
    end

    return grouped_array
  end
end

# This method will return the k most common elements
# in the case of a tie it will select the first occuring element.
# Time Complexity: O(n) - its O(n) going through the list to fill the hash.
# I'm not sure of the big O for sorting a hash - O(log)n? At worse, k == length of list so
# returning the Kth frequent elements is O(n). Filling the hash itself is O(1).
# Space Complexity: O(n) - based on created a hash and filling it with list
def top_k_frequent_elements(list, k)
  # array = [a, a, a, b, b, , c, c, d, e]
  if list.empty?
    return []
  elsif k == 0
    return list
  elsif list.size == 1
    return list
  end
  frequency = {}

  i = 0
  while i < list.length
    list_element = list[i]
    if frequency.key?(list_element)
      frequency[list_element] += 1
    else
      frequency[list_element] = 1
    end
    i += 1
  end

  frequency = frequency.sort {|a1,a2| a2[1]<=>a1[1]} #don't know time/space of this
  result = []
  i = 0
  while i < k
    result << frequency[i][0]
    i += 1
  end
  return result
end

# This method will return true if the table is still
#   a valid sudoku table.
#   Each element can either be a ".", or a digit 1-9
#   The same digit cannot appear twice or more in the same 
#   row, column or 3x3 subgrid
# Time Complexity: O(n)^2
# Space Complexity: O(n)
def valid_sudoku(table)
  # binding.pry
  if validate_rows(table) && validate_columns(table) && in_box?(table)
    return true
  else
    return false
  end
end

def validate_rows(table)
  row = 0
  while row < table.length
    validator = get_hash
    idx = 0

    while idx < table[row].length
      element = table[row][idx]

      if element != '.'
        if validator[element]
          validator[element] -= 1
        end
        value = validator[element]
        if value.to_i < 0
          return false
        end
      end

      idx += 1
    end

    row += 1
  end
  return true
end

def validate_columns(table)
  col = 0
  while col < table.length
    validator = get_hash
    idx = 0

    while idx < table[col].length
      element = table[idx][col]

      if element != '.'
        if validator[element]
          validator[element] -= 1
        end
        value = validator[element]
        if value.to_i < 0
          return false
        end
      end

      idx += 1
    end

    col += 1
  end
  return true
end

def in_box?(table)
  grids = table.each_slice(3).map{|third| third.transpose.each_slice(3).map{|slice| slice.transpose}}.flatten(1)

  grids.each do |box|
    hash_box = {}

    3.times do |row|
      3.times do |col|
        curr = box[row][col]

        if hash_box[curr]
          return false
        end

        if curr != '.'
          hash_box[curr] = 1
        end
      end
    end
  end

  return true
end

def get_hash
  hashmap = { "1" => 1, "2" => 1, "3" => 1, "4" => 1, "5" => 1, "6" => 1, "7" => 1, "8" => 1, "9"=> 1 }
  return hashmap
end
