module Utility
  module Object
    def states
      STATE_LGTS.map { |state| state[:state] }
    end

    def states_lgts
      STATE_LGTS.each_with_object({}) { |state, hash| hash[state[:state].downcase] = state[:lgas].map(&:downcase) }
    end

    def validate_state_lgt(state, lgt)
      states_lgts[state.to_s.downcase].present? && states_lgts[state.to_s.downcase].include?(lgt.to_s.downcase)
    end
  end
end
