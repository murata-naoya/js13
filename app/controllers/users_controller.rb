class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :correct_user, only: [:edit, :update]
    before_action :set_user, only: [:edit, :update]


  def index
    @user = current_user
  	@users = User.all
    @book_new = Book.new
  end

  def show
  	@user = User.find(params[:id])
  	@books = Book.all
    @book_new = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update (user_params)
      flash[:notice] = "ユーザー情報を修正しました successfully"
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  # ----------------------------------------------------------
  def correct_user
      user = User.find(params[:id])
      if current_user != user
      redirect_to user_path (current_user)
      end
  end
  # ----------------------------------------------------------

  def set_user
    @user = User.find(params[:id])
  end

end






