TARGET=epel-5-x86_64

.PHONY: clean
clean:
	rm -fr ec2-api-tools.zip
	rm -fr dist
	rm -f version.sh

ec2-api-tools.zip:
	wget -O ec2-api-tools.zip 'http://www.amazon.com/gp/redirect.html/ref=aws_rc_ec2tools?location=http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip&token=A80325AA4DAB186C80828ED5138633E3F49160D9'

ec2-api-tools: ec2-api-tools.zip
	unzip -x ec2-api-tools
	ln -s ec2-api-tools-[0-9\.]* ec2-api-tools

version.sh: ec2-api-tools
	echo "MAJOR=$$(ls -d ec2-api-tools-* | cut -d - -f 4 | cut -d . -f 1-3)" > version.sh; \
	echo "MINOR=$$(ls -d ec2-api-tools-* | cut -d - -f 4 | cut -d . -f 4)" >> version.sh

dist: ec2-api-tools
	mkdir -p dist/
	source version.sh ; \
	cd ec2-api-tools && tar -czf ../dist/ec2-api-tools-$${MAJOR}-$${MINOR}.tar.gz .

rpm: version.sh dist
	mock --scrub=all -r ${TARGET}
	mkdir -p dist/
	source version.sh ; \
	mock --buildsrpm --spec rpm.spec --sources ./dist/ --resultdir ./dist/ --define "version $${MAJOR}" --define "release $${MINOR}" ; \
	mock -r $(TARGET) ./dist/atlassian-cli-$${MAJOR}-$${MINOR}.src.rpm --resultdir ./dist/ --define "version $${MAJOR}" --define "release $${MINOR}"
