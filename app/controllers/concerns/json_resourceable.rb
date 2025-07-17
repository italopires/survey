module JsonResourceable
  extend ActiveSupport::Concern

  included do
    before_action :set_resource, only: %i[show update destroy]

    rescue_from ActiveRecord::RecordNotFound, with: :not_found
  end

  # :nocov:
  def index
    render json: fetch_collection
  end

  def create
    set_resource_with_params
    save_and_render_resource
  end

  def update
    update_resource
    save_and_render_resource
  end

  def show
    render_resource
  end

  def destroy
    if resource.respond_to?(:discard)
      resource.discard!
    else
      resource.destroy!
    end
    head :no_content
  end

  private

  def resource_class
    controller_name.classify.constantize
  end

  def resource
    @resource
  end

  def build_resource
    @resource = resource_class.new
  end

  def update_resource
    @resource.assign_attributes(resource_params)
  end

  def set_resource
    @resource = resource_class.find(params[:id])
  end

  def set_resource_with_params
    @resource = resource_class.new(resource_params)
  end

  def serializer_klass
    "#{resource_class}Serializer".constantize
  end

  def render_resource
    render json: resource, each_serializer: serializer_klass
  end

  def fetch_collection
    resource_class.all
  end

  def save_and_render_resource
    success_state = resource.persisted? ? :ok : :created
    if resource.save
      render json: resource, status: success_state
    else
      render json: { errors: resource.errors }, status: :unprocessable_entity
    end
  rescue ActiveRecord::StaleObjectError
    render json: resource, status: success_state
  end

  def not_found(error)
    render json: { error: error.message }, status: :not_found
  end

  def resource_params
    raise NotImplementedError
  end
  # :nocov:
end
