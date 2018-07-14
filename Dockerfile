# RUN BOTH CONTAINERS FROM ROOT (folder with .sln file):
# docker-compose build
# docker-compose up
#
# RUN JUST THIS CONTAINER FROM ROOT (folder with .sln file):
# docker build -t web -f Dockerfile .
#
# RUN COMMAND
#  docker run --name guttungendk --rm -it -p 8000:5000 web

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /app

COPY . .
WORKDIR /app/src
RUN dotnet restore

RUN dotnet publish -c Release -o out

FROM microsoft/dotnet:2.1-aspnetcore-runtime AS runtime
# LABEL Name=guttungen.dk Version=0.0.1
# ARG source=.
WORKDIR /app
#EXPOSE 5000
COPY --from=build /app/src/out ./

ENTRYPOINT dotnet guttungendk.dll
