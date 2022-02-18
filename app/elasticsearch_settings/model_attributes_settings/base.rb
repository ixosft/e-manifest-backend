module ModelAttributesSettings
  module Base
    MAPPING_EDGE_NGRAM =
      {
        index: {
          analysis: {
            filter: {
              autocomplete_filter: {
                type: 'edge_ngram',
                min_gram: 1,
                max_gram: 20
              }
            },
            analyzer: {
              autocomplete: {
                type: 'custom',
                tokenizer: 'standard',
                filter: %w[lowercase autocomplete_filter]
              }
            }
          }
        }
      }.freeze

    CUSTOM_ANALYZER =
      {
        number_of_shards: 1,
        number_of_replicas: 0,
        analysis: {
          analyzer: {
            pattern: {
              type: 'pattern',
              pattern: '\\s|_|-|\\.',
              lowercase: true
            },
            trigram: {
              tokenizer: 'trigram'
            }
          },
          tokenizer: {
            trigram: {
              type: 'ngram',
              min_gram: 3,
              max_gram: 3,
              token_chars: %w[letter digit]
            }
          }
        }
      }.freeze
  end
end
