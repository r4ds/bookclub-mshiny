FROM rocker/tidyverse:4.4.1

RUN apt-get update && apt-get install -y curl 

# Download the .deb package  
RUN curl -LO https://github.com/rstudio/shinycannon/releases/download/v1.1.3/shinycannon_1.1.3-dd43f6b_amd64.deb

# Install the .deb package
RUN dpkg -i shinycannon_1.1.3-dd43f6b_amd64.deb || apt-get install -y -f

# Clean up
RUN rm shinycannon_1.1.3-dd43f6b_amd64.deb