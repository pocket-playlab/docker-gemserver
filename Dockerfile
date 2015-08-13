FROM ruby:latest
MAINTAINER Charles Martinot <charles@playlab.com>

RUN mkdir /var/gems
RUN mkdir /geminabox

VOLUME /var/gems

WORKDIR /geminabox
ADD Gemfile /geminabox/
ADD Gemfile.lock /geminabox/
RUN bundle install

ADD config.ru /geminabox/
ADD puma.rb /geminabox/

ENV PORT 6444
EXPOSE 6444
CMD ["bundle", "exec", "puma", "-C", "/geminabox/puma.rb"]
