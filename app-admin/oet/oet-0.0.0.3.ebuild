# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Update your system into binpkgs in an overlay sandbox"
HOMEPAGE="https://codeberg.org/bcsthsc/overlay-emerge-tool"
if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/bcsthsc/overlay-emerge-tool.git"
	EGIT_BRANCH="main"
	[[ "${EGIT_BRANCH}" == "" ]] && die "Please set a git branch"
else
	SRC_URI="https://codeberg.org/bcsthsc/overlay-emerge-tool/archive/oet-${PV}.tar.gz"
	S="${WORKDIR}/overlay-emerge-tool"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-3"
SLOT="0"


src_install() {
	dosbin src/oet
	dodir /usr/share/oet
	insinto /usr/share/oet
	doins src/oet_auto_emerge_update.source
	doins src/oet_interactive.source
	doman resources/oet.1
}

src_compile() {
	true
}
