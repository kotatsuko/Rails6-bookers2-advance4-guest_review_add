class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    @book_tags = @book.tags
    @book_comment=BookComment.new
  end

  def index
    @tag_list=Tag.all
    @book=Book.new
    @books = Book.all
    @books_favorited_desc=Book.find(Favorite.group(:book_id).order('count(book_id) desc').pluck(:book_id))
  end

  def index_favorited_desc
    @tag_list=Tag.all
    @book=Book.new
    @books= Book.includes(:favorites).sort {|a,b| b.favorites.size <=> a.favorites.size}
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    tag_list=params[:book][:name].split(nil)
    if @book.save
      @book.save_tag(tag_list)
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user==current_user
      render book_path(@book.id)
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body,:star)
  end
end
