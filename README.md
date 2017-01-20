# NAME

verm - get specific version of distribution

# DESCRIPTION

Use module name as 1st parameter to print module versions. Add specific version as 2nd parameter and pipe it to cpanm to install it. 

# SYSOPSIS

Print all versions of module distribution

`verm Module`

Then use cpanm to install specific version.

`verm Module version | cpanm`

# DEPENDENCIES

`App::cpanminus`, libssl
