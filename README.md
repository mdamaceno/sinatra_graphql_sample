# Sinatra GraphQL Sample

Simple structure to build apps with Sinatra, GraphQL and MongoDB.

## Requirements

- Docker
- Docker Compose
- Ruby 2.7

## Usage

Create a file `.env.development` with the following content:

```
MONGO_URL=mongodb://root:12345@127.0.0.1:27017/change_the_database_name
```

### Installation

```
bundle install
```

### Run

```
docker-compose up -d
bundle exec rackup
```
