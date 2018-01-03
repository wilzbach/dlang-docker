# A sane variant to the CircleCi scripts

NAME=dlang-circleci
BASE_IMAGE="ubuntu:17.04"
DOCKER_ORG=dlang2
D_VERSION=dmd
################################################################################
# Set automatically
################################################################################
# The canonical name of the resolved tag
D_VERSION_RESOLVED=dmd-2.077.1
D_COMPILER=$(firstword $(subst -, ,$(D_VERSION)))
DOCKER_IMAGE_BASE=$(D_COMPILER)-circleci
# The alias for the img, e.g. dmd-nightly
# Don't specify a tag for the latest stable bins (e.g. dmd)
ifneq (,$(findstring $(D_COMPILER)-,$(D_VERSION)))
 DOCKER_IMAGE_NAME=$(DOCKER_IMAGE_BASE):$(subst $(D_COMPILER)-,,$(D_VERSION))
else
 DOCKER_IMAGE_NAME=$(DOCKER_IMAGE_BASE):latest
endif
# The canonical name, e.g. dmd:2.077.1
DOCKER_IMAGE_NAME_RESOLVED=$(DOCKER_IMAGE_BASE):$(subst $(D_COMPILER)-,,$(D_VERSION_RESOLVED))

build: Dockerfile
	docker build -t $(DOCKER_ORG)/$(DOCKER_IMAGE_NAME) .
	docker build -t $(DOCKER_ORG)/$(DOCKER_IMAGE_NAME_RESOLVED) .

template.docker:
	curl https://raw.githubusercontent.com/circleci/circleci-images/6bc21feff1f7af80654a12f9c6db6cdcfc725d49/shared/images/Dockerfile-basic.template > $@

Dockerfile: dlang.docker template.docker
	cat dlang.docker| \
		sed "s|{{D_VERSION}}|${D_VERSION_RESOLVED}|g" \
		> dlang.docker.tmp
	cat template.docker | \
		sed "s|{{BASE_IMAGE}}|${BASE_IMAGE}|g" | \
		sed "/# BEGIN IMAGE CUSTOMIZATIONS/ r dlang.docker.tmp" > $@
	rm dlang.docker.tmp

push: build
	docker push $(DOCKER_ORG)/$(DOCKER_IMAGE_NAME)
	docker push $(DOCKER_ORG)/$(DOCKER_IMAGE_NAME_RESOLVED)
