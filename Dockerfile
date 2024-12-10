# Use the official .NET SDK image from Microsoft
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the csproj file and restore any dependencies (via dotnet restore)
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the files and publish the app
COPY . ./
RUN dotnet publish -c Release -o out

# Use the official .NET Runtime image to run the app
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .

# Set the entrypoint for the container to run the app
ENTRYPOINT ["dotnet", "Aviator-Hack.dll"]
