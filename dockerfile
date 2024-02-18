# Use the offical .NET core SDK as a parent image 
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# copy the project file and restore any dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application code
COPY . . 

# Publish the application
RUN dotnet publish -c Release -o out

# Build the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out ./

# Expose the port your application will run
EXPOSE 80

# Start the application
ENTRYPOINT ["dotnet", "netContainer.dll"]
