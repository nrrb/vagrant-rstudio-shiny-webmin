# README #


### What is this repository for? ###

* This is a set of build scripts to create a server running RStudio Server, Shiny Server, and Webmin for remote administration. There are two variants, one with a MySQL server also installed on the same system and one that expects to use an external MySQL server (i.e. an AWS RDS MySQL instance). 

1. [rstudio-shiny-nginx-webmin](rstudio-shiny-nginx-webmin) - [RStudio Server](https://www.rstudio.com/products/rstudio/download-server/), [Shiny Server](https://www.rstudio.com/products/shiny/shiny-server/), nginx reverse proxy, [Webmin](http://www.webmin.com/)
2. [rstudio-shiny-nginx-mysql-webmin](rstudio-shiny-nginx-mysql-webmin) - [RStudio Server](https://www.rstudio.com/products/rstudio/download-server/), [Shiny Server](https://www.rstudio.com/products/shiny/shiny-server/), nginx reverse proxy, MySQL Server, [Webmin](http://www.webmin.com/)

### How do I get set up? ###

* Summary of set up - Configuration occurs through the build scripts found in the manifests sub-folders of each box.
* Dependencies - For local deployment, you will need [VirtualBox](https://www.virtualbox.org/) and [Vagrant](https://www.vagrantup.com/). For remote deployment, you will need Ubuntu Desktop Xenial 16.04 LTS.

### Who do I talk to? ###

* Repo owner: Nicholas Bennett <nicholas.bennett@kellogg.northwestern.edu>