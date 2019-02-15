FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /chat_app
WORKDIR /chat_app
COPY Gemfile /chat_app/Gemfile
COPY Gemfile.lock /chat_app/Gemfile.lock
RUN bundle install
COPY . /chat_app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]