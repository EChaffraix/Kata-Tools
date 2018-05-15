#! /bin/bash
#

: "${1?Need to set a project name}"

project_name=$1
tests_name=$project_name.Tests
sln=$project_name.sln

mkdir -p $project_name/src
cd $project_name/src
dotnet new console -n $project_name
cd ..

mkdir tests
cd tests
dotnet new classlib -n $tests_name --framework netcoreapp2.0
cd $tests_name
dotnet add $tests_name.csproj package Nunit
dotnet add $tests_name.csproj package NSubstitute
dotnet add $tests_name.csproj package Microsoft.NET.Test.Sdk
dotnet add $tests_name.csproj package NUnit3TestAdapter
#dotnet add $tests_name.csproj package 
dotnet add $tests_name.csproj reference ../../src/$project_name/$project_name.csproj
cd ../..

dotnet new sln -n $project_name
dotnet sln $sln add src/$project_name/$project_name.csproj
dotnet sln $sln add tests/$tests_name/$tests_name.csproj

git clone https://github.com/dotnet/new-repo.git base_config
cp base_config/.gitignore .
rm -rf base_config
