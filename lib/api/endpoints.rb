module API
	# Class containing endpoints
	class Endpoints < Grape::API
	  mount API::Category
	end
end