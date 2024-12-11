# Base image with .NET runtime
FROM mcr.microsoft.com/dotnet/runtime:6.0

# Copy your application files
WORKDIR /app
COPY . /app

# Command to run your application
ENTRYPOINT ["dotnet", "Aviator-Hack.dll"]

