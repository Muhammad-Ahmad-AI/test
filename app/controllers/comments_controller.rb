class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
    # @comment = current_user.comments.new(comment_params)
  end

  # GET /comments/1/edit
  def edit

  end

  # POST /comments or /comments.json
  def create
    # @comment = Comment.new(comment_params_p)
    @comment = current_user.comments.new(comment_params)
    if !@comment.save
      flash[:error] = @comment.errors.full_messages
    end
    if @comment.save
      redirect_to product_path(params[:product_id])
    end

    # @comment = Comment.new(comment_params)

    # respond_to do |format|
    # #   if @comment.save
    # #     format.html { redirect_to comment_url(@comment), notice: "Comment was successfully created." }
    # #     format.json { render :show, status: :created, location: @comment }
    # #   else
    # #     format.html { render :new, status: :unprocessable_entity }
    # #     format.json { render json: @comment.errors, status: :unprocessable_entity }
    # #   end
    # # end
    # @comment = @post.comments.create(comment_params)
    # respond_to do |format|
    #     if  @comment.save
    #         format.html { redirect_to @product, notice: 'Comment was successfully created.' }
    #         # NOTE COMMENT STEP 1: This will run the code in `app/views/comments/create.js.erb`.
    #         format.js
    #     else
    #         format.html { render action: "new" }
    #         # NOTE COMMENT STEP 1: This will run the code in `app/views/comments/create.js.erb`.
    #         format.js
    #     end
    # end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params_p

      params.require(:comment).permit(:content).merge(product_id: params[:product_id])
    end

    def comment_params

      params.permit(:content, :product_id)
    end

end
