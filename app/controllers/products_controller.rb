class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy,:my_products]
  skip_before_action :verify_authenticity_token
  # before_action :filter_products, only: [:my_products]

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show
    @comments = Comment.where(product_id: @product.id)
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    @products = Product.where("name LIKE ?", "%#{params[:q]}%")
    render :index
  end

  def search_by_category
    @products = Product.where("category LIKE ?", "%#{params[:q]}%")
    render :index
  end

  # def my_products
  # end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def authenticate_user!
      if !user_signed_in?
        redirect_to new_user_session_path
      end
    end

    def filter_products
      @products = Product.where(user_id: current_user.id)
    end
    
    def set_post
      @post = Post.with_attached_other_images.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :description, :picture, :quantity, :price, :user_id,
         :main_image, other_images: [])
    end
end
