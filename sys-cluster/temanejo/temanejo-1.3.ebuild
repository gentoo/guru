# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#temanejo doesn't support python3
#PYTHON_COMPAT=( python3_{8..10} )

inherit autotools #python-single-r1

DESCRIPTION="a debugger for task-parallel programming"
HOMEPAGE="http://www.hlrs.de/solutions-services/service-portfolio/programming/hpc-development-tools/temanejo"
SRC_URI="http://fs.hlrs.de/projects/temanejo/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc ompss +ompt +socket stdout"

REQUIRED_USE=""
#	${PYTHON_REQUIRED_USE}

DEPEND=""
RDEPEND="
	${DEPEND}
"
#	${PYTHON_DEPS}
#	$(python_gen_cond_dep '
#		dev-python/networkx[${PYTHON_USEDEP}]
#		dev-python/pycairo[${PYTHON_USEDEP}]
#		dev-python/pygobject[${PYTHON_USEDEP}]
#		dev-python/pygtk[${PYTHON_USEDEP}]
#	')

BDEPEND="doc? ( dev-texlive/texlive-latex )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-static
		--enable-ayudame
		--enable-modulefile
		--disable-temanejo
		$(use_enable doc)
		$(use_enable ompt)
	)

	if use ompss; then
		myconf+=( "--with-ompss=${EPREFIX}/usr" )
	else
		myconf+=( "--without-ompss" )
	fi
	if use socket; then
		myconf+=( "--enable-socket=yes" )
	else
		myconf+=( "--enable-socket=no" )
	fi
	if use stdout; then
		myconf+=( "--enable-stdout=yes" )
	else
		myconf+=( "--enable-stdout=no" )
	fi

	econf "${myconf[@]}"
}

src_install() {
	default
	mkdir -p "${ED}/usr/share/${PN}" || die
	mv "${ED}/usr/modulefile" "${ED}/usr/share/${PN}/" || die
	if use doc; then
		mv "${ED}/usr/share/doc/ayudame-library" "${ED}/usr/share/doc/${PF}/" || die
	fi
	find "${D}" -name '*.la' -delete || die
}
