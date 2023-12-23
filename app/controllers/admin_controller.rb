class AdminController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @orders = Order.where(fulfilled: false).order(created_at: :desc).take(5)
    @quick_stats = { 
      sales: Order.where(created_at: Time.now.midnight..Time.now).count,
      revenue: Order.where(created_at: Time.now.midnight..Time.now).sum(:total)&.round(),
      avg_sale: Order.where(created_at: Time.now.midnight..Time.now).average(:total)&.round(),
      per_sale: OrderProduct.joins(:order).where(orders: { created_at: Time.now.midnight..Time.now })&.average(:quantity)
    }
    @orders_by_day = Order.where('created_at > ?', Time.now - 7.days).order(:created_at)
    @orders_by_day = @orders_by_day.group_by { |order| order.created_at.to_date }
    @revenue_by_day = @orders_by_day.map { |day, orders| [day.strftime("%A"), orders.sum(&:total)] }
    if @revenue_by_day.count < 7
      days_of_week = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

      data_hash = @revenue_by_day.to_h
      current_day = Date.today.strftime("%A")
      current_day_index = days_of_week.index(current_day)
      next_day_index = (current_day_index + 1) % days_of_week.length

      ordered_days_with_current_last = days_of_week[next_day_index..-1] + days_of_week[0...next_day_index]

      complete_ordered_array_with_current_last = ordered_days_with_current_last.map{ |day| [day, data_hash.fetch(day, 0)] }

      @revenue_by_day = complete_ordered_array_with_current_last 
    end
  end
end
