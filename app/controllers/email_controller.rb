class EmailController < ApplicationController
    include EmailHelper
    before_filter :authenticate_user!
	def index
		@host_url="http://localhost:4000"
		@account_lists=AccountList.select("id")
		@accounts=Account.all
		@state=Account.select("state").group(:state)
		@age=Account.select("age").order(:age)
		@salary=Account.select("salary").order("length(salary)").group(:salary)
		@gender=Account.select("gender").group(:gender)
		@f = current_user.email
	end
	def reportcart
	   email=params[:id]
	   reportcard = files
	   #action to view
	   PrivatePub.publish_to("/messages/new", "$('.up-file_report').html('<div>#{reportcard.to_s}</div>')")
	   render :json => reportcard
	end
	
	def files
		@line=""
		File.open("/var/log/mail.log", "r").each do |line|
          @line =line[0,line.length-1]+"</br>"+@line+"</br>"  #line.index('stat').to_i
      end
      File.open('/var/log/mail.log', 'w') {|file| file.truncate(0) }
      return @line	
    end
	def delete_email_file
		AccountsFile.destroy(params[:id])
		render :json => params[:id]
	end
	def save_template
		Template.create(:code=>params[:code],:text_code=>params[:code])
		render :json=>params[:code]
	end
	def email_store
		@pwd=Dir.pwd+"/public"+AccountsFile.find(params[:id]).email_file.url
		xls = Creek::Book.new(@pwd)
		sheet= xls.sheets[0]
		count=0
			@ecount=0
			@user_info=Array.new
			ecol=0
			sheet.rows.each do|xl|
				@ecount=@ecount+1
				@user_info=Array.new	
				xl.each do |x|
		         	if count==0
		         		ecol = ecol+1
		         	else
		         		@user_info.push(x[1].to_s)	
		         	end
		         end
		         if count >0
		         	#Thread.new{
		         	begin
		         		Account.create(:name=>@user_info[0].to_s,
		         				:email_address=>@user_info[1].to_s,
		         				:email_id=>params[:id]
		                )
		                PrivatePub.publish_to("/messages/new", "$('.up-file_report').html('<div>#{@user_info[1].to_s}</div>')")
		         	rescue
		         		next
		         	end
		         	#}
		         end
		         
		         count=count+1
		     end
		
		render :json=>params[:id]
	end
	def save_list
		name=params[:name]
		@data=params[:id].split(",")
		@list=params[:id].split(",")
		AccountList.create(:name=>name)
		@list.each do |item|
			if item.to_s.to_i>0  
			   JoinAccountList.create(:account_list_id=>AccountList.last.id,
			   	:account_id=>item)
			   PrivatePub.publish_to("/messages/new", "$('.up-file_report').html('<div>#{item.to_s}</div>')")
		    end
		end
		render :json => @list
	end
	def select_list
		@data=params[:id].split(",")
		session[:list]=params[:id].split(",")
	end
	def broadcast	
		to =params[:to]
		@list=session[:list]
		from=params[:user["address"]]
		message=params[:message]
		subject=params[:subject]
		@name=params[:name]
		@f = current_user.email
		Email.create(:name=>@name,:message=>message,:from=>@f,:subject=>subject)
		@users=Array.new
		accounts=Array.new
		accounts=Email.last.accounts.to_a
			@users=AccountList.find(to).account
			@users.each do|user|
			#Thread.new{
			accounts.push(user.id.to_s)
			    #Email.last.update_attributes(:accounts=>accounts)
				UserMailer.welcome_email(user,subject,message,from).deliver		
			#}
			end
		
		render :json => @users
	end
	def filter
		#@result=Array.new
		@age_from=params[:age_from]
		@age_to=params[:age_to]
		@salary_from=params[:salary_from]
		@salary_to=params[:salary_to]
		@gender=params[:gender]
		@state=params[:state]
		if @state.length >1
			if @gender.length >0
			  @result=Account.where("SALARY >= ? AND SALARY <= ? AND AGE >= ? AND AGE <= ? AND GENDER=? AND STATE=?",@salary_from,@salary_to,@age_from,@age_to,@gender,@state).all		
			else
              @result=Account.where("SALARY >= ? AND SALARY <= ? AND AGE >= ? AND AGE <= ? AND STATE=?",@salary_from,@salary_to,@age_from,@age_to,@state).all
			end
		else
			if @gender.length >0
			  @result=Account.where("SALARY >= ? AND SALARY <= ? AND AGE >= ? AND AGE <= ? AND GENDER=?",@salary_from,@salary_to,@age_from,@age_to,@gender).all	
			else
              @result=Account.where("SALARY >= ? AND SALARY <= ? AND AGE >= ? AND AGE <= ?",@salary_from,@salary_to,@age_from,@age_to).all
			end 
		end
		render :json => @result
	end
end
