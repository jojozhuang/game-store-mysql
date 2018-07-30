# Create MySQL container with following commands.
docker build -t gamestorejsp-mysql:0.1 .
docker run --detach --name=gamestoremysql --publish 6605:3306 gamestorejsp-mysql:0.1
