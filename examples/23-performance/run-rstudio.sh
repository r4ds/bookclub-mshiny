# run the container with the host cache mounted in the container
docker run -d --rm -ti \
    --name Rstudio \
    -e DISABLE_AUTH=true \
    -p 127.0.0.1:8787:8787 \
    -v /home/angelfeliz/Documents/r-projects/r-lib-4.4:/usr/local/lib/R/site-library \
    -v /home/angelfeliz/Documents/r-projects:/home/rstudio \
    angelfelizr/shinnycannon:4.4.1

# We need to wait 1 second
sleep 1

# We need to open the page
chromium http://localhost:8787/

