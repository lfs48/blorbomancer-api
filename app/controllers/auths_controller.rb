class AuthsController < ApplicationController
  
    def login
      @user = User.authenticate( user_params[:username], user_params[:password] )
      if @user
        @token = token(@user)
        render "auth/show", status: :ok
      else 
        @errors = {form: [ "Incorrect username or password" ] };
        render "errors/show", status: :unprocessable_entity
      end 
    end

    def register
      @user = User.new(user_params)
      if @user.save
          @token = token(@user)
          render "auth/show", status: :created
      else
          @errors = @user.errors
          render "errors/show", status: :unprocessable_entity
      end
    end

    def logout
        @user = User.new(user_params)
        if @user.save
            @token = token(@user)
            render "auth/show", status: :created
        else
            @errors = @user.errors
            render "errors/show", status: :unprocessable_entity
        end
      end
  
    private 
    def user_params
      params.require(:user).permit(:username, :password)
    end

  end