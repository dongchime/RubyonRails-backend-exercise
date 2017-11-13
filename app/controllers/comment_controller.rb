class CommentController < ApplicationController
  
  before_action :authenticate_user!
  
  def new
    @_id = params[:id]
    
  end

  def create
    _id = params[:id]
    _contents = params[:contents]
    
    _post = Post.find(_id)
    
    _comment = Comment.new(post: _post, contents: _contents)
    _comment.user = current_user
    _comment.save
    
    redirect_to controller: 'post', action: 'list'
    
  end

  def delete
    _id = params[:id]
    
    _comment = Comment.find(_id)
    
    _comment.destroy
    
    redirect_to controller: 'post', action: 'list'
  end
end
