# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Execute scripts on IMAP mailbox changes using IDLE, golang version."

HOMEPAGE="https://gitlab.com/shackra/goimapnotify"

SRC_URI="
	https://gitlab.com/shackra/goimapnotify/-/archive/2.5.5/goimapnotify-2.5.5.tar.gz
	https://github.com/gentoo-golang-dist/goimapnotify/releases/download/2.5.5/goimapnotify-2.5.5-vendor.tar.xz
"

LICENSE="GPL-3 MIT MPL-2.0 BSD BSD-2 Apache-2.0"

SLOT="0"

KEYWORDS="~amd64"

src_compile() {
	GIT_COMMIT="bcc9d8d593ce3e5bf142b641642dbd00487dcd88"
	GIT_TAG="2.5.5"
	GIT_BRANCH="master"

	LDFLAGS="-X main.commit=${GIT_COMMIT} -X main.gittag=${GIT_TAG} -X main.branch=${GIT_BRANCH}"

	ego build -ldflags "${LDFLAGS}" -gcflags  '-N -l' ./cmd/goimapnotify
}

src_install() {
	dobin goimapnotify
}
