FROM alpine:3.12
LABEL forked from eeacms/rsync image. Trimmed specifically for running curl commands via cron

RUN apk add --no-cache --virtual .run-deps tzdata curl && rm -rf /var/cache/apk/*
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["sh"]
