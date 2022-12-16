# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Formatted C++ stdlib man pages (cppreference)"
HOMEPAGE="https://github.com/jeaye/stdman https://cppreference.com"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jeaye/stdman.git"
else
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/jeaye/stdman/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="CC-BY-SA-3.0 FDL-1.3 MIT"
SLOT="0"

src_prepare() {
	default
	# Avoid compressing files
	sed -i '/gzip/d' do_install || die
}

src_compile() {
	:
}
