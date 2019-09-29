FROM ruby:2.6.3

# Arguments
ARG API_IP=0.0.0.0
ARG API_PORT=8000

ENV API_IP=${API_IP}
ENV API_PORT=${API_PORT}

# Installing system dependecies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Creating API workspace
RUN mkdir api
COPY . /api
WORKDIR /api

# Install API dependencies
RUN gem install bundler -v '2.0.2' && bundle install

EXPOSE ${API_PORT}

CMD (rake db:setup && rake db:migrate || rake db:migrate) && rails server --binding=$API_IP --port=$API_PORT