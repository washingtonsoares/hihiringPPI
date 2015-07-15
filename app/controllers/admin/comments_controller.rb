class Admin::CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @admin_comments = Admin::Comment.all
    respond_with(@admin_comments)
  end

  def show
    respond_with(@comment)
  end

  def new
    @comment = Admin::Comment.new
    respond_with(@comment)
  end

  def edit
  end

  def create
    @publication = Admin::Publication.find(params[:publication_id])
    @comment = @publication.admin_comments.create(params[:admin_comment].permit(:comment, :user_id))
  end

  def update
    flash[:notice] = 'Admin::Comment was successfully updated.' if @admin_comment.update(comment_params)
    respond_with(@comment)
  end

  def destroy
    @comment = Admin::Comment.find(params[:id])
    @comment.destroy
  end

  private
    def set_comment
      @comment = Admin::Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:comment, :publication_id, :user_id)
    end
end
