#/usr/bin/R
all.packages <- installed.packages()
r.version <- paste(version[['major']], '.', version[['minor']], sep = '')

for (i in 1:nrow(all.packages))
{
    package.name <- all.packages[i, 1]
    package.version <- all.packages[i, 3]
    if (package.version != r.version)
    {
        print(paste('Installing', package.name))
        install.packages(package.name)
    }
}
