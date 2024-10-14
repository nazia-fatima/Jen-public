# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/sdk:latest As build-env

RUN dotnet --no-cache upgrade musl

# Set the working directory
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY .  ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/sdk:latest

RUN dotnet --no-cache upgrade musl

EXPOSE 3000

WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "panz.dll"]
