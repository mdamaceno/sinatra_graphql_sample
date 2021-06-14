module SinatraGraphqlSample
  module Graphql
    include Types

    module Schema
      class SinatraGraphqlSampleSchema < GraphQL::Schema
        query SinatraGraphqlSample::Graphql::QueryType
        # mutation Types::MutationType
      end
    end
  end
end
