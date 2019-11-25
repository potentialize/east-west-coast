SHELL := /bin/bash
USER := root
IMAGE := east_west_coast

# make variable: $var
# shell variable: $$var

# make $@: whole target
# make $*: value of % (in target?)

# make - in front: continue even if command fails

# API

build: Dockerfile clean-images
	#
	# BUILD NEW IMAGE
	#
	docker build . -t $(IMAGE):$$(date +%s)

clean-images: clean-containers
	#
	# CLEAN OLD IMAGES
	#
	-docker rmi $$(docker images | grep ^$(IMAGE) | awk '{print $$1 ":" $$2}')

clean-containers:
	#
	# CLEAN OLD CONTAINERS
	#
	-docker rm $$(docker ps -a | grep $(IMAGE) | awk '{print $$1}')

push: each-push

run: each-run

# INTERNAL TARGETS

push-%:
	# DEPLOY TO SPECIFIED DROPLET
	docker save $(IMAGE):deployed | ssh -C $(USER)@$* docker load

run-%:
	# RUN IMAGE ON SPECIFIED DROPLET (detached)
	# NOTE: hacky way of getting this command to execute on each loop...
	ssh $(USER)@$* docker run -d -e HOST_IP=$* $(IMAGE):deployed > /dev/null &

# call the specified command (%) for each droplet in ip.txt
each-%:
	@while read line; do \
		$(MAKE) --no-print-directory $*-$$(echo $$line | awk '{print $$1;}'); \
	done < src/ip.txt
