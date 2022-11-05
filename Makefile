install:
	pip install --upgrade pip &&\
	pip install -r requirements.txt
post-install:
	python -m textblob.download_corpora
format:
    #format code
	black *.py mylib/*.py
lint:
     #flake8 or pylint
	pylint --disable=R,C *.py mylib/*.py
test:
    #test
	python -m pytest -vv --cov=mylib --cov=main test_*.py
build:
	# build container
	docker build -t deploy-fastapi .
run:
	#run docker
	#docker run -p 127.0.0.1:8080:8080 ac66acb73dfd
deploy:
    #deploy
	ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 415225129655.dkr.ecr.us-east-1.amazonaws.com
	docker build -t wiki_vietnam .
	docker tag wiki_vietnam:latest 415225129655.dkr.ecr.us-east-1.amazonaws.com/wiki_vietnam:latest
	docker push 415225129655.dkr.ecr.us-east-1.amazonaws.com/wiki_vietnam:latest
all: install post-install lint test deploy
