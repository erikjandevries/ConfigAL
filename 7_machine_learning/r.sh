echo_section "Installing R"

ensure_pkg r gcc-fortran

echo_subsection "Installing R packages"
echo_info "devtools"
sudo su - -c "R -e \"install.packages('devtools', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"devtools::install_github('hadley/devtools')\""
echo_info "roxygen2"
sudo su - -c "R -e \"install.packages('roxygen2', repos='http://cran.rstudio.com/')\""
echo_info "testthat"
sudo su - -c "R -e \"install.packages('testthat', repos='http://cran.rstudio.com/')\""
echo_info "knitr"
sudo su - -c "R -e \"install.packages('knitr', repos='http://cran.rstudio.com/')\""

echo_info "logging"
sudo su - -c "R -e \"install.packages('logging', repos='http://cran.rstudio.com/')\""
echo_info "rmarkdown"
sudo su - -c "R -e \"install.packages('rmarkdown', repos='http://cran.rstudio.com/')\""
echo_info "shiny"
sudo su - -c "R -e \"install.packages('shiny', repos='https://cran.rstudio.com/')\""

echo_info "dplyr"
sudo su - -c "R -e \"install.packages('dplyr', repos='https://cran.rstudio.com/')\""
echo_info "ggplot2"
sudo su - -c "R -e \"install.packages('ggplot2', repos='https://cran.rstudio.com/')\""

echo_info "shinyAce"
sudo su - -c "R -e \"install.packages('shinyAce', repos='https://cran.rstudio.com/')\""
