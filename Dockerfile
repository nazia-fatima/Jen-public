# syntax=docker/dockerfile:1
FROM alpine:latest

RUN apk --no-cache upgrade musl

WORKDIR /app

# Copy everything else and build
COPY .  ./
RUN jen publish -c Release -o out

# Build runtime image
FROM alpine:latest

RUN apk --no-cache upgrade musl

EXPOSE 3000

WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["jen", "panz.dll"]
