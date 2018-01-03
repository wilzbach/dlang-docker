# A sane variant to the CircleCi scripts

BASE_IMAGE="ubuntu:17.10"
DOCKER_POSTFIX=-circleci

include ../common.mak

template.docker:
	curl https://raw.githubusercontent.com/circleci/circleci-images/6bc21feff1f7af80654a12f9c6db6cdcfc725d49/shared/images/Dockerfile-basic.template > $@

Dockerfile: dlang.docker template.docker Makefile
	cat dlang.docker | \
		sed "s|{{D_VERSION}}|${D_VERSION_RESOLVED}|g" |\
		sed "s|{{BIN_FOLDER}}|${BIN_FOLDER}|g" | \
		sed "s|{{LIB_FOLDER}}|${LIB_FOLDER}|g" \
		> dlang.docker.tmp
	cat template.docker | \
		sed "s|{{BASE_IMAGE}}|${BASE_IMAGE}|g" | \
		sed "/# BEGIN IMAGE CUSTOMIZATIONS/ r dlang.docker.tmp" > $@
	rm dlang.docker.tmp
