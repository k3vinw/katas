require_relative "ocr_scanner.rb"
require "test/unit"

class TestOcrScanner < Test::Unit::TestCase

	def test_user_story_1
		input = <<~HEREDOC
		 _  _  _  _  _  _  _  _  _ 
		| || || || || || || || || |
		|_||_||_||_||_||_||_||_||_|

		HEREDOC

		assert_equal(9, OcrScanner.scan(input.split("\n")).length)
		assert_equal("000000000", OcrScanner.scan(input.split("\n")))
	end

end
