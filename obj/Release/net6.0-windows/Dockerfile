# Base image with .NET runtime
# syntax = docker/dockerfile:1.2
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

#add secrets file
COPY ["secrets.json", "IdentityServer/secrets.json"]
RUN --mount=type=secret,id=_env,dst=./secrets.json cat IdentityServer/secrets.json

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install -y \
        nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src
COPY ["IdentityServer.csproj", "IdentityServer/"]
RUN dotnet restore "IdentityServer/IdentityServer.csproj"
WORKDIR "/src/IdentityServer"
COPY . .
RUN dotnet build "IdentityServer.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "IdentityServer.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Aviator-Hack.dll"]