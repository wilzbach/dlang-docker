DLang docker image for CircleCi
===============================

[![Build Status](https://travis-ci.org/wilzbach/dlang-docker-circleci.svg?branch=master)](https://travis-ci.org/wilzbach/dlang-docker-circleci)

```yaml
version: 2
jobs:
  build:
    docker:
      - image: dlang2/dmd-circleci
```

Available tags
--------------

The default tag (`latest`) is the last stable release.

### DMD

```yaml
- image: dlang2/dmd-circleci:nightly
- image: dlang2/dmd-circleci:beta
- image: dlang2/dmd-circleci
- image: dlang2/dmd-circleci:2.077.1
```

### LDC

```yaml
- image: dlang2/ldc-circleci:beta
- image: dlang2/ldc-circleci
- image: dlang2/ldc-circleci:1.6.0
```

### GDC

```yaml
- image: dlang2/gdc-circleci
- image: dlang2/gdc-circleci:4.8.5
```

Full list:

- https://hub.docker.com/r/dlang2/dmd-circleci/tags/
- https://hub.docker.com/r/dlang2/ldc-circleci/tags/
- https://hub.docker.com/r/dlang2/gdc-circleci/tags/

This repo is fully automated and new releases get deployed automatically.
