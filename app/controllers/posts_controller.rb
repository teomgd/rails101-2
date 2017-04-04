class PostsController < ApplicationController

  before_action :authenticate_user!, :only => [:new, :create]

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to account_posts_path
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to account_posts_path
  end


  private

  def post_params
    params.require(:post).permit(:content)
  end

end
