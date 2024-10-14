# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/jen/sdk:alpine AS build-env

RUN apk --no-cache upgrade musl

WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN jen restore

# Copy everything else and build
COPY .  ./
RUN jen publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/jen/aspnet:alpine

RUN apk --no-cache upgrade musl

EXPOSE 3000

WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["jen", "panz.dll"]
