BASE_IMAGE="ubuntu:18.04"
DOCKER_POSTFIX=-ubuntu-musl

ifeq ($(D_VERSION),ldc)
 include ../common.mak

 Dockerfile: ../ubuntu/dlang.docker ldc-musl.docker
	cat $+ | \
		sed "s|{{D_VERSION}}|${D_VERSION_RESOLVED}|g" | \
		sed "s|{{BASE_IMAGE}}|${BASE_IMAGE}|g" | \
		sed "s|{{BIN_FOLDER}}|${BIN_FOLDER}|g" | \
		sed "s|{{LIB_FOLDER}}|${LIB_FOLDER}|g" \
		> $@
else
 build:
 push:
endif
