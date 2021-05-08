FROM ruby:latest

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

ENV BACKEND_LISTEN_PORT 8123
ENV FRONTEND_LISTEN_PORT 8124

CMD ["./server.rb"]
