class Admin::StocksController < AdminController
  before_action :set_admin_stock, only: %i[ show edit update destroy ]

  # GET /admin/stocks or /admin/stocks.json
  def index
    @admin_stocks = Stock.where(product_id: params[:product_id])
  end

  # GET /admin/stocks/1 or /admin/stocks/1.json
  def show
  end

  # GET /admin/stocks/new
  def new
    @product = Product.find(params[:product_id])
    @admin_stock = Stock.new
  end

  # GET /admin/stocks/1/edit
  def edit
    @product = Product.find(params[:product_id])
    @admin_stock = Stock.find(params[:id])
  end

  # POST /admin/stocks or /admin/stocks.json
  def create
    @product = Product.find(params[:product_id])
    @admin_stock = @product.stocks.new(admin_stock_params)

    respond_to do |format|
      if @admin_stock.save
        format.html { redirect_to admin_product_stock_url(@product, @admin_stock), notice: "Stock was successfully created." }
        format.json { render :show, status: :created, location: @admin_stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/stocks/1 or /admin/stocks/1.json
  def update
    respond_to do |format|
      if @admin_stock.update(admin_stock_params)
        format.html { redirect_to admin_product_stock_url(@admin_stock.product, @admin_stock), notice: "Stock was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/stocks/1 or /admin/stocks/1.json
  def destroy
    @admin_stock.destroy!

    respond_to do |format|
      format.html { redirect_to admin_product_stocks_url, notice: "Stock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_stock
      @admin_stock = Stock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_stock_params
      params.require(:stock).permit(:size, :amount)
    end
end
