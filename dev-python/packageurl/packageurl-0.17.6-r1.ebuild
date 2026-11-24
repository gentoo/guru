# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{13..15} )

inherit distutils-r1 optfeature

PURL_SPEC_PV="1.0.0"
DESCRIPTION="Python library to parse and build “purl” aka. Package URLs"
HOMEPAGE="https://packageurl.org/"
SRC_URI="
	https://github.com/package-url/${PN}-python/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	test? (
		https://github.com/package-url/purl-spec/archive/v${PURL_SPEC_PV}.tar.gz -> purl-spec-${PURL_SPEC_PV}.gh.tar.gz
	)
"
S="${WORKDIR}/${PN}-python-${PV}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		dev-python/pydantic[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${FILESDIR}/safe-for-percent-encoding.patch"
	"${FILESDIR}/spec-tests.patch"
)

EPYTEST_PLUGINS=( )

distutils_enable_tests pytest

src_prepare() {
	# Remove deprecated license classifier
	sed -i "/License ::/d" setup.cfg \
		|| die "Failed to remove deprecated license classifier"

	# Fix setup.cfg
	# Remove missing file from list and fix license list
	sed -i \
		-e "s/packages = find:/packages = find_namespace:/" \
		-e "/AUTHORS.rst/d" \
		-e "s/- //g" \
		setup.cfg \
		|| die "Failed to fix license list"

	# Use purl-spec tests
	if use test; then
		rmdir spec || die
		mv "${WORKDIR}"/purl-spec-"${PURL_SPEC_PV}" spec || die
	fi

	default
}

pkg_postinst() {
	optfeature "SQLAlchemy models support" "dev-python/sqlalchemy"
}
