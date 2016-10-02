FROM ruby:2.3.0-onbuild

ENV APP_DIR=/app
ENV BUNDLE_FROZEN='1' \
    BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/binstubs \
    BUNDLE_DISABLE_SHARED_GEMS='1' \
    BUNDLE_GEMFILE=$APP_DIR/Gemfile

WORKDIR $APP_DIR

# This is to enable "bundle install" layer to be cached
ADD Gemfile $APP_DIR/Gemfile
ADD Gemfile.lock $APP_DIR/Gemfile.lock
RUN bundle install

ENV PATH $BUNDLE_BIN:$PATH

ADD . $APP_DIR

EXPOSE 8089

CMD ["rackup"]

