# After you’ve been using R for a little bit, you start to notice people talking about their.Rprofile as if it’s some mythical being. Nothing magical about it, but it can be a big time-saver if you find yourself typing things like, “summary()” or, the ever-hated, “stringasfactors=FALSE” ad nauseam.
# Where is my .Rprofile? Check to see if I have an .Rprofile
# Before creating a new profile, fire up R and check to see if you have an existing .Rprofile as it’s usually a hidden file.
c(Sys.getenv("R_PROFILE_USER"), file.path(getwd(),".Rprofile"))

#How to create an .Rprofile
# Assuming you don’t already have one, these files are easy to create. Open a text editor and name your blank file .Rprofile with no trailing extension and place it in the appropriate directory. After populating the file, you’ll have to restart R for the settings to take affect.
Sample .Rprofile

## Print this on start so I know it's loaded.
cat("Loading custom .Rprofile")

## A little gem from Hadley Wickam that will set your CRAN mirror and automatically load devtools in interactive sessions.
.First <- function() {
  options(
    repos = c(CRAN = "https://cran.rstudio.com/"),
    setwd("~/Documents/R"),
    deparse.max.lines = 2)
}

if (interactive()) {
  suppressMessages(require(devtools))
}

## Nice option for local work. I keep it commented out so my code can remain portable.
## options(stringsAsFactors=FALSE)

## Increase the size of my Rhistory file, becasue I like to use the up arrow!
Sys.setenv(R_HISTSIZE='100000')

## Create invisible environment ot hold all your custom functions
.env <- new.env()

## Single character shortcuts for summary() and head().
.env$s <- base::summary
.env$h <- utils::head

#ht==headtail, i.e., show the first and last 10 items of an object.
.env$ht <- function(d) rbind(head(d,10),tail(d,10))

## Read data on clipboard.
.env$read.cb <- function(...) {
  ismac <- Sys.info()[1]=="Darwin"
  if (!ismac) read.table(file="clipboard", ...)
  else read.table(pipe("pbpaste"), ...)
}

## List objects and classes.
.env$lsa <- function() {
{
    obj_type <- function(x) class(get(x, envir = .GlobalEnv)) # define environment
    foo = data.frame(sapply(ls(envir = .GlobalEnv), obj_type))
    foo$object_name = rownames(foo)
    names(foo)[1] = "class"
    names(foo)[2] = "object"
    return(unrowname(foo))
}

## List all functions in a package.
.env$lsp <-function(package, all.names = FALSE, pattern) {
    package <- deparse(substitute(package))
    ls(
        pos = paste("package", package, sep = ":"),
        all.names = all.names,
        pattern = pattern
    )
}

## Open Finder to the current directory. Mac Only!
.env$macopen <- function(...) if(Sys.info()[1]=="Darwin") system("open .")
.env$o       <- function(...) if(Sys.info()[1]=="Darwin") system("open .")


## Attach all the variables above
attach(.env)

## Finally, a function to print out all the functions you have defined in the .Rprofile.
print.functions <- function(){
	cat("s() - shortcut for summaryn",sep="")
	cat("h() - shortcut for headn",sep="")
	cat("read.cb() - read from clipboardn",sep="")
	cat("lsa() - list objects and classesn",sep="")
	cat("lsp() - list all functions in a packagen",sep="")
	cat("macopen() - open finder to current working directoryn",sep="")
}


# The R Startup Process
# In the absence of any command-line flags being used, when R starts up, it will “source” (run) the site-wide R startup configuration file/script if it exists. In a fresh install of R, this will rarely exist, but if it does, it will usually be in  ‘/etc/R/’ on Debian.
# Next, it will check for a .Rprofile hidden file in the current working directory (the directory where R is started on the command-line) to source. Failing that, it will check your home directory for the .Rprofile hidden file.
# You can check if you have a site-wide R configuration script by running
1
R.home(component = "home")

# in the R console and then checking for the presence of Rprofile.site in that directory. The presence of the user-defined R configuration can be checked for in the directory of whichever path

1
path.expand("~")

# More information on the R startup process can be found here and here. 
# The site-wide R configuration script
# For most R installations on primarily single-user systems, using the site-wide R configuration script should be given up in favor of the user-specific configuration. That being said, a look at the boilerplate site-wide R profile that Debian furnishes (but comments out by default) provides some good insight into what might be a good idea to include in this file, if you choose to use it.

##                      Emacs please make this -*- R -*-
## empty Rprofile.site for R on Debian
##
## Copyright (C) 2008 Dirk Eddelbuettel and GPL'ed
##
## see help(Startup) for documentation on ~/.Rprofile and Rprofile.site
 
# ## Example of .Rprofile
# options(width=65, digits=5)
# options(show.signif.stars=FALSE)
# setHook(packageEvent("grDevices", "onLoad"),
#         function(...) grDevices::ps.options(horizontal=FALSE))
# set.seed(1234)
# .First <- function() cat("n   Welcome to R!nn")
# .Last <- function()  cat("n   Goodbye!nn")
 
# ## Example of Rprofile.site
# local({
#  # add MASS to the default packages, set a CRAN mirror
#  old <- getOption("defaultPackages"); r <- getOption("repos")
#  r["CRAN"] <- "http://my.local.cran"
#  options(defaultPackages = c(old, "MASS"), repos = r)
#})

#Two things you might want to do in a site-wide R configuration file is add other packages to the default packages list and set a preferred CRAN mirror. Other things that the above snippet indicates you can do is set various width and number display options, setting a random-number seed (making random number generation deterministic for reproducible analysis), and hiding the stars that R shows for different significance levels (ostensibly because of their connection to the much-maligned NHST paradigm).

#The user-specific .Rprofile
#In contrast to the site-wide config (that will be used for all users on the system), the user-specific R configuration file is a place to put more personal preferences, shortcuts, aliases, and hacks. Immediately below is my .Rprofile.

local({r <- getOption("repos")
      r["CRAN"] <- "http://cran.revolutionanalytics.com"
      options(repos=r)})
 
options(stringsAsFactors=FALSE)
 
options(max.print=100)
 
options(scipen=10)
 
options(editor="vim")
 
# options(show.signif.stars=FALSE)
 
options(menu.graphics=FALSE)
 
options(prompt="> ")
options(continue="... ")
 
options(width = 80)
 
q <- function (save="no", ...) {
  quit(save=save, ...)
}
 
utils::rc.settings(ipck=TRUE)
 
.First <- function(){
  if(interactive()){
    library(utils)
    timestamp(,prefix=paste("##------ [",getwd(),"] ",sep=""))
 
  }
}
 
.Last <- function(){
  if(interactive()){
    hist_file <- Sys.getenv("R_HISTFILE")
    if(hist_file=="") hist_file <- "~/.RHistory"
    savehistory(hist_file)
  }
}
 
if(Sys.getenv("TERM") == "xterm-256color")
  library("colorout")
 
sshhh <- function(a.package){
  suppressWarnings(suppressPackageStartupMessages(
    library(a.package, character.only=TRUE)))
}
 
auto.loads <-c("dplyr", "ggplot2")
 
if(interactive()){
  invisible(sapply(auto.loads, sshhh))
}
 
.env <- new.env()
attach(.env)
 
.env$unrowname <- function(x) {
  rownames(x) <- NULL
  x
}
 
.env$unfactor <- function(df){
  id <- sapply(df, is.factor)
  df[id] <- lapply(df[id], as.character)
  df
}
 
message("n*** Successfully loaded .Rprofile ***n")


Warnings about .Rprofile
There are some compelling reasons to abstain from using an R configuration file at all. The most persuasive argument against using it is the portability issue: As you begin to rely more and more on shortcuts and options you define in your .Rprofile, your R scripts will depend on them more and more. If a script is then transferred to a friend or colleague, often it won’t work; in the worst case scenario, it will run without error but produce wrong results.

There are several ways this pitfall can be avoided, though:

    For R sessions/scripts that might be shared or used on systems without your .Rprofile, make sure to start the R interpreter with the –vanilla option, or add/change your shebang lines to “#!/usr/bin/Rscript –vanilla”. The “–vanilla” option will tell R to ignore any configuration files. Writing scripts that will conform to a vanilla R startup environment is a great thing to do for portability.
    Use your .Rprofile everywhere! This is a bit of an untenable solution because you can’t put your .Rprofile everywhere. However, if you put your .Rprofile on GitHub, you can easily clone it on any system that needs it. You can find mine here.
    Save your .Rprofile to another file name and, at the start of every R session where you want to use your custom configuration, manually source the file. This will behave just as it would if it were automatically sourced by R but removes the potential for the .Rprofile to be sourced when it is unwanted.

    A variation on this theme is to create a shell alias to use R with your special configuration. For example, adding a shell alias like this:
    1
    	
    alias aR="R_PROFILE_USER=~/.myR/aR.profile R"

    will make it so that when “R” is run, it will run as before (without special configuration). In order to have R startup and auto-source your configuration you now have to run “aR”. When ‘aR’ is run, the shell temporarily assigns an environment variable that R will follow to source a config script. In this case, it will source a config file called aR.profile in a hidden .myR subdirectory of my home folder. This path can be changed to anything, though.

This is the solution I have settled on because it is very easy to live with and invalidates concerns about portability.

[Lines 1-3]: First, because I don’t have a site-wide R configuration script, I set my local CRAN mirror here. My particular choice of mirror is largely arbitrary.

[Line 5]: If stringsAsFactors hasn’t bitten you yet, it will.

[Line 9]: Setting ‘scipen=10’ effectively forces R to never use scientific notation to express very small or large numbers.

[Line 13]: I included the snippet to turn off significance stars because it is a popular choice, but I have it commented out because ever since 1st grade I’ve used number of stars as a proxy for my worth as a person.

[Line 15]: I don’t have time for Tk to load; I’d prefer to use the console, if possible.

[Lines 17-18]: Often, when working in the interactive console I forget a closing brace or paren. When I start a new line, R changes the prompt to “+” to indicate that it is expecting a continuation. Because “+” and “>” are the same width, though, I often don’t notice and really screw things up. These two lines make the R REPL mimic the Python REPL by changing the continuation prompt to the wider “…”.

[Lines 22-24]: Change the default behavior of “q()” to quit immediately and not save workspace.

[Line 26]: This snippet allows you to tab-complete package names for use in “library()” or “require()” calls. Credit for this one goes to @mikelove.

[Lines 28-34]: There are three main reasons I like to have R save every command I run in the console into a history file.

    Occasionally I come up with a clever way to solve a problem in an interactive session that I may want to remember for later use; instead of it getting lost in the ether, if I save it to a history file, I can look it up later.
    Sometimes I need an alibi for what I was doing at a particular time
    I ran a bunch of commands in the console to perform an analysis not realizing that I would have to repeat this analysis later. I can retrieve the commands from a history file and put it into a script where it belongs.

These lines instruct R to, before anything else, echo a timestamp to the console and to my R history file. The timestamp greatly improves my ability to search through my history for relevant commands.

[Lines 36-42]: These lines instruct R, right before exiting, to write all commands I used in that session to my R command history file. I usually have this set in an environment variable called “R_HISTFILE” on most of my systems, but in case I don’t have this defined, I write it to a file in my home directory called .Rhistory.

[Line 44]: Enables the colorized output from R (provided by the colorout package) on appropriate consoles.

[Lines 47-50]: This defines a function that loads a libary into the namespace without any warning or startup messages clobbering my console.

[Line 52]: I often want to autoload the ‘dplyr’ and ‘ggplot2’ packages (particularly ‘dplyr’ as it is now an integral part of my R experience).

[Lines 54-56]: This loads the packages in my “auto.loads” vector if the R session is interactive.

[Lines 58-59]: This creates a new hidden namespace that we can store some functions in. We need to do this in order for these functions to survive a call to “rm(list=ls())” which will remove everything in the current namespace. This is described wonderfully in this blog post.

[Lines 61-64]: This defines a simple function to remove any row names a data.frame might have. This was stolen from Stephen Turner (which was in turn stolen from plyr).

[Lines 66-70]: This defines a function to sanely undo a “factor()” call. This was stolen from Dason Kurkiewicz.
