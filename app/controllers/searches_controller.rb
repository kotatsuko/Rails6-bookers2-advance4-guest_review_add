class SearchesController < ApplicationController


  before_action :authenticate_user!

  def search
    @range = params[:range]
    @order = params[:order]

    if @order == "New"

      if @range == "User"
        @users = User.looks(params[:search], params[:word])
        @word=params[:word]
      elsif @range == "Book"
        @books = Book.looks(params[:search], params[:word])
        @word=params[:word]
      elsif @range == "Tag"
        @tags = Tag.looks(params[:search], params[:word])
        @word=params[:word]
      end

    elsif @order == "Old"

      if @range == "User"
        users = User.looks(params[:search], params[:word])
        @users = user.order(id: "DESC")
        @word=params[:word]
      elsif @range == "Book"
        books = Book.looks(params[:search], params[:word])
        @books = books.order(id: "DESC")
        @word=params[:word]
      elsif @range == "Tag"
        tags = Tag.looks(params[:search], params[:word])
        @tags = tags.order(id: "DESC")
        @word=params[:word]
      end

    elsif @order == "Popular"

      if @range == "User"
        users = User.looks(params[:search], params[:word])
        @users=users.includes(:followers).sort {|a,b| b.followers.size <=> a.followers.size}
        @word=params[:word]
      elsif @range == "Book"
        books = Book.looks(params[:search], params[:word])
        @books=books.includes(:favorites).sort {|a,b| b.favorites.size <=> a.favorites.size}
        @word=params[:word]
      elsif @range == "Tag"
        tags = Tag.looks(params[:search], params[:word])
        @tags = tags.includes(:books).sort {|a,b| b.books.size <=> a.books.size}
        @word=params[:word]
      end

    end
  end


  def tag_search
    @tag = Tag.find(params[:tag_id])
    @books = @tag.books.all
  end


  def search_favorited_desc

  end


end
