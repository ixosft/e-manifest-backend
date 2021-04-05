module V1
  class MotorSerializer
    include JSONAPI::Serializer
    ATTRIBUTES = %i[id model brand chasis_number number_plate year color person_id].freeze
    attributes(*ATTRIBUTES)

    belongs_to :onwer, serializer: V1::PersonSerializer
  end
end
