# Dolphinscheduler
SHELL := /bin/bash 
version = 3.1.4
name = apache-dolphinscheduler
full_name = $(name)-$(version)-bin
download_url = "https://dlcdn.apache.org/dolphinscheduler/${version}/${full_name}.tar.gz"

all: rpm

clean:
	rm -rf ~/rpmbuild

mkdir: clean
	mkdir -p ~/rpmbuild
	mkdir -p ~/rpmbuild/BUILD
	mkdir -p ~/rpmbuild/BUILDROOT
	mkdir -p ~/rpmbuild/RPMS
	mkdir -p ~/rpmbuild/SOURCES
	mkdir -p ~/rpmbuild/SRPMS

download: mkdir
	[ ! -f "${full_name}.tar.gz" ] && curl -L -o ./$(full_name).tar.gz $(download_url); \
	cp ./$(full_name).tar.gz rpmbuild/SOURCES; 
	cp init.d/* rpmbuild/SOURCES; 

rpm: download
	rpmbuild $(RPM_OPTS) \
	  --define "_topdir %(pwd)" \
	  --define "_builddir %{_topdir}/rpmbuild/BUILD" \
	  --define "_buildrootdir %{_topdir}/rpmbuild/BUILDROOT" \
	  --define "_rpmdir %{_topdir}/rpmbuild/RPMS" \
	  --define "_srcrpmdir %{_topdir}/rpmbuild/SRPMS" \
	  --define "_specdir %{_topdir}" \
	  --define "_sourcedir  %{_topdir}/rpmbuild/SOURCES" \
	  --define "VERSION $(version)" \
	  -ba dolphinscheduler.spec
