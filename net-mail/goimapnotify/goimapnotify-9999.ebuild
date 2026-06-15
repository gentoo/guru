# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module git-r3

DESCRIPTION="Execute scripts on IMAP mailbox changes using IDLE, golang version."

EGIT_REPO_URI="https://gitlab.com/shackra/goimapnotify.git"

HOMEPAGE="https://gitlab.com/shackra/goimapnotify"

LICENSE="GPL-3 MIT MPL-2.0 BSD BSD-2 Apache-2.0"

SLOT="0"

KEYWORDS="~amd64"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	GIT_COMMIT=$(git rev-parse HEAD)
	GIT_TAG=$(git describe --tags)
	GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

	LDFLAGS="-X main.commit=${GIT_COMMIT} -X main.gittag=${GIT_TAG} -X main.branch=${GIT_BRANCH}"

	ego build -ldflags "${LDFLAGS}" -gcflags  '-N -l' ./cmd/goimapnotify
}

src_install() {
	dobin goimapnotify
}
