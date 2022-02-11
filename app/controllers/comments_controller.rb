class CommentsController < ApplicationController
  before_action :set_blog, only: %i[ create edit update destroy ]
  before_action :set_comment, only: %i[ edit update destroy ]
  before_action :author_required, only: %i[ edit update destroy ]

  def create
    @comment = @blog.comments.build(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        flash[:notice] = "投稿しました!"
        format.js { render :index }
        # format.html { redirect_to blog_path(@blog) }
      else
        format.html { redirect_to blog_path(@blog), notice: "投稿できませんでした..."}
      end
    end
  end

  def edit
    respond_to do |format|
      flash.now[:notice] = "コメントの編集中"
      format.js { render :edit }
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        flash.now[:notice] = "コメントが編集されました"
        format.js { render :index }
      else
        flash[:notice] = "コメントの編集に失敗しました"
        format.js { render :edit }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      flash[:notice] = "コメントが削除されました"
      format.js { render :index }
      # format.html { redirect_to blog_path(@blog) }
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
  def set_blog
    @blog = Blog.find(params[:blog_id])
  end
  def set_comment
    @comment = Comment.find(params[:id])
  end
  def author_required
    redirect_back fallback_location: blogs_path unless @comment.user == current_user
  end
end
