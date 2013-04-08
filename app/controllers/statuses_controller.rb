class StatusesController < ApplicationController
	before_filter :signed_out_user, only: [:create, :destroy]
	before_filter :correct_user, only: :destroy

	def create
		@status = current_user.statuses.build(params[:status])
		if @status.save
			flash[:success] = "Status Created"
			redirect_to root_url
		else
			@feed_items = []
			render 'home/index'
		end
	end

	def show
	end

	def destroy
		@status.destroy
		redirect_to root_url
	end

	private
		def correct_user
			@status = current_user.statuses.find_by_id(params[:id])
		rescue
			redirect_to root_url
		end
end
