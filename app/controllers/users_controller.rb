class UsersController < ApplicationController
helper_method :user_params, :user_posts?

  def new
    @user = User.new
  end

  def confirm
    @user = User.new
    p params
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
  end


  def create
    p params
    @user = User.new
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.save
      flash[:notice] = "Welcome to Bloccit #{@user.name}!"
      create_session(@user)
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error creating your account. Please try again."
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


  def show
    @user = User.find(params[:id])
    @posts = @user.posts.visible_to(current_user)
  end

  def user_posts?

    unless @user.posts? || @user.comments?

      flash[:alert] = "\"{@user.name}\" has not submitted any posts yet."
      redirect_to [post.topic, post]
    end
  end
end
