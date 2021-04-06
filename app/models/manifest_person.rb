class ManifestPerson < ApplicationRecord
  attribute :total_trip_to, :integer, default: 0
  attribute :people_count, :integer, default: 0
  attribute :total_motors, :integer, default: 0
  attribute :total_terminal, :integer, default: 0
  attribute :total_people, :integer, default: 0
  attribute :total_companies, :integer, default: 0
  attribute :total_users, :integer, default: 0

  belongs_to :person
  belongs_to :manifest
end
