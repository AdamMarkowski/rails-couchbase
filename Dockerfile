FROM ruby:2.4.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs cmake
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install

# Set Rails to run in production
# ENV RAILS_ENV production
# ENV RACK_ENV production

ADD . /app

# RUN bundle exec rake assets:precompile
