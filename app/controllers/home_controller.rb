class HomeController < ApplicationController
  def index
  end

  def user_login
  	if params[:username].present?
  	  user = User.find_by_username(params[:username])
  	  if user.present?
	  	  if user.timesheets.present? && user.timesheets.where("DATE(entry_time) = ?", Date.today)
  	  		flash[:error] = "You have already filled the timesheet for today."
	  	  else
	  	  	timesheet = user.timesheets.build
	  	  	timesheet.entry_time = Time.zone.now
	  	  	puts timesheet.entry_time
	  	  	timesheet.save
	  	  	puts timesheet
	  	  	if timesheet.entry_time.strftime('%H:%M') > "10:00"
	  	  	  flash[:error] = "You are late!! Logged in at #{timesheet.entry_time.strftime('%d-%m-%Y %H:%M')}"
	  	    else	
	  	  	  flash[:notice] = "Successfully logged in at #{timesheet.entry_time.strftime('%d-%m-%Y %H:%M')}"
	  	  	end  
	  	  end	
	  else
		flash[:notice] = "No such User"	  
	  end
	else
		flash[:error] = "Please enter User Name to login"
  	end
  	redirect_to home_index_path
  end

  def analytics
  	@users_today = Timesheet.where("DATE(entry_time) = ?", Date.today)
  	@average_time = nil
  	if @users_today.present?
  		total_times = @users_today.map{|x| x.entry_time.strftime('%H:%M').to_time.to_i}
  		avg_time = Time.at(total_times.inject(:+)/@users_today.count)
  		@average_time = avg_time.strftime('%H:%M')
  	end	
  end	
end
