require_relative "ocr_scanner.rb"
require "test/unit"

class TestOcrScanner < Test::Unit::TestCase

	def test_user_story_1_use_case_1
		input = <<~HEREDOC
		 _  _  _  _  _  _  _  _  _ 
		| || || || || || || || || |
		|_||_||_||_||_||_||_||_||_|

		HEREDOC

		result = OcrScanner.scan(input.split("\n"))

		assert_equal(9, result.length)
		assert_equal("000000000", result)
	end

end
