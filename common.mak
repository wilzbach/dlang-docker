################################################################################
# Global variables
################################################################################

DOCKER_ORG=dlang2
D_VERSION=dmd

################################################################################
# Automatically set variables
################################################################################
# The canonical name of the resolved tag
D_VERSION_RESOLVED=dmd-2.077.1
D_COMPILER=$(firstword $(subst -, ,$(D_VERSION)))
DOCKER_IMAGE_BASE=$(D_COMPILER)$(DOCKER_POSTFIX)
# The alias for the img, e.g. dmd-nightly
# Don't specify a tag for the latest stable bins (e.g. dmd)
ifneq (,$(findstring $(D_COMPILER)-,$(D_VERSION)))
 DOCKER_IMAGE_NAME=$(DOCKER_IMAGE_BASE):$(subst $(D_COMPILER)-,,$(D_VERSION))
else
 DOCKER_IMAGE_NAME=$(DOCKER_IMAGE_BASE):latest
endif
# The canonical name, e.g. dmd:2.077.1
DOCKER_IMAGE_NAME_RESOLVED=$(DOCKER_IMAGE_BASE):$(subst $(D_COMPILER)-,,$(D_VERSION_RESOLVED))
# LDC is installed as ldc2
D_COMPILER_EXEC=$(subst ldc,ldc2,$(D_COMPILER))
BIN_FOLDER=$(subst gdc,bin,$(subst ldc,bin,$(subst dmd,linux/bin64,$(D_COMPILER))))
LIB_FOLDER=$(subst gdc,lib64,$(subst ldc,lib,$(subst dmd,linux/lib64,$(D_COMPILER))))

build: Dockerfile
	docker build -t $(DOCKER_ORG)/$(DOCKER_IMAGE_NAME) .
	docker build -t $(DOCKER_ORG)/$(DOCKER_IMAGE_NAME_RESOLVED) .
	docker run --rm -i -t $(DOCKER_ORG)/$(DOCKER_IMAGE_NAME_RESOLVED) ${D_COMPILER_EXEC} --version | grep -i "${D_COMPILER}"

push: build
	docker push $(DOCKER_ORG)/$(DOCKER_IMAGE_NAME)
	docker push $(DOCKER_ORG)/$(DOCKER_IMAGE_NAME_RESOLVED)
