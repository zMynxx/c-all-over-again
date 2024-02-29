# c-all-over-again

C All Over Again is a new, refined way of developing for the C programming languages.
It uses tools such as Docker to run a minimal containered development environment with all the tools nessacry to compile, link ,build, test and debug c programs.
Some of the tools included are:

- gcc
- make
- vim
- bash
- git
- ceedling
- doxygen
- rbenv

## Table of Contents

- [Project Description](#project-description)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Docker Image](#docker-image)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Project Description

The C All Over Again project is meant to be used as a template for any future C-projects I (or anybody else) will create.
It uses tools such as Docker to run a minimal containered development environment with all the tools nessacry to compile, link ,build, test and debug c programs.
Some of the tools included are:

- gcc
- make
- vim
- bash
- git
- ceedling
- doxygen
- rbenv

It has repository automation in place, using GitHub Actions for CI, CD, and linting.
It is meant to make the c programming process better, easier, more efficient.

## Features

Ceedling and Doxygen are both integrated into the image.
Ceedling is a framework for building, testing (Unity), mocking (CMock), execption handeling (CException), etc.
Doxygen can generate our API documentaion html files.
Theres also a project-demo folder with comments regarding the testing using Unity.
A Makefile is also provided, with many comments explaining the different flags and the process.

## Installation

No installation needed, just make sure you have Docker pre-installed and clone the repository.

```bash
$ git clone git@github.com:zMynxx/c-all-over-again.git
$ cd c-all-over-again
```

## Usage

```bash
# Use Docker Compose to set up the environment, and start an interactive Bash shell.
$ docker compose up --detach; docker exec --interactive --tty c-dev /bin/bash

# Run all Tests
$ docker compose up --detach; docker exec --interactive --tty c-dev ceedling test:all

# Generate a release
$ docker compose up --detach; docker exec --interactive --tty c-dev ceedling release
```

Docker Compose mounts the project-demo folder found in the root of the project over to `/project` within the directory. Use you host's machines editor or vim inside to container - up to you.

## Docker Image

The image is also published publicly over to [DockerHub](https://hub.docker.com/r/druxx/ubuntu-ceedling).

## Contributing

Explain how others can contribute to the project. Include guidelines for submitting bug reports, feature requests, or pull requests. Also, mention any coding standards or conventions to follow.

## License

    GNU GENERAL PUBLIC LICENSE

This project is licensed under the License Name. See the [LICENSE.md](LICENSE)
file for details.

## Contact

For any questions or feedback, please contact zMynxx.
Email and social media links can be found under my profile.
