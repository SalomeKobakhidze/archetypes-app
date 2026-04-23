FROM rocker/shiny:latest

RUN R -e "install.packages(c('shiny','dplyr','bslib'), repos='https://cloud.r-project.org/')"

COPY . /srv/shiny-server/

EXPOSE 3838

CMD ["/usr/bin/shiny-server"]
