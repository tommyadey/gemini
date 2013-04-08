class PhotoTempsController < ApplicationController

	def index
		@photo_temps = PhotoTemp.all
	end

	def new
		#@photo_temp = PhotoTemp.new
	end

	def create
		@photo_temps = current_user.PhotoTemps.create(params[:photo_temp])
	end
end
