# A Heap implementation based on COMP 3804
# @author: Uri Gorelik
# Feb 2012

class Heap
	attr_reader :heap_list

	def initialize params
    @heap_list = []
  
		if (params[:list] != nil)

			if params[:better_build]
				better_build params[:list]
			else
				a = params[:list]
				a.each do |i|
          insert i
				end
			end
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

	def better_build array
		@heap_list = array
		for i in (((@heap_list.length / 2) - 1).downto 0)
			heapify i
		end
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
			swap_parent((i/2))
		end
	end


end


require "algorithms"
include Algorithms

def time_it
  t1 = Time.now
  a = Array.new(10000) { rand 100 }
  
  yield(a)
  
  puts "It took #{Time.now - t1} seconds."
end

# Using default sort
time_it { |a|
  a.sort!
}


# Using better build
time_it { |a|
  h2 = Heap.new :list => a, :better_build => true
  #puts "This is better build array\n #{h2.sort!}"
}

# Using old method
time_it { |a|
  h1 = Heap.new :list => a
  #puts "This is the heap array\n #{h1.sort!}"
}




time_it { |a|
  Sort.quicksort a
}
