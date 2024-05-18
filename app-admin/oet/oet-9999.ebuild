# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

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

LICENSE="LGPL-2"
SLOT="0"

DEPEND="
	sys-apps/util-linux
"
RDEPEND="
	${DEPEND}
"

src_prepare() {
	if [[ "${PV}" == "9999" ]]; then
		git describe --tags --abbrev=0 | sed -e "s/oet-//" >.version
	else
		echo ${PV} >.version
	fi
	default
	eautoreconf -fi
}
