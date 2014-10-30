class OpenedAndClickedController < ApplicationController
	def open
	   act=params[:act]
	   if act.to_i==1
	   	#opened
	   	email=params[:email]
	   	opened=EmailStatus.select(:opened).where(:email_id=>email).first.to_i+1
	   	EmailStatus.where(:email_id=>email).updateAttributes(:opened=>opened)
	   elsif act.to_i==2
	   	#clicked
	   	email=params[:email]
	   	clicked=EmailStatus.select(:opened).where(:email_id=>email).first.to_i+1
	   	EmailStatus.where(:email_id=>email).updateAttributes(:clicked=>clicked)
	   end
	   	
	   render :json => @reportcard
	end
end
