class ExpensesController < ApplicationController
  def create
    group_id = params[:group_id]
    if @expense.save
      Record.create(group_id:, expense_id: @expense.id)
      flash[:notice] = 'Expense saved successfully'
    else
      flash[:alert] = 'Expense not saved'
    end
    redirect_to group_expenses_path(group_id)
  end

  def index
    @group = current_user.groups.find(params[:group_id])
    @expenses = @group.expenses
  end

  def new
    @group = Group.find(params[:group_id])
    @expense = Expense.new
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
