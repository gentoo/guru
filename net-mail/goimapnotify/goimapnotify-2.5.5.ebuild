# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Execute scripts on IMAP mailbox changes using IDLE, golang version."

HOMEPAGE="https://gitlab.com/shackra/goimapnotify"

SRC_URI="
	https://gitlab.com/shackra/goimapnotify/-/archive/${PV}/${P}.tar.gz
	https://github.com/gentoo-golang-dist/goimapnotify/releases/download/${PV}/${P}-vendor.tar.xz
"

LICENSE="GPL-3 MIT MPL-2.0 BSD BSD-2 Apache-2.0"

SLOT="0"

KEYWORDS="~amd64"

src_compile() {
	GIT_COMMIT=$(gunzip < "${DISTDIR}/${P}.tar.gz" | git get-tar-commit-id)
	GIT_TAG="${PV}"
	GIT_BRANCH="master"

	LDFLAGS="-X main.commit=${GIT_COMMIT} -X main.gittag=${GIT_TAG} -X main.branch=${GIT_BRANCH}"

	ego build -ldflags "${LDFLAGS}" -gcflags  '-N -l' ./cmd/goimapnotify
}

src_install() {
	dobin goimapnotify
}
