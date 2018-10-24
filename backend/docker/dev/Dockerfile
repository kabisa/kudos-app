FROM ruby:2.5.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /code
WORKDIR /code

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install

COPY . .

CMD rm -f tmp/pids/server.pid && \
    rake db:create && \
    bin/rails db:migrate RAILS_ENV=development && \
    echo "Running rails server..." && \
    bundle exec rails s
