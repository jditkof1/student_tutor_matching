class SessionsController < ApplicationController
  skip_before_action :keep_out_unless_logged_in, only: [:create, :clear, :debug]

  def clear
    session.clear
    redirect_to welcome_landing_path
  end

  def create
    @action = 'login'
    begin
      if Authorization.exists?(auth_hash) #login
        auth = Authorization.find_with_auth_hash(auth_hash)
        @user = User.find_with_auth_hash(auth_hash['info'])
        session[:user_id] = auth.user.id
        self.current_user= auth.user
        message = "Welcome back #{@user.name}! You have logged in via #{auth.provider}."
        flash[:notice] = message
        redirect_to subjects_path
      else #register
        @user = User.create_with_omniauth(auth_hash['info'])
        auth = Authorization.create_with_omniauth(auth_hash, @user)
        session[:user_id] = auth.user.id
        self.current_user= auth.user
        message = "Welcome #{@user.name}! You have signed up via #{auth.provider}."
        flash[:notice] = message
        @profile = @user.create_profile
        redirect_to edit_user_profile_path(@user,@profile)
      end
    rescue ActiveRecord::RecordInvalid,  Exception => exception
      flash[:warning] = "#{exception.class}: #{exception.message}"
      redirect_to welcome_landing_path
    end
    #debug
  end
  
  def debug
    puts '\n raw auth_hash\n'
    p @auth_hash
    puts '\n\nauth_hash by key\n'
    @auth_hash.each_pair do |key, value|
      puts "\nKEY: #{key}"
      if value.kind_of?(Hash)
        nested_hash(value, '')
      else
        puts "Value: #{value}"
      end
    end
    redirect_to welcome_landing_path
  end
  
  def failure
    begin
    rescue Exception => exception    
      flash[:warning] = "#{exception.class}:  #{exception.message}" 
      redirect_to welcome_landing_path
    end
  end

  def destroy
    message = "#{self.current_user.name} has logged out."
    self.current_user = nil
    session.delete(:user_id)
    flash[:notice] = message
    redirect_to welcome_landing_path
  end
    
  private
  
  def nested_hash nh, indent
    puts indent + "VALUE is a nested hash"
    indent += '  '
    nh.each_pair do |key, value|
      puts indent + "KEY: #{key}"
      if value.kind_of?(Hash)
        nested_hash(value, indent)
      else
        puts indent + "VALUE:  #{value}"
      end     
    end
  end
  
  def auth_hash
    #ensures that it's only retrieved once per cycle
    @auth_hash ||= request.env['omniauth.auth']
    p @auth_hash
  end
end
