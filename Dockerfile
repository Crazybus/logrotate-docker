FROM alpine
MAINTAINER crazybus24@gmail.com

RUN apk --update add --no-cache logrotate xz

CMD ["crond", "-f"]
