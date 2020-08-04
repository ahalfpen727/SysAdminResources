#!bin/bash
# Here is some code to help reinstall everything after nuking an OS
# Which I have done frequently enough to warrant automation of the task

#----------------------------------------------------------------------
# ssh public-key authenitcation
#----------------------------------------------------------------------

ssh-keygen -t rsa
scp ~/.ssh/id_rsa.pub aj26b@ghpcc06.umassrc.org:~/.ssh/authorized_keys

#----------------------------------------------------------------------
#----Java--------------------------------------------------------------
#----------------------------------------------------------------------

sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update & apt-get install oracle-java8-installer openjdk-8-jdk
update-alternatives --config java # check the java configuration
export JAVA_HOME=/usr/lib/jvm/java-8-oracle

#----------------------------------------------------------------------
#----Docker------------------------------------------------------------
#----------------------------------------------------------------------

sudo apt-get install apt-transport-https ca-certificates curl \
     gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -  # add GPG key
sudo apt-key fingerprint 0EBFCD88  #  check for GPG


sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"  # for ubuntu 18.04 add repository
sudo apt-get update && apt-get install docker-ce docker-ce-cli containerd.io

# after installation start the service
sudo systemctl status docker
sudo usermod -aG docker user  # To run docker without sudo
sudo docker run -i -t kalilinux/kali-linux-docker /bin/bash # run kali docker container 
sudo docker attach container-id/name
# Use below syntax to get shell access of docker container.
sudo docker exec -it <CONTAINER ID/NAME> bash
# find a container
docker search *

# Running a container in the browser
docker run --rm -p 8787:8787 rocker/verse
firefox http://localhost:8787
# username: rstudio password: rstudio
# link hard-drive to container
docker run --rm -p 8787:8787 -v /home/drew/umb_triley: rocker/verse

#----------------------------------------------------------------------
#----Git---------------------------------------------------------------
#----------------------------------------------------------------------

git init
git add .
git commit -m "new stuff"

# push a new commit from a new computer to an old repository
git push https://github.com/ahalfpen727/old-repo.git
git remote add origin2 git@github.com:ahalfpen727/old-repo.git


#----------------------------------------------------------------------
#----conda-------------------------------------------------------------
#----------------------------------------------------------------------
# config bioconda
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge

# create yaml file from env
conda env export > environment.yml

# create env from yaml file
conda env create -f env.yml
conda env create --name EnvName --file env.yml

#---------------------------------------------------------------------
#----- R-cran --------------------------------------------------------
#---------------------------------------------------------------------

# R  version 3.5
sudo add-apt-repository ppa:marutter/c2d4u3.5
sudo apt-add-repository "deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/"
# or add to /etc/apt/source.list
deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/
# R version 3.3.0 >  sudo add-apt-repository ppa:marutter/rrutter

#----------------------------------------------------------------------
#---R-version-3.5---------------------------------------------------------
#----------------------------------------------------------------------

sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
sudo apt update
# if you want R-version-3.4 sudo add-apt-repository ppa:marutter/c2d4u3.5

#----------------------------------------------------------------------
#-----Notedown---------------------------------------------------------
#----------------------------------------------------------------------

# Running an IPython Notebook
notedown notebook.md --run > executed_notebook.ipynb
# Convert markdown to .ipynb and vice versa with notedown
notedown input.md > output.ipynb
# Convert r-markdown into markdown:
notedown input.Rmd --to markdown --knit > output.md
# Convert r-markdown into an IPython notebook:
notedown input.Rmd --knit > output.ipynb
# Convert a notebook into markdown, stripping all outputs:
notedown input.ipynb --to markdown --strip > output.md
# Convert a notebook into markdown, with output JSON intact:
notedown input.ipynb --to markdown > output_with_outputs.md
# Strip the output cells from markdown:
notedown with_output_cells.md --to markdown --strip > no_output_cells.md
