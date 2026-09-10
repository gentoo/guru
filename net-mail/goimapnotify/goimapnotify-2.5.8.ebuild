# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Execute scripts on IMAP mailbox changes using IDLE, golang version"

HOMEPAGE="https://radicle.network/nodes/jardin.jorgearaya.dev/rad:z39RJHSHs166S5kr8Qstj6kd1LFah"

# The official radicle repo does not support archive downloads by tag,
# therefore we have to hardcode the commit hash
GIT_COMMIT="7d8181fe3451f91d9ecd7e570c9e06677a555675"
GIT_BRANCH="master"

SRC_URI="https://jardin.jorgearaya.dev/raw/rad:z39RJHSHs166S5kr8Qstj6kd1LFah/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3 MIT MPL-2.0 BSD BSD-2 Apache-2.0"

SLOT="0"

KEYWORDS="~amd64"

src_unpack() {
	default
	mv "${WORKDIR}/goimapnotify-${GIT_COMMIT}" "${S}" || die
}

src_compile() {
	LDFLAGS="-X main.commit=${GIT_COMMIT} -X main.gittag=${PV} -X main.branch=${GIT_BRANCH}"
	ego build -ldflags "${LDFLAGS}" -gcflags  '-N -l' ./cmd/goimapnotify
}

src_install() {
	dobin goimapnotify
}
