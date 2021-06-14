module SinatraGraphqlSample
  module Graphql
    module Queries
      class HelloQuery < GraphQL::Schema::Resolver
        type String, null: false

        def resolve
          'Ola'
        end
      end
    end
  end
end
