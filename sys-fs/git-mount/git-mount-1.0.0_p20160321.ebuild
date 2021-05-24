# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

EGIT_COMMIT="706b4f400b831fd093eda2aa264938c2868b42e2"
EGO_PN="github.com/taterbase/git-mount"
EGO_VENDOR=(
	"taterbase.me/git-mount ${EGIT_COMMIT} ${EGO_PN}"
	"bazil.org/fuse fb710f7dfd05053a3bc9516dd5a7a8f84ead8aab github.com/bazil/fuse"
	"golang.org/x/net fe42d452be8f3a2de6a60623c315a49bd37f0a9a github.com/golang/net"
	"golang.org/x/sys 0cec03c779c1270924b29437a17b8a99ae590592 github.com/golang/sys"
)

inherit golang-vcs-snapshot golang-build

DESCRIPTION="git-mount let's you mount your repo as a filesystem based on a revision."
SRC_URI="
	https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> github-com-taterbase-git-mount-${EGIT_COMMIT}.tar.gz
	${EGO_VENDOR_URI}
"

HOMEPAGE="https://github.com/taterbase/git-mount"
KEYWORDS="~amd64"
LICENSE="MIT BSD BSD-2"
SLOT="0"

RDEPEND="sys-fs/fuse"
DEPEND="${RDEPEND}"

src_install() {
	dobin git-mount
	dodoc "src/${EGO_PN}/README.md"
}
