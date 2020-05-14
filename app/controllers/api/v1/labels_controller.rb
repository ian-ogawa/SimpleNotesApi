class Api::V1::LabelsController < Api::ApplicationController

  before_action :set_label, only: [:show, :update, :destroy]

  def index
    labels = Label.all
    # json_response({ labels: labels }, :unprocessable_entity)
    json_response_with_serializer(labels, { adapter: :json, root: "labels" })
  end

  def show
    json_response_with_serializer(@label, @label.nil? ? :not_found : :ok, { adapter: :json, root: "labels" })
  end

  def create
    label = Label.new(labels_params)

    label.save ? json_response_with_serializer(label, :created, { adapter: :json, root: "labels" }) : json_response({ label: {} }, :unprocessable_entity, label.errors)
  end

  def update
    if @label.present?
      @label.update(labels_params) ? json_response_with_serializer(@label, { adapter: :json, root: "labels" }) : json_response({ label: {} }, :unprocessable_entity, @label.errors)
    else
      json_response({ label: {} }, :not_found)
    end
  end

  def destroy
    if @label.present?
      @label.destroy ? json_response({ label: {} }, :ok) : json_response({ label: {} }, :unprocessable_entity, "Failed please try again later")
    else
      json_response({ label: {} }, :not_found)
    end
  end

  private

  def labels_params
    params.require(:labels).permit(:id, :name)
  end

  def set_label
    @label = Label.find_by(id: params[:id])
  end

end