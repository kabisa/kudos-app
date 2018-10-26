FROM ruby:2.5.1

# Install system packages
RUN wget -qO- https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Set working environment
ENV APP_HOME /code
ENV SCHEMA_HOME /schema
RUN mkdir $APP_HOME
RUN mkdir $SCHEMA_HOME
WORKDIR $APP_HOME

# Setup bundle
COPY Gemfile* $APP_HOME/
ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
  BUNDLE_JOBS=2 \
  BUNDLE_PATH=/bundle

# Install project dependencies
RUN bundle install
RUN npm install -g @2fd/graphdoc

# Setup project
COPY . .
COPY env.example .env
RUN bundle exec rake graphdoc:dump_schema
RUN graphdoc -s $SCHEMA_HOME/schema.json -o /docs --force || true 

# Start the server
CMD rm -f tmp/pids/server.pid && \
    echo "Setting up database" && \
    bundle exec rake db:create && \
    bin/rails db:migrate RAILS_ENV=development && \
    graphdoc --schema-file $SCHEMA_HOME/schema.json --output /docs --force || true && \
    echo "Running rails server..." && \
    bundle exec rails s
