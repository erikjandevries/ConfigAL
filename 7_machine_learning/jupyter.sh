echo_section "Installing Jupyter"

ensure_pkg jupyter-notebook python-ipywidgets

echo_subsection "Installing ${color_green}R kernel for Jupyter${color_yellow}"
sudo su - -c "R -e \"install.packages(c('repr', 'IRdisplay', 'crayon', 'pbdZMQ'), repos='https://cran.rstudio.com/')\""
sudo su - -c "R -e \"devtools::install_github('IRkernel/IRkernel')\""

echo_subsection "Register the R kernel in the current R installation"
sudo su - -c "R -e \"IRkernel::installspec()\""
R -e "IRkernel::installspec()"
