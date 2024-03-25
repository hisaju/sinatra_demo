FROM ruby:3.2.2
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
RUN mkdir /app
WORKDIR /app
RUN gem install bundler:2.5.4
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app
CMD ["bundle", "exec", "puma", "config.ru"]
