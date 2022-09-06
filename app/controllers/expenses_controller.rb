class ExpensesController < ApplicationController
  def create
    if @expense.save
      flash[:notice] = 'Expense saved successfully'
    else
      flash[:alert] = 'Expense not saved'
    end
    redirect_to group_expenses_path(group_id: params[:group_id])
  end

  def index
    current_user.expenses
  end

  def new
    # implement
  end

  def show
    # implement
  end

  private

  def expense_params
    params.require(:expense).merge({ user_id: current_user.id })
      .permit(:user_id, :name, :amount)
  end
end
