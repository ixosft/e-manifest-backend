class Company < ApplicationRecord
  include SoftDeletable
  include Searchable
end
