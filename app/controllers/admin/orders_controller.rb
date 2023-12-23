class Admin::OrdersController < AdminController 
  before_action :set_admin_order, only: %i[ show edit update destroy ]

  # GET /admin/orders or /admin/orders.json
  def index
    @not_fulfilled_pagy, @not_fulfilled_orders = pagy(Order.where(fulfilled: false).order(created_at: :asc))
    @fulfilled_pagy, @fulfilled_orders = pagy(Order.where(fulfilled: true).order(created_at: :asc), page_param: :page_fulfilled)
  end

  # GET /admin/orders/1 or /admin/orders/1.json
  def show
  end

  # GET /admin/orders/new
  def new
    @admin_order = Order.new
  end

  # GET /admin/orders/1/edit
  def edit
  end

  # POST /admin/orders or /admin/orders.json
  def create
    @admin_order = Order.new(admin_order_params)

    respond_to do |format|
      if @admin_order.save
        format.html { redirect_to admin_order_url(@admin_order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @admin_order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/orders/1 or /admin/orders/1.json
  def update
    respond_to do |format|
      if @admin_order.update(admin_order_params)
        format.html { redirect_to admin_order_url(@admin_order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/orders/1 or /admin/orders/1.json
  def destroy
    @admin_order.destroy!

    respond_to do |format|
      format.html { redirect_to admin_orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_order
      @admin_order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_order_params
      params.require(:order).permit(:customer_email, :fulfilled, :total, :address)
    end
end
