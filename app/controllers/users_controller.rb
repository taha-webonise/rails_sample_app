class UsersController < ApplicationController
  before_action :signed_in_user, only: [:list, :edit_member, :update_member, :destroy_member, :following, :followers]
  before_action :correct_user, only: [:edit_member, :update_member]
  before_action :admin_user, only: :destroy_member

  def list
    @users = User.paginate(page: params[:page])
  end
  
  def display
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new_member
  	@user = User.new
  end

  def create_member
    @user = User.new(user_params)
    if @user.save
      sign_in @user
   	  flash[:success] = "Welcome to the Sample App!"
      redirect_to display_user_path @user
    else
      render 'new_member'
    end
  end

  def edit_member
  	@user = User.find(params[:id])
  end

  def update_member
  	@user = User.find(params[:id])
  	if @user.update_attributes(user_params)
  	  flash[:success] = "Profile updated"
  	  redirect_to display_user_path @user
  	else
  	  render 'edit_member'
  	end
  end

  def destroy_member
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to list_users_path
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Before filters
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end