# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Versatile replacement for vmstat, iostat and ifstat (clone of dstat)"
HOMEPAGE="https://github.com/scottchiefbaker/dool"

if [[ "${PV}" == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/scottchiefbaker/dool.git"
	inherit git-r3
else
	SRC_URI="
		https://github.com/scottchiefbaker/dool/archive/refs/tags/v${PV}.tar.gz
			-> ${P}.tar.gz
	"
	KEYWORDS="~amd64 ~arm64 ~mips ~ppc ~ppc64 ~sparc ~x86 "
fi

SRC_URI+="
	https://github.com/scottchiefbaker/dool/pull/80/commits/5c538542a5bf2b16c496ab9d0a15f439f1ba1e49.patch
		-> dool-1.3.2-add-site-packages-dir-to-plugin-path.patch
"

LICENSE="GPL-2"
SLOT="0"

PATCHES=(
	"${DISTDIR}"/dool-1.3.2-add-site-packages-dir-to-plugin-path.patch
)

src_prepare() {
	# https://github.com/scottchiefbaker/dool/pull/80
	mv dool dool.py || die

	mkdir dool || die
	mv plugins dool || die
	mv dool.py dool || die

	cat <<-EOF > dool/__init__.py || die
	"""Versatile replacement for vmstat, iostat and ifstat (clone of dstat)"""
	__version__ = "${PV}"
	EOF

	sed -i 's/dool:__main/dool.dool:__main/' pyproject.toml || die

	default
}

src_install() {
	distutils-r1_src_install

	doman "docs/${PN}.1"

	einstalldocs

	dodoc examples/{mstat,read}.py

	docinto html
	dodoc docs/*.html
}

src_test() {
	python_foreach_impl emake test
}
