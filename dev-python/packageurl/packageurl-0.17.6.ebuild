# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_PN="packageurl-python"
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{13..15} )

inherit distutils-r1 pypi optfeature

DESCRIPTION="Python library to parse and build “purl” aka. Package URLs"
HOMEPAGE="
	https://github.com/package-url/purl-spec
	https://pypi.org/project/packageurl-python/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# PYPI version does not provied required
# specification json.
RESTRICT="test"

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

	eapply_user
}

pkg_postinst() {
	optfeature "SQLAlchemy models support" "dev-python/sqlalchemy"
}
