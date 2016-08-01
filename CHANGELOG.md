# Change Log
All notable changes to this project will be documented in this file.

## Release `0.4`
### Fixed
* Updated `docker-plugin` to version `0.16.1`

### Added
* Abbility to optionally set build argument `docker_version`

## Release `0.3`
### Added
* Initial support for `jenkins2`
* Several plugins added for `jenkins2` support
* All plugins inside plugins.txt have fixed versions instead of 'latest'

### Fixed
* `jenkins` base image has now been fixed to `2.7.1` for the sake of not breaking
  the docker image any longer.

## Release `0.2`
### Added
* scm-sync-configuration plugin has been added
* docker-plugin has been added to the recipe
* docker-engine included
* docker-compose recipe for easy testing
* Test jobs for jenkins in order to see whether or not is doing what it's supposed to do
* editorconfig for text files sanity

### Fixed
* No sudo workaround. This is not supported any longer since docker is
  not distributed as a static binary now.

## Release `0.1`
### Added
* Initial release
