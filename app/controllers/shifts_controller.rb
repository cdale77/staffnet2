class ShiftsController < ApplicationController


  def new
    @shift = Shift.new
  end

  def create
    @shift = Shift.new(shift_params)
    if @shift.save
      flash[:success] = 'Success.'
      redirect_to shift_path(@shift)
    else
      render 'new'
    end
  end



  private

    def shift_params
      params.require(:shift).permit()
    end
end