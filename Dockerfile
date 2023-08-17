FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y postgresql-client-15
RUN mkdir -p /opt/app
WORKDIR /opt/app
COPY Gemfile Gemfile.lock ./
RUN bundle install
CMD ["bundle", "exec", "rails", "c", "--", "--prompt", "simple"]