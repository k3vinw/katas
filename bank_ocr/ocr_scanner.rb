module OcrScanner
	
	def self.scan(lines)
		numbers_found = []
		scan_for_candidate_by_range(lines, 0, 0, numbers_found)
		numbers_found.join
	end

	def self.scan_for_candidate_by_range(lines, start_range, row_counter, numbers_found)
		puts "called with start_range: #{start_range}"
		candidate = []
		lines.each_index do |i|
			puts "entering loop with row_counter: #{row_counter}"
			if row_counter < 3
				line_range = lines[i][start_range, 3]
				puts "line_range was: #{line_range}"
				candidate += [line_range]
			end
			row_counter += 1

			if row_counter > 2
				if candidate == [" _ ", "| |", "|_|"]
					puts candidate
					candidate = []
					start_range += 3
					row_counter = 0
					numbers_found.push 0
					scan_for_candidate_by_range(lines, start_range, row_counter, numbers_found)
				end
			end
		end	
	end

end
