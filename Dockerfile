FROM ruby:2.4.3-alpine as builder

RUN apk add --no-cache build-base ruby-dev git

RUN gem install aws-session-credentials

RUN rm -rf /usr/local/bundle/cache && \
    find /usr/local/bundle/gems/ -name "*.c" -delete && \
    find /usr/local/bundle/gems/ -name "*.o" -delete

FROM ruby:2.4.3-alpine

COPY --from=builder /usr/local/bundle /usr/local/bundle

RUN apk add --no-cache pcsc-lite-libs

ENTRYPOINT ["aws-session"]
