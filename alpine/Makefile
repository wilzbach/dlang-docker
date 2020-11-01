BASE_IMAGE="alpine:3.12"
DOCKER_POSTFIX=-alpine

################################################################################
# Global variables
################################################################################
DOCKER_ORG=dlang2
D_VERSION=dmd

################################################################################
# Automatically set variables
################################################################################
# D_VERSION_RESOLVED does not work due to different release cycle in Alpine Linux
# The canonical name of the resolved tag
D_VERSION_RESOLVED_ALPINE=$(shell docker run -t -e D_VERSION=${D_VERSION} -v $(CURDIR):/workdir ${BASE_IMAGE} /workdir/show_resolved_version.sh)

D_COMPILER=$(firstword $(subst -, ,$(D_VERSION)))
DOCKER_IMAGE_BASE=$(D_COMPILER)$(DOCKER_POSTFIX)

# Nothing to be done for non-stable versions, e.g. dmd-nightly
ifneq (,$(findstring $(D_COMPILER)-,$(D_VERSION)))
build:
push:

else
 DOCKER_IMAGE_NAME=$(DOCKER_IMAGE_BASE):latest
 # The canonical name, e.g. dmd:2.077.1
 DOCKER_IMAGE_NAME_RESOLVED=$(DOCKER_IMAGE_BASE):$(subst $(D_COMPILER)-,,$(D_VERSION_RESOLVED_ALPINE))
 # LDC is installed as ldc2
 D_COMPILER_EXEC=$(subst ldc,ldc2,$(D_COMPILER))
 PKG_NAME=$(subst gdc,gdmd,$(D_COMPILER))

Dockerfile: dlang.docker Makefile
	cat $< | \
		sed "s|{{BASE_IMAGE}}|${BASE_IMAGE}|g" | \
		sed "s|{{PKG_NAME}}|${PKG_NAME}|g" \
		> $@

build: Dockerfile
	docker build -t $(DOCKER_ORG)/$(DOCKER_IMAGE_NAME) .
	docker build -t $(DOCKER_ORG)/$(DOCKER_IMAGE_NAME_RESOLVED) .
	docker run --rm -i -t $(DOCKER_ORG)/$(DOCKER_IMAGE_NAME_RESOLVED) ${D_COMPILER_EXEC} --version | grep -i "${D_COMPILER}"

push: build
	docker push $(DOCKER_ORG)/$(DOCKER_IMAGE_NAME)
	docker push $(DOCKER_ORG)/$(DOCKER_IMAGE_NAME_RESOLVED)
endif
