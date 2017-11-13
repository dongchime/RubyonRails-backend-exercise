class PostController < ApplicationController
  
  before_action :authenticate_user!, except: [:list]  ## devise 에서 제공하는것, authenticate_user가 아니면 자동으로 로그인화면으로 넘어감
  
  # CREATE (CRUD)
  def create
    _title = params[:title]
    _contents = params[:contents]
    _lat = params[:lat]
    _lng = params[:lng]
    _address = params[:address]
    
    _post = Post.new(title: _title, contents: _contents) # DB에 넣을걸 암시? (record)
    _post.user = current_user
    _post.lat = _lat
    _post.lng = _lng
    _post.address = _address
    _post.save # 실제로 DB에 저장
    
    redirect_to controller:'post', action:'list'
    
  end

  def new
    
  end
  # CREATE END
  
  # READ 
  def list
    @post = Post.all.paginate(page: params[:page], per_page: 5)
    
  end
  
  # UPDATE
  def modify    #양식(form) 만드는 용
    _id = params[:id]
    @post = Post.find(_id)
    
    authorize_action_for @post
  end
  
  def update
    _id = params[:id]
    _title = params[:title]
    _contents = params[:contents]
    
    @post = Post.find(_id)    # 우리가 수정할 것의 id값을 찾음
    
    authorize_action_for @post
    
    @post.id = _id
    @post.title = _title
    @post.contents = _contents
    
    @post.save
    
    redirect_to controller:'post', action:'list'
  end
  # UPDATE END
  
  # DELETE
  def delete
    _id = params[:id]
    
    @post = Post.find(_id)
    
    authorize_action_for @post
    
    @post.destroy
    
    redirect_to controller:'post', action:'list'
  end
  
end
