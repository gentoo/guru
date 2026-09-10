# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Execute scripts on IMAP mailbox changes using IDLE, golang version"

HOMEPAGE="https://gitlab.com/shackra/goimapnotify"

GIT_COMMIT="893b05cfe54c38578427bc13f241eeb8122a94d1"
GIT_TAG="${PV}"
GIT_BRANCH="master"

SRC_URI="
	https://jardin.jorgearaya.dev/raw/rad:z39RJHSHs166S5kr8Qstj6kd1LFah/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz
	https://github.com/gentoo-golang-dist/goimapnotify/releases/download/${PV}/${P}-vendor.tar.xz
"

LICENSE="GPL-3 MIT MPL-2.0 BSD BSD-2 Apache-2.0"

SLOT="0"

KEYWORDS="~amd64"

src_unpack() {
	default
	rsync -a --remove-source-files "${WORKDIR}/goimapnotify-${GIT_COMMIT}/" "${S}/" || die
}

src_compile() {
	LDFLAGS="-X main.commit=${GIT_COMMIT} -X main.gittag=${GIT_TAG} -X main.branch=${GIT_BRANCH}"

	ego build -ldflags "${LDFLAGS}" -gcflags  '-N -l' ./cmd/goimapnotify
}

src_install() {
	dobin goimapnotify
}
