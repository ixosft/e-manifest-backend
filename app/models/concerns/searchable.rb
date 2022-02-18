module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    include ModelAttributesSettings::Base
    Elasticsearch::Model.client = Elasticsearch::Client.new log: true

    # TODO: after commit indexing should be done in a priorty background job
    # https://github.com/elastic/elasticsearch-rails/tree/master/elasticsearch-model#asynchronous-callbacks
    after_commit :index_document, if: :persisted?
    after_touch { __elasticsearch__.index_document }
    after_commit on: [:destroy] do
      __elasticsearch__.delete_document
    end
  end

  def self.search(query, filters, to_array = true)
    # a lambda function adds conditions to a search definition
    set_filters = lambda do |context_type, filter|
      @search_definition[:query][:bool][context_type] |= [filter]
    end

    @search_definition = {
      # we indicate that there should be no more than 5 documents to return
      size: 5,
      # we define an empty query with the ability to
      # dynamically change the definition
      # Query DSL https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl.html
      query: {
        bool: {
          must: [],
          should: [],
          filter: []
        }
      }
    }

    # match all documents
    if query.blank?
      set_filters.call(:must, match_all: {})
    else
      set_filters.call(
        :must,
        multi_match: {
          "query": query,
          "fields": SEARCHABLES,
          "fuzziness": 'auto'
        }
      )
    end

    # the system will return only those documents that pass this filter
    set_filters.call(:filter, term: { person_type: filters[:person_type] }) if filters[:person_type].present?

    results = __elasticsearch__.search(@search_definition)
    to_array ? results.records.to_a : results.records
  end

  private

  def index_document
    __elasticsearch__.index_document
  end
end
