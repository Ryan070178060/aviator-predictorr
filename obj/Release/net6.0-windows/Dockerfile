# Use the official .NET SDK image from Microsoft
FROM mcr.microsoft.com/dotnet/aspnet:latest AS base

# Set the working directory inside the container
WORKDIR /app

# Copy the .csproj and restore any dependencies (via dotnet restore)
COPY *.csproj ./
RUN dotnet restore

# Copy the entire source code
COPY . ./

# Publish the app to the /out folder
RUN dotnet publish -c Release -o /out

# Use the official .NET runtime image for running the app
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime

# Set the working directory for the application in the runtime container
WORKDIR /app

# Copy the published app from the build container
COPY --from=build /out .

# Set the entry point for the container
ENTRYPOINT ["dotnet", "Aviator-Hack.dll"]
