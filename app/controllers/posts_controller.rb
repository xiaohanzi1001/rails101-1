class PostsController < ApplicationController

  before_action :authenticate_user!, :only => [:new, :create]

def index
@posts = Post.all
end

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

def destroy
  @post = Post.find(params[:id])
  @post.destroy
  flash[:alert] = "Group deleted"
  redirect_to account_posts_path
end

def edit
  @group = Group.find(params[:group_id])
  @post = Post.find(params[:id])
end

def udpate
  @post = Post.find(params[:id])
  if @post.update(post_params)
    redirect_to account_posts_path, notice: "Update Success"
  else
    render :edit
end
end

private

def post_params
  params.require(:post).permit(:content)
end
end
