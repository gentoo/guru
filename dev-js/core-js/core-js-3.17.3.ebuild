# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A modular standard library for JavaScript"
HOMEPAGE="https://github.com/zloirock/core-js"
SRC_URI="https://registry.npmjs.org/${PN}/-/${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="net-libs/nodejs"
BDEPEND="net-libs/nodejs[npm]"

src_compile() {
	# nothing to compile here
	:
}

S="${WORKDIR}/package"

src_install() {
	npm \
		--audit false \
		--color false \
		--foreground-scripts \
		--global \
		--offline \
		--omit dev \
		--prefix "${ED}"/usr \
		--progress false \
		--verbose \
		install "${DISTDIR}/${P}".tgz || die "npm install failed"

	einstalldocs
}
