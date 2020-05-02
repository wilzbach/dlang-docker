export D_VERSION_RESOLVED=dmd-2.077.1
export DOCKER_ORG=dlang2
export D_VERSION=dmd

build:
	$(MAKE) -C circleci build
	$(MAKE) -C ubuntu build
	#$(MAKE) -C alpine build
	$(MAKE) -C amazonlinux build
	$(MAKE) -C amazonlinux clean
	$(MAKE) -C amazonlinux build DOCKER_POSTFIX=-amazonlinux2 BASE_IMAGE=amazonlinux:2

push:
	$(MAKE) -C circleci push
	$(MAKE) -C ubuntu push
	#$(MAKE) -C alpine push
	$(MAKE) -C amazonlinux push
	$(MAKE) -C amazonlinux push DOCKER_POSTFIX=-amazonlinux2

test:
	$(MAKE) -C example-app test
