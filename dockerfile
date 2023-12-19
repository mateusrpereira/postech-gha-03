FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /App

#Copy everything
COPY . ./
#Restore as distinct layers
RUN dotnet restore
#Build and publish a release
RUN dotnet publish -c Release -o out

#Build runtine image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /App
COPY --from=build-env /App/out .

#Alterar o nome conforme arquivo gerado no caminho bin\debug\net7.0\nome_arquivo.dll
ENTRYPOINT [ "dotnet", "Aula.dll"]