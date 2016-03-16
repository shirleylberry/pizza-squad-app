class SlicesController < ApplicationController

  def destroy
    @slice = Slice.find(params[:id])
    @order = @slice.order
    @slice.destroy
    flash[:notice] = "Less pizza for you :-("
    redirect_to edit_event_order_path(@order.event, @order)
  end

end
