# A simple API for a webshop

This is a very simple backend API, implemented by using ASP.NET core and Entity framework.

Before running the application do these:

1. Create a database first by running this script:
```
1_CreateDatabase.sql
```

2. Run this script to create a login and an user for that database:
```
2_CreateLoginAndUser.sql
```

3. Run this script to create database schema and seed it:
```
3_DatabaseSchemaAndSeed.sql
```

4. Intall dependencies by running this command:
```
dotnet restore
```

5. Run this command to create tables for Identity service:
```
dotnet ef database update --context UserIdentityContext
```

Run the application
```
dotnet run
```
