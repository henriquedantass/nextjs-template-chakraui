FROM alpine:3.15

WORKDIR /app

ADD ../create_repo.sh /app

RUN apk add --no-cache --upgrade github-cli gettext bash

EXPOSE 7000


CMD ["bash","create_repo.sh"]