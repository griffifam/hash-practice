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
# Time Complexity: ?
# Space Complexity: ?
def top_k_frequent_elements(list, k)
  # array = [a, a, a, b, b, , c, c, d, e]]
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

  frequency = frequency.sort {|a1,a2| a2[1]<=>a1[1]}
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
# Time Complexity: ?
# Space Complexity: ?
def valid_sudoku(table)
  i = 0
  while i < table.length
    row = validate_row(table[i])
    if row == false
      return false
    else
      i += 1
    end
  end
  # binding.pry
  column = validate_column(table)
  if column == true
    return true
  else
    return false
  end
end

def validate_row(array)
  i = 0
  validator = get_hash
  while i < array.length
      element = array[i]
      if validator[element]
        validator[element] -= 1
        value = validator[element]
        if value.to_i < 0
          return false
        end
      end
    i += 1
  end
  return true
end

def validate_column(grid)
  y = 0
  while y < grid.length
    validator = get_hash
    x = 0 #will be column
    while x < grid.length
      element = grid[x][y]
      if validator[element]
        validator[element] -= 1
        value = validator[element]
        if value.to_i < 0
          return false
        end
      end
      x += 1
    end
    y += 1
  end
  return true
end

def get_hash
  hashmap = { "1" => 1, "2" => 1, "3" => 1, "4" => 1, "5" => 1, "6" => 1, "7" => 1, "8" => 1, "9"=> 1 }
  return hashmap
end