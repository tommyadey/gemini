class HomeController < ApplicationController
	layout :home_layout
	def index
		if signed_in?
			@status = current_user.statuses.build
			@feed_items = current_user.feed
			render 'index'
		else
			render 'signed_out_index'
		end
	end

	
	
end
