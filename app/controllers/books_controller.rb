class BooksController < ApplicationController
    before_action :authenticate_user!
    before_action :signed_in_user, only: [:edit, :update, :destroy]
    before_action :correct_user, only: [:edit, :update, :destroy]

    def create
    	@book_new = Book.new(book_params)
    	@book_new.user_id = current_user.id
	    if  @book_new.save(book_params)
        	flash[:notice] = "投稿を作成しました successfully"
        	redirect_to book_path(@book_new.id)
        else
            @books = Book.all
            @user = current_user
            render "index"
        end
    end

    def index
    	@books = Book.all
        @book_new = Book.new
        @user = current_user
    end

    def show
    	@book_new = Book.new
    	@book = Book.find(params[:id])
        @user = @book.user
    end

    def edit
    	@book = Book.find(params[:id])
        @user = current_user
    end

    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
    	    flash[:notice] = "投稿を修正しました successfully"
    	    redirect_to book_path
        else
            render 'edit'
        end
    end

    def destroy
    	book = Book.find(params[:id])
    	book.destroy
    	redirect_to books_path
    end

    private
    def book_params
    	params.require(:book).permit(:title, :body)
    end

    def correct_user
        @book = Book.find(params[:id])
        if @book.user_id != @current_user.id
           redirect_to books_path
        end
    end

    def signed_in_user
        @book = current_user
    end
end




