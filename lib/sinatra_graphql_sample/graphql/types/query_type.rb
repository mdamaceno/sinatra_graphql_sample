module SinatraGraphqlSample
  module Graphql
    module Types
      class QueryType < GraphQL::Schema::Object
        field :hello, resolver: SinatraGraphqlSample::Graphql::Queries::HelloQuery
      end
    end
  end
end
