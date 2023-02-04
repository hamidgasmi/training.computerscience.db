# 1. Requirements
docker -v # Docker: https://docs.docker.com/docker-for-windows/install/

# 2. Create a “volume” for the db files
docker volume create pgData

# 3. Download the postgres image
docker pull postgres

# 4. Set postgres db user and password
docker run -d -p 5432:5432 --name postgres --mount type=volume,source=pgData,target=/var/lib/postgresql/data -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=Postgres postgres 

# 5. Start / Stop container:
docker start postgres
docker stop postgres

# 6. View db Logs
docker logs postgres