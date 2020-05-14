module Response

  STATUS_SUCCESS = 100..399

  def json_response(object, status = :ok, message = nil, page = {})
    render json: { data: set_object(object), page: page, meta: response_meta(message, status) }, status: status
  end

  def json_response_with_serializer(object, status = :ok, message = nil, page = {}, **options)
    serialized_object = ActiveModelSerializers::SerializableResource.new(set_object(object), options)
    serialized_object = serialized_object.as_json

    json_response(serialized_object, status, message, page)
  end

  def response_meta(message = nil, status = :ok)
    status_code = get_status_code(status)

    response = {
      "status": set_status_response(status_code),
      "code": status_code,
      "message": set_response_message(message, status_code)
    }

    return response
  end

  private

    def set_object(object)
      object = object || {}

      return object
    end

    def get_status_code(status)
      Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
    end

    def set_response_message(message, status_code)
      return Rack::Utils::HTTP_STATUS_CODES[status_code] if message.nil?

      message
    end

    def set_status_response(status_code)
      STATUS_SUCCESS.include? status_code.to_i
    end
end