class EmployeesController < ActionController::API
  include JsonResourceable

  def index
    employees = EmployeeQuery.call(Employee.all, filter_params)
    render json: employees
  end

  private

  def filter_params
    params.permit(*all_params)
  end

  def resource_params
    params.require(:employee).permit(*all_params)
  end

  def all_params
    [
      :name, :personal_email, :corporate_email, :area,
      :role, :role_kind, :location, :company_tenure, :gender, :generation,
      :sub_team_id, :page, :per_page
    ]
  end
end
