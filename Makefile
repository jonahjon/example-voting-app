VOTE_IMG = voting-app/vote
RESULT_IMG = voting-app/result
WORKER_IMG = voting-app/worker
ACCOUNT_JJ=164382793440
DOCKER_PUSH_REPOSITORY=dkr.ecr.us-west-2.amazonaws.com

build: build-image push-image

create-ecr:
	aws ecr create-repository --repository-name voting-app/vote
	aws ecr create-repository --repository-name voting-app/worker
	aws ecr create-repository --repository-name voting-app/result

build-image:
	docker build -t $(ACCOUNT_JJ).$(DOCKER_PUSH_REPOSITORY)/$(VOTE_IMG) ./vote
	docker build -t $(ACCOUNT_JJ).$(DOCKER_PUSH_REPOSITORY)/$(RESULT_IMG) ./result
	docker build -f ./worker/Dockerfile.j  -t $(ACCOUNT_JJ).$(DOCKER_PUSH_REPOSITORY)/$(WORKER_IMG) ./worker

push-image:
	export $$(aws ecr get-login-password --region us-west-2)
	docker push $(ACCOUNT_JJ).$(DOCKER_PUSH_REPOSITORY)/$(VOTE_IMG)
	docker push $(ACCOUNT_JJ).$(DOCKER_PUSH_REPOSITORY)/$(RESULT_IMG)
	docker push $(ACCOUNT_JJ).$(DOCKER_PUSH_REPOSITORY)/$(WORKER_IMG)

