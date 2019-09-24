module OcrScanner
	
	def self.scan(lines)
		numbers_found = []
		scan_for_candidate_by_range(lines, [0, 3], 0, numbers_found)
		numbers_found.join.encode('utf-8')
	end

	def self.scan_for_candidate_by_range(lines, range, row_counter, numbers_found)
		puts "called with range: #{range}"
		candidate = []
		lines.each_index do |i|
			puts "entering loop with row_counter: #{row_counter}"
			if row_counter == 0
				line_range = lines[i][range[0],range[1]]
				puts "line_range was: #{line_range}"
				candidate += [line_range]
			elsif row_counter == 1
				line_range = lines[i][range[0],range[1]]
				puts "line_range was: #{line_range}"
				candidate += [line_range]
			elsif row_counter == 2
				line_range = lines[i][range[0],range[1]]
				puts "line_range was: #{line_range}"
				candidate += [line_range]
			end
			row_counter += 1

			if row_counter > 2
				if candidate == [" _ ", "| |", "|_|"]
					puts candidate
					candidate = []
					range[0] += 3
					range[1] += 0
					row_counter = 0
					numbers_found.push 0
					scan_for_candidate_by_range(lines, range, row_counter, numbers_found)
				elsif candidate == [" _ ", "| ||", "|_||"]
					puts candidate
					candidate = []
					range[0] += 2
					range[1] += 2
					row_counter = 0
					numbers_found.push 0
					scan_for_candidate_by_range(lines, range, row_counter, numbers_found)
				end
			end
		end	
	end

end
