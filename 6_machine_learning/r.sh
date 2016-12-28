echo_section "Installing R"

ensure_pkg r gcc-fortran

echo_subsection "Installing R packages"
sudo su - -c "R -e \"install.packages('devtools', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('logging', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('rmarkdown', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('shiny', repos='https://cran.rstudio.com/')\""

sudo su - -c "R -e \"install.packages('dplyr', repos='https://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('ggplot2', repos='https://cran.rstudio.com/')\""

# echo_subsection "Installing ${color_green}R kernel for Jupyter${color_yellow}"
# sudo su - -c "R -e \"install.packages(c('repr', 'IRdisplay', 'crayon', 'pbdZMQ'), repos='https://cran.rstudio.com/')\""
# sudo su - -c "R -e \"devtools::install_github('IRkernel/IRkernel')\""
