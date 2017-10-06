echo_section "Installing R"

ensure_pkg r gcc-fortran


install_R_package() {
  # Requires
  # $1: package name
echo_info "$1"
sudo su - -c "R -e \"install.packages('$1', repos='http://cran.rstudio.com/')\""
}

install_R_package_github() {
  # Requires
  # $1: github repository
echo_info "github: $1"
sudo su - -c "R -e \"devtools::install_github('$1')\""
}


echo_subsection "Installing R packages"
install_R_package stringi

install_R_package devtools
install_R_package roxygen2
install_R_package testthat
install_R_package knitr

install_R_package_github hadley/devtools

install_R_package logging
install_R_package config
install_R_package rmarkdown
install_R_package shiny

install_R_package dplyr
install_R_package caret
install_R_package e1071
install_R_package scales
install_R_package lubridate

install_R_package ggplot2
install_R_package shinyAce

install_R_package rpart
install_R_package randomForest
install_R_package gbm
install_R_package xgboost


install_R_package_github erikjandevries/r.dstools.ej


