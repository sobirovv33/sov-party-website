FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY ["SovParty.csproj", "./"]
RUN dotnet restore "SovParty.csproj"
COPY . .
RUN dotnet build "SovParty.csproj" -c Release -o /app/build
RUN dotnet publish "SovParty.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "SovParty.dll"]
