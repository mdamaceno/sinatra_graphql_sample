module SinatraGraphqlSample
  include Graphql::Schema

  class Api < Sinatra::Base
    PUBLIC_PATH = File.join(AppEnvironment::ROOT_PATH, 'lib', 'sinatra_graphql_sample', 'public')

    set :static, true
    set :public_folder, PUBLIC_PATH

    before do
      content_type :json
    end

    get '/ui' do
      content_type :html
      File.read(File.join(PUBLIC_PATH, 'ui', 'index.html'))
    end

    get '/graphql' do
      query = params['query']
      variables = params['variables']
      result = SinatraGraphqlSample::SinatraGraphqlSampleSchema.execute(query, variables: JSON.parse(variables))
      result.to_json
    end

    post '/graphql' do
      pass unless request.content_type =~ /application\/graphql/
      query = request.body.read
      result = SinatraGraphqlSample::SinatraGraphqlSampleSchema.execute(query)
      result.to_json
    end

    post '/graphql' do
      params = JSON.parse(request.body.read)
      query = params['query']
      variables = params['variables']
      result = SinatraGraphqlSample::SinatraGraphqlSampleSchema.execute(query, variables: variables)
      result.to_json
    end
  end
end
