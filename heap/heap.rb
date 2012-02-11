# A Heap implementation based on COMP 3804
# @author: Uri Gorelik
# Feb 2012

class Heap
	attr_reader :heap_list
	
	def initialize
		@heap_list = []
	end
	
	def initialize array
		@heap_list = []
		
		@given_list = Array.new array
		# Run operations to make this a heap
		
		for i in (0..@given_list.length - 1)
			insert @given_list[i]
		end
	end
	
	def insert x
		@heap_list << x
		swap_parent(@heap_list.length - 1)
	end
	
	
	def sort!
		a = []
		for i in (0..@heap_list.length - 1)
			a << extract_max!
		end
		
		return a
	end
	
	def get_max
		@heap_list[0]
	end
	
	
	
	def increase_key list, index, value
		return if list[index] >= value
		# Continue
	end
	
	# ===== Private ===== #
	private
	def extract_max!
		ret_largest = @heap_list.shift
		
		last = @heap_list.pop
		@heap_list.insert(0, last)
		
		# Fix the heap property
		heapify 0
		
		ret_largest
		
	end
	
	
	
	def heapify index
		left = (index * 2) + 1
		right = (index * 2) + 2
		largest = nil
		
		a = @heap_list
		
		if left <= (a.length - 1) && a[left] > a[index]
			largest = left
		else
			largest = index
		end

		if right <= (a.length - 1) && a[right] > a[largest]
			largest = right
		end
		
		if largest != index
			a[index], a[largest] = a[largest], a[index]
			heapify(largest)
		end
			
		
		
		
	end
	
	def swap_parent i
		a = @heap_list
		if (a[i] > a[i/2])
			
			a[i], a[i/2] = a[i/2], a[i]
			
			# Keep going if we need to
			swap_parent (i/2)
		end
	end
	
		
end

a = Array.new(10) { rand 1001 }
h = Heap.new a

puts "This is the sorted array\n #{h.sort!}"