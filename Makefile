SHELL := /bin/bash

image_repo?=huikang
colmap_image_name?=colmap
container_name?=colmap
image_tag?=latest

build-images: ##@docker build docker images
	@echo "Building docker images"
	docker build -f Dockerfile -t ${colmap_image_name}:${image_tag} .

push:
	@docker tag ${colmap_image_name}:${image_tag} ${image_repo}/${colmap_image_name}:${image_tag}
	@docker push ${image_repo}/${colmap_image_name}:${image_tag}

docker-run:
	docker run -it --name ${container_name} \
		-v $(PWD)/test-data:/test-data ${colmap_image_name}

test:
	docker run --name ${container_name} \
		-v $(PWD)/test-data:/test-data ${colmap_image_name} \
		colmap feature_extractor --SiftExtraction.use_gpu=0 \
		--database_path ./test-data/database.db  --image_path /test-data/charmander

clean:
	docker rm -f $(container_name)
