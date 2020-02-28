ARG user_app
FROM ruby:2.5.5
RUN useradd --no-log-init -r '${user_app}'
USER ${user_app}
ENV LANG C.UTF-8
ENV BUNDLE_PATH /usr/local/bundle

RUN mkdir /app
WORKDIR /app

COPY .dockerignore .
COPY Gemfile* ./
COPY .ruby-version .

RUN gem install bundler
RUN bundle install
COPY . .
ENV RAILS_ENV development
CMD ["bash"]
