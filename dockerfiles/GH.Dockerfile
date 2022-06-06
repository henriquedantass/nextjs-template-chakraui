FROM alpine:3.15

WORKDIR /app

ADD ../gh_login.sh /app

RUN apk add --no-cache --upgrade github-cli gettext bash

EXPOSE 7000


CMD ["bash","gh_login.sh"]