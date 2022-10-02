#imagem Ruby
FROM ruby:3.0.0

RUN apt-get clean all && apt-get update -qq && apt-get install -y build-essential libpq-dev \
    curl gnupg2 apt-utils default-libmysqlclient-dev git libcurl3-dev cmake \
    libssl-dev pkg-config openssl file

RUN mkdir /rails-app

WORKDIR /rails-app

RUN gem install rails

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install

COPY . /rails-app
