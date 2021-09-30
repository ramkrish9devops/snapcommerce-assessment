FROM ruby:2.7.2-alpine as builder

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
RUN apk update && apk add --no-cache build-base && gem install bundler -v 2.1.4 && gem install racc -v '1.5.2' && \
    apk add --update alpine-sdk sqlite-dev tzdata && rm -rf /var/cache/apk/*

COPY . $APP_HOME

RUN bundle install

EXPOSE 5000:5000

CMD rm -f tmp/pids/server.pid \
  && bundle exec rails server -b 0.0.0.0 -p 5000

