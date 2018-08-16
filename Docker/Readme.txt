# Create MySQL container with following commands.
docker build -t gsmysql:0.1 .
docker run --detach --name=gsmysql --publish 6605:3306 gsmysql:0.1
