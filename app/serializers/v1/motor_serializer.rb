module V1
  class MotorSerializer
    include JSONAPI::Serializer
    ATTRIBUTES = %i[id model brand chasis_number number_plate year color].freeze
    attributes(*ATTRIBUTES)
  end
end
