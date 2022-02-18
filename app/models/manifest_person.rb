class ManifestPerson < ApplicationRecord
  include Searchable
  attribute :total_trip_to, :integer, default: 0
  attribute :people_count, :integer, default: 0
  attribute :total_motors, :integer, default: 0
  attribute :total_terminal, :integer, default: 0
  attribute :total_people, :integer, default: 0
  attribute :total_companies, :integer, default: 0
  attribute :total_users, :integer, default: 0

  belongs_to :person, touch: true
  belongs_to :manifest
  belongs_to :destination_terminal, class_name: 'Terminal', foreign_key: 'destination_terminal_id'
  belongs_to :source_terminal, class_name: 'Terminal', foreign_key: 'source_terminal_id'

  before_create do
    self.ticket_uid = "#{Time.now.to_i}#{rand(1..100)}"
  end

  def destination_state_terminal
    [destination_state, destination_terminal.name].compact.join(' ')
  end
end
