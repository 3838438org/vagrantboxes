default: targets


targets:
	@echo "Known targets:"
	@grep -e '^\w' Makefile | grep ':' | cut -d: -f1 | grep -v default | grep -v targets
	@echo


clean:
	rm -rf *.box output-*
	rm -rf packer_cache



# Debian 9 "Stretch"
DEBIAN_9_VERSION="9.2.1"

debian9: debian$(DEBIAN_9_VERSION)-amd64-virtualbox.box

debian9-test: debian$(DEBIAN_9_VERSION)-amd64-virtualbox.box
	./testbox.sh $<

debian$(DEBIAN_9_VERSION)-amd64-virtualbox.box: debian9.json
	packer validate $<
	packer build -only=virtualbox-iso $<


# Ubuntu Server 16.04
UBUNTU_1604_VERSION="16.04.3"

ubuntu1604: ubuntu$(UBUNTU_1604_VERSION)-amd64-virtualbox.box

ubuntu1604-test: ubuntu$(UBUNTU_1604_VERSION)-amd64-virtualbox.box
	./testbox.sh $<

ubuntu$(UBUNTU_1604_VERSION)-amd64-virtualbox.box: ubuntu1604.json
	packer validate $<
	packer build -only=virtualbox-iso $<


.PHONY: clean debian9 debian9-test ubuntu1604 ubuntu1604-test
