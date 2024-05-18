# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Get the x86-64 Microarchitecture Level on the Current Machine"
HOMEPAGE="https://github.com/HenrikBengtsson/x86-64-level"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/HenrikBengtsson/${PN}.git"
else
	SRC_URI="https://github.com/HenrikBengtsson/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="CC-BY-SA-4.0"
SLOT="0"

RDEPEND="app-shells/bash"

src_compile() {
	:
}

src_install() {
	dobin x86-64-level
}
