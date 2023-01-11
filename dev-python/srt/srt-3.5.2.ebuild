# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="A tiny library for parsing, modifying, and composing SRT files"
HOMEPAGE="https://github.com/cdown/srt"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest

DEPEND="
	test? (
		dev-python/hypothesis[${PYTHON_USEDEP}]
	)
"

src_prepare() {
	default

	mv "${S}"/srt_tools/srt "${S}"/srt_tools/srt-cdown || die "Cannot rename the file"
	sed -e 's|"srt_tools/srt"|"srt_tools/srt-cdown"|' \
		-i "${S}"/setup.py || die "Cannot update setup.py"

}

pkg_postinst() {
	ewarn "To avoid conflict with dev-python/pysrt::gentoo the binary has been"
	ewarn "renamed /usr/bin/srt-cdown. The python module is still called srt."
}
