# curlcron
A simple docker image to inject cron jobs running curl commands to the crontab file of a container. Can be used for API calls or whatever you'd like.
## Docker run usage
    $ docker run --name=curlcron -e CRON_TASK_1="* * * * * curl google.com" curlcron
#### You can use this site to build properly formatted cron details http://www.openjs.com/scripts/jslibrary/demos/crontab.php
#### Command will wait to run until the specified time. Test this by using a cron sequence of * * * * * for it to run every minute, after the first minute. 

## Docker compose usage
```
version: "3.8"  
  curlcron:
    container_name: your_container_name
    image: calrock27/curlcron
    command: [ "client" ]
    restart: unless-stopped
    environment:
	# take note of the format.. I found it best to use the yaml key format for enviroment variables. Your intended cron schedule and curl command should follow the "CRON_TASK_1: " formatting with your command following the space after the colon. 
	# if you run into trouble, validation can be conducted by running your curl command in a shell to validate it functions as anticipated. you should also ensure that the container built has an enviroment variable with all of your intended text. 
        # curl commands or API calls using yaml special character need to be escaped in a proper format. You may need to read about quote flows. https://yaml.org/spec/1.2.2/#indicator-characters Single quote style worked the best for me, needing to escape very few characters in the example crontab entry. 
      CRON_TASK_1: '*/10 * * * * curl -i -H "Accept: application/json" -H "Content-Type: application/json" -H "X-Api-Key: XXXXXXXXX" -X POST -d ''{"name":"ImportListSync"}'' https://YOUR_URL_HERE/'
      CRON_TASK_2: '* * * * * curl google.com'
```
