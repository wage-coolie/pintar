class ApplicationController < ActionController::API
	# because our application specifications are low we are defining every helper DRY function in Application controller, they can be understood by names given

	def find_by_short_code(code)
		record = Url.find_by(short_code: code)
		record
	end

	def find_by_url(url)
		record = Url.find_by(url: url)
		record
	end
end
