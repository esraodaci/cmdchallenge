.PHONY: all test docker gen_readme update runcmd runcmd-darwin  update-ro-volume

test: docker
	./bin/test_challenges
docker: update-ro-volume gen_readme
	tar -czf var.tar.gz var/
	docker build -t cmdchallenge/cmdchallenge .
	rm -f var.tar.gz

gen_readme:
	./bin/gen_readme

update-ro-volume:
	./bin/update-ro-volume
runcmd:
	GOOS=linux GOARCH=amd64 go build -o ./ro_volume/runcmd ./runcmd/runcmd.go ./runcmd/challenges.go
runcmd-darwin:
	go build -o ./ro_volume/runcmd-darwin ./runcmd/runcmd.go ./runcmd/challenges.go

all: test
