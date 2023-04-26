FROM ruby:3.0-alpine

RUN gem install bundler:2.3.16

RUN apk --update add --virtual build-dependencies build-base postgresql-dev linux-headers libsass-dev
RUN apk --update add libpq bash libxml2 libxml2-dev libxml2-utils libxslt openssl zlib git \
    libc6-compat gcompat libass netcat-openbsd less shared-mime-info tzdata

RUN mkdir /api
WORKDIR /api
ADD Gemfile /api/
ADD Gemfile.lock /api/
RUN bundle install
ADD . /api/
COPY ./scripts/entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 3000