class Person < ApplicationRecord
  include SoftDeletable
  include Searchable
  enum sex: { male: 1, female: 2 }
  enum person_type: { passenger: 1, driver: 2, assistant_driver: 3, conductor: 4 }
  # TODO: delete manifest on destroy
  has_many :manifest_people
  after_update { manifest_people.each(&:touch) }

  SEARCHABLES = %i[id full_name number person_type next_of_kin_name].freeze

  settings MAPPING_EDGE_NGRAM.to_h.deep_dup do
    mapping do
      indexes :next_of_kin_name
      indexes :number
    end
  end

  settings CUSTOM_ANALYZER.to_h.deep_dup do
    mapping do
      indexes :full_name, type: 'text', analyzer: 'english' do
        indexes :keyword, analyzer: 'keyword'
        indexes :pattern, analyzer: 'pattern'
        indexes :trigram, analyzer: 'trigram'
      end
    end
  end

  def as_indexed_json(_options = {})
    as_json(only: SEARCHABLES, include: { manifest_people: { methods: [:destination_state_terminal], only: :destination_state } })
  end
end
