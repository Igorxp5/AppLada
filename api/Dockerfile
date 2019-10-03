FROM ruby:2.6.3

# Enviroments variables
ENV API_IP=0.0.0.0
ENV API_PORT=3000

# Installing system dependecies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Creating API workspace
RUN mkdir api
COPY . /api
WORKDIR /api

# Install API dependencies
RUN gem install bundler -v '2.0.2' && bundle install

# Install cucumber dependencies
RUN rails g cucumber:install

# Generate a key for Rails
RUN rm -f config/master.key && rm -f config/credentials.yml.enc && EDITOR="echo" rails credentials:edit

EXPOSE ${API_PORT}

CMD (rake db:setup && rake db:migrate || rake db:migrate) && rails server --binding=$API_IP --port=$API_PORT