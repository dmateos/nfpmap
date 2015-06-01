FROM ruby:2.2.0

RUN apt-get update -qq && apt-get install -y build-essential
RUN apt-get install -y nodejs
RUN apt-get install -y libmysqld-dev

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD . $APP_HOME
RUN bundle install

CMD ["rails","server","-b","0.0.0.0"]
