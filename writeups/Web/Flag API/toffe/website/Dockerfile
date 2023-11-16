FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /App

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -c Release -o out --self-contained true

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /App
COPY --from=build-env /App/out .

ENV ASPNETCORE_URLS http://*:5000
COPY flag.txt /App

RUN adduser --system --no-create-home --disabled-password --uid 1001 notroot

RUN chown -R notroot /App


USER 1001


ENTRYPOINT ["dotnet", "flagapi.dll"]
