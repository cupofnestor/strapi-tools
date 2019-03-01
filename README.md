# Strapi-runner
_A Docker-ized thing for development using strapi_

---

# The Container
- Docker file is provided to build a simple image which wraps the `strapi` command.

### Building
`docker-build . -t strapi-runner:MAJOR.MINOR.INCREMENTAL`
##### [Flags](https://docs.docker.com/engine/reference/commandline/build/)
- `.` : build from the Dockerfile in this directory
- `-t` : Local Image name and optional versioning tag.

### Pulling Pre Built Image from gitlab
`docker login registry.mysite.org:4567/dev/strapi-tools`

_use your registry login credentials_

`docker pull registry.mysite.org:4567/dev/strapi-tools/strapi-runner:0.0.2`

If all is well, you should see a new image from the registry.mysite.org repo when your inspect `docker images`

### Running Strapi Commands
_A Docker container runs a single command specified by its "ENTRYPOINT", in this case `strapi`.  This is useful for us as we can append any argument we like using `docker run`_
It is useful to set environment variables for database etc.  
Setting the value of `NODE_ENV` to "staging" will tell strapi to use the staging config:
```staging config
        "client": "mongo",
        "uri": "${process.env.DATABASE_URI || ''}",
        "host": "${process.env.DATABASE_HOST || '127.0.0.1'}",
        "port": "${process.env.DATABASE_PORT || 27017}",
        "database": "${process.env.DATABASE_NAME || 'strapi-staging'}",
        "username": "${process.env.DATABASE_USERNAME || ''}",
        "password": "${process.env.DATABASE_PASSWORD || ''}"
```
This allows us to pass in information about a dockerized mongo container.

#### Examples
- ToDo (make some working examples)

**Generate a new project in a new directory**
```
    docker run --rm -it  \
            -v ~/strapi-projects:/usr/src/api \  
            --network=api_network \
            myStrapiImage new myProject
```


**Start an instance from a local project location**
   ```
    docker run --name myStrapiContainer -v ~/projects/strapi/myProject/:/usr/src/api \
            -e NODE_ENV=staging  -e DATABASE_HOST=192.168.12.18 \
            -p 80:1337 \
            -d myStrapiImage start
   ```
**Install a Plugin (once an container instance is running)**
```
docker exec myStrapiContainer strapi intall documentation
```



# The Compose File
-  Use the provided `compose` file to `start` your _existing_ strapi project inside a container.
- A mongoDB container is provided
- Configure paths and settings for `strapi` in the `.env` file.

### Environment Variables (.env file)

- STRAPI_CONTAINER_ID=e5b18a8dc3d8
   - `STRAPI_DIR` _Absolute_ path to your project.
   - `APP_NAME` a unique name to use for the --volume mounted inside the container.  This should probably be the same as your strapi project's directory name to avoid confusion.

### Running as a Daemon
   `docker-compose -p MY_PROJECT_NAME -d up`

# Metadata Dump
_`metadata_dump.sh` wraps the mongodump command to dump strapi metadata for migration_
##### [Flags](https://docs.mongodb.com/manual/reference/program/mongodump/#options)
- `-db` : name of the database to search, usually your project name
- `-h` : host ip address

# ToDo
- [ ] ToDo : Nginx with reverse proxy
- [ ] ToDo : Docker environment for strapi
- [ ] ToDo : Add user-defined `mongodump` options to dump script
