class ManifestPerson < ApplicationRecord
  belongs_to :person
  belongs_to :manifest
end
