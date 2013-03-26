class HomeController < ApplicationController
	layout :home_layout
	def index
		if signed_in?
			render 'index'
		else
			render 'signed_out_index'
		end
	end

	
	
end
