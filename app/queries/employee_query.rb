class EmployeeQuery
  def initialize(relation = Employee.all, params = {})
    @relation = relation
    @params = params
  end

  def self.call(relation = Employee.all, params = {})
    new(relation, params).call
  end

  def call
    filter_by_name
      .filter_by_personal_email
      .filter_by_corporate_email
      .filter_by_area
      .filter_by_role
      .filter_by_role_kind
      .filter_by_location
      .filter_by_company_tenure
      .filter_by_gender
      .filter_by_generation
      .filter_by_sub_team_id
      .paginate
      .relation
  end

  protected

  attr_reader :relation, :params

  def paginate
    return self unless params[:page].present?

    page = params[:page] || 1
    per_page = params[:per_page] || 25
    @relation = relation.page(page).per(per_page)
    self
  end

  def filter_by_name
    return self unless params[:name].present?

    @relation = relation.where("name ILIKE ?", "%#{params[:name]}%")
    self
  end

  def filter_by_personal_email
    return self unless params[:personal_email].present?

    @relation = relation.where("personal_email ILIKE ?", "%#{params[:personal_email]}%")
    self
  end

  def filter_by_corporate_email
    return self unless params[:corporate_email].present?

    @relation = relation.where("corporate_email ILIKE ?", "%#{params[:corporate_email]}%")
    self
  end

  def filter_by_area
    return self unless params[:area].present?

    @relation = relation.where(area: params[:area])
    self
  end

  def filter_by_role
    return self unless params[:role].present?

    @relation = relation.where(role: params[:role])
    self
  end

  def filter_by_role_kind
    return self unless params[:role_kind].present?

    @relation = relation.where(role_kind: params[:role_kind])
    self
  end

  def filter_by_location
    return self unless params[:location].present?

    @relation = relation.where(location: params[:location])
    self
  end

  def filter_by_company_tenure
    return self unless params[:company_tenure].present?

    @relation = relation.where(company_tenure: params[:company_tenure])
    self
  end

  def filter_by_gender
    return self unless params[:gender].present?

    @relation = relation.where(gender: params[:gender])
    self
  end

  def filter_by_generation
    return self unless params[:generation].present?

    @relation = relation.where(generation: params[:generation])
    self
  end

  def filter_by_sub_team_id
    return self unless params[:sub_team_id].present?

    @relation = relation.where(sub_team_id: params[:sub_team_id])
    self
  end
end
