# * https://jtway.co/dockerfile-for-a-crystal-application-1e9db24efbc2?gi=1d8da9609e5a

# Build image
FROM crystallang/crystal:1-alpine as builder

WORKDIR /app

# Cache dependencies
COPY ./shard.yml ./shard.lock ./
RUN shards install --production -v

# Build a binary
COPY . .
RUN shards build --static --no-debug --release --production -v

# ===============
# Result image with one layer
FROM alpine:latest

WORKDIR /

COPY --from=builder /app/bin/main .

ENTRYPOINT ["/main"]