
# Vue-Express Template

A ready to use Vue3 and Expressjs Admin Dashboard.

# Prerequisite

- Pie CLI
- Docker
- Nodejs

## Getting Started

1. Fetch the template:
   ```
   pie create
   ```

2. Run  ```make dev```  in your root directory to start the containers. This command starts the admin dashboard at port ```4000``` and the express api on port ```3000```.

3. Inside the root directory of your project run:
   ```
   make init
   ```

   this will initialize a default admin user. The credentials are:

   ```test@test.de``` 

   ```PW: admin```



## Additional helpers

Create a migration script for the database:

```
make migration name=<YourScriptName>
```

Create a seed script for the database:

```
make seed name=<YourScriptName>
```


Start all migration scripts:

```
make migrate name=<YourScriptName>
```
