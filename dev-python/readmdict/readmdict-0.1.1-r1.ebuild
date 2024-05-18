# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1 optfeature pypi

DESCRIPTION="Read mdx/mdd files"
HOMEPAGE="
	https://github.com/ffreemt/readmdict
	https://pypi.org/project/readmdict/
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

pkg_postinst() {
	optfeature "LZO support" dev-python/python-lzo
}
