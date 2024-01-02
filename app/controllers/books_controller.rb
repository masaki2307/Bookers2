class BooksController < ApplicationController
  
  def edit
    
    @book = Book.find(params[:id])
    
    unless current_user.id == @book.user.id
      
      redirect_to books_path
      
    end
    
  end
  
  

  def index
    
   
   @new_book= Book.new
   
   @books =Book.all
   
   @user = current_user
    
  end


  
  def show
    
    # @bookが足りないため新規作成のほうはnew_bookで代用
    @book = Book.find(params[:id])
    
    @user = @book.user
    
    @new_book = Book.new
    
  end 
  
  def destroy
    
    book = Book.find(params[:id])
    
    book.destroy
    
    redirect_to books_path
    
  end
  
  def create
    

    
    @new_book = Book.new(book_params)
    
    @user = current_user
    
    @books =Book.all
    
    @new_book.user_id = current_user.id
  

    if @new_book.save
      
       flash[:notice] = "You have created book successfully."
       
       redirect_to book_path(@new_book)
      
    else
    
      render :index
      
    end
  
  end
  
def update
   
  
  @book = Book.find(params[:id])
  
  if @book.update(book_params)
    
    flash[:notice] = "You have updated book successfully."
    
    redirect_to book_path(@book.id)
    
  else
    
    render :edit
    
  end
  
end
  
  private

  def book_params
    
    params.require(:book).permit(:title, :body)
    
  end
  
  
end
