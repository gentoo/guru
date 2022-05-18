# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="mdoc versions of the HTML documentation for the s6 supervision suite"
HOMEPAGE="http://skarnet.org/software/s6/"

inherit git-r3
EGIT_REPO_URI="https://github.com/flexibeast/s6-man-pages.git"

LICENSE="ISC"
SLOT="0"

src_compile() {
	echo >/dev/null
}

src_install() {
	ls -la ${S}
	doman ${S}/man7/*
	doman ${S}/man8/*
}
