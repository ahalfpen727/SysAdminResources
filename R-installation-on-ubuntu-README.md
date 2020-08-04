---
title: "UBUNTU PACKAGES FOR R"
output:
  html_document:
    toc: yes
---

R 3.6 packages for Ubuntu on i386 and amd64 are available for most stable Desktop releases of Ubuntu until their official end of life date. However, only the latest Long Term Support (LTS) release is fully supported.  As of November 18, 2018 the supported releases are Xenial Xerus (16.04; LTS), Trusty Tahr (14.04; LTS), Bionic Beaver (18.04;LTS), Cosmic Cuttlefish (18.10), and Disco Dingo (19.04).  Note, to install R 3.6 packages, a different sources.list entry is needed.  See below for details.  Even though R has moved to version 3.6, for compatibility the sources.list entry still uses the `cran3.5` designation.

R 3.4 packages for Ubuntu on i386 and amd64 are available for all stable Desktop releases of Ubuntu prior to Bionic Beaver (18.04) until their official end of life date. However, only the latest Long Term Support (LTS) release is fully supported.  As of November 18, 2018 the supported releases are Xenial Xerus (16.04; LTS), and Trusty Tahr (14.04; LTS).

See https://wiki.ubuntu.com/Releases for details.

For additional binary packages for R (currently 4,000+), check out the CRAN2deb4ubuntu PPA: https://launchpad.net/~marutter/+archive/ubuntu/c2d4u or https://launchpad.net/~marutter/+archive/ubuntu/c2d4u3.5 depending on which version of R you are using.

# Installation

To obtain the latest R 3.6 packages, add an entry like


    deb https://cloud.r-project.org/bin/linux/ubuntu disco-cran35/

or

    deb https://cloud.r-project.org/bin/linux/ubuntu cosmic-cran35/
    
or

    deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/
    
or

    deb https://cloud.r-project.org/bin/linux/ubuntu xenial-cran35/

or

    deb https://cloud.r-project.org/bin/linux/ubuntu trusty-cran35/
   

in your /etc/apt/sources.list file.  By using https://cloud.r-project.org, you will be automatically be redirected to a nearby CRAN mirror.  See https://cran.r-project.org/mirrors.html for the current list of CRAN mirrors. 

To obtain the latest R 3.4 packages, add an entry like

    deb https://cloud.r-project.org/bin/linux/ubuntu xenial/

or

    deb https://cloud.r-project.org/bin/linux/ubuntu trusty/
   

in your /etc/apt/sources.list file.  By using https://cloud.r-project.org, you will be automatically be redirected to a nearby CRAN mirror.  See https://cran.r-project.org/mirrors.html for the current list of CRAN mirrors. 



To install the complete R system, use

    sudo apt-get update
    sudo apt-get install r-base

Users who need to compile R packages from source [e.g. package maintainers, or anyone installing packages with install.packages()] should also install the r-base-dev package:

    sudo apt-get install r-base-dev

The R packages for Ubuntu otherwise behave like the Debian ones. One may find additional information in the Debian README file located at https://cran.R-project.org/bin/linux/debian/.

Installation and compilation of R or some of its packages may require Ubuntu packages from the "backports" repositories. Therefore, it is suggested to activate the backports repositories with an entry like 

    deb https://<my.favorite.ubuntu.mirror>/ bionic-backports main restricted universe

in your /etc/apt/sources.list file. See https://launchpad.net/ubuntu/+archivemirrors for the list of Ubuntu mirrors.


# Supported Packages

A number of R packages are available from the Ubuntu repositories with names starting with r-cran-. The following ones are kept up-to-date on CRAN: all packages part of the r-recommended bundle, namely

- r-cran-boot
- r-cran-class
- r-cran-cluster
- r-cran-codetools
- r-cran-foreign
- r-cran-kernsmooth
- r-cran-lattice
- r-cran-mass
- r-cran-matrix
- r-cran-mgcv
- r-cran-nlme
- r-cran-nnet
- r-cran-rpart
- r-cran-spatial
- r-cran-survival

as well as

- r-cran-rodbc

The other r-cran-* packages are updated with Ubuntu releases only. Users who need to update one of these R packages (say r-cran-foo) should first make sure to obtain all the required build
dependencies with

    sudo apt-get build-dep r-cran-foo

Because they rely on the installed version of R, we also provide, on an experimental basis, versions of the following packages as up-to-date as the Ubuntu release allows:

- littler
- python-rpy2
- jags

Please notice that the maintainers are not necessarily themselves users of these packages, so positive or negative feedback through the usual channels (see below) would be appreciated.

Finally, as an added convenience to Ubuntu users who interact with R through Emacs, we also provide an up-to-date version of the package

- ess


# Secure APT

NOTE: There was an issue with a second key found on the Ubuntu keyserver.  Details and how to remove can be found at http://rubuntu.netlify.com/post/changes-to-cran-ubuntu-webpage-regarding-apt-secure-key/.

The Ubuntu archives on CRAN are signed with the key of "Michael Rutter <marutter@gmail.com>" with key ID 0x51716619e084dab9.  To add the key to your system with one command use (thanks to Brett Presnell for the tip):

    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9

An alternate method can be used by retrieving the key with

    gpg --keyserver keyserver.ubuntu.com --recv-key E298A3A825C0D65DFD57CBB651716619E084DAB9

and then feed it to apt-key with

    gpg -a --export E298A3A825C0D65DFD57CBB651716619E084DAB9 | sudo apt-key add -

Some people have reported difficulties using this approach. The issue is usually related to a firewall blocking port 11371. If the first gpg command fails, you may want to try (thanks to Mischan Toosarani for the tip):

    gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9

and then feed it to apt-key with

    gpg -a --export E298A3A825C0D65DFD57CBB651716619E084DAB9 | sudo apt-key add -

Another alternative approach is to search for the key at http://keyserver.ubuntu.com:11371/ and copy the key to a plain text file, say key.txt. Then, feed the key to apt-key with

    sudo apt-key add key.txt


# Administration and Maintances of R Packages

The R packages part of the Ubuntu r-base and r-recommended packages are installed into the directory /usr/lib/R/library. These can be updated using apt-get with

    sudo apt-get update
    sudo apt-get upgrade

The other r-cran-* packages shipped with Ubuntu are installed into the directory /usr/lib/R/site-library.

Installing R packages not provided with Ubuntu first requires tools to compile the packages from source. These tools are installed via the R development package with

    sudo apt-get install r-base-dev

This pulls in the basic requirements for compiling R packages. R packages may then be installed by the local user/admin from the CRAN source packages, typically from inside R using the

    > install.packages()

function or using

    R CMD INSTALL

from a shell. If you have proper write permissions in /usr/local/lib/R/site-library/, and you have not set R_LIBS_USER manually, they will be installed there. Otherwise, you will be asked if a directory in your home directory should be created for these packages. A routine update of such locally compiled packages can be done using

    > update.packages(.libPaths()[1])
    
which will update the packages in the first part of your library path. You can have a look at the components of this path by

    > .libPaths()
    
If you would like to update R packages that have been installed via the Ubuntu package management system which are installed somewhere under /usr/lib/, I would recommend to do this the Ubuntu way using the source packages from the latest version of Ubuntu or use my PPA cran2deb4ubuntu - https://launchpad.net/~marutter/+archive/ubuntu/c2d4u or https://launchpad.net/~marutter/+archive/ubuntu/c2d4u3.5 depending on which version of R you are using. 

# Pathways to R Packages

In order to find packages, R looks at the variables R_LIBS_USER and R_LIBS_SITE. On Debian and Ubuntu, R_LIBS_USER is set in /etc/R/Renviron to 

    R_LIBS_USER=${R_LIBS_USER-'~/R/$platform-library/3.5'}
    
where $platform is something like 'x86_64-pc-linux-gnu' and depending on the version of R installed. You can override this in your ~/.Renviron. R_LIBS_SITE is set in /etc/R/Renviron to

    R_LIBS_SITE=${R_LIBS_SITE-'/usr/local/lib/R/site-library:/usr/lib/R/site-library:/usr/lib/R/library'}
    
This means that packages installed from within R take precedence over the ones installed via the Ubuntu package management system if you happen to have two versions installed at the same time.

# Reporting Problems

The best place to report problems with these packages or ask R questions specific to Ubuntu is the R-SIG-Debian mailing list. See

  https://stat.ethz.ch/mailman/listinfo/r-sig-debian

for more information.


# Acknowledgements

The Debian R packages are maintained by Dirk Eddelbuettel. The Ubuntu packages are compiled for i386 and amd64 by Michael Rutter (<marutter@gmail.com>) using scripts developed by Vincent Goulet.