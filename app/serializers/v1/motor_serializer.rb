module V1
  class MotorSerializer
    include JSONAPI::Serializer
    ATTRIBUTES = %i[id seat_number motor_type brand number_plate color person_id].freeze
    attributes(*ATTRIBUTES)

    belongs_to :owner, serializer: V1::PersonSerializer
  end
end
