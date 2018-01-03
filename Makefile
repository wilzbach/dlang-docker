export D_VERSION_RESOLVED=dmd-2.077.1
export DOCKER_ORG=dlang2
export D_VERSION=dmd

build:
	$(MAKE) -C circleci build
	$(MAKE) -C ubuntu build
	#$(MAKE) -C alpine build

push:
	$(MAKE) -C circleci push
	$(MAKE) -C ubuntu push
	#$(MAKE) -C alpine push

test:
	(cd example-app && \
		docker build -t myorg/myapp . && \
		docker run -t myorg/myapp) | grep "Hello D"
