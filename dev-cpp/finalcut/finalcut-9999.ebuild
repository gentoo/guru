# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="A text-based widget toolkit"
HOMEPAGE="https://github.com/gansm/finalcut/"

if [[ "${PV}" = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/gansm/finalcut.git"
else
	SRC_URI="https://github.com/gansm/finalcut/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="LGPL-3+"
SLOT="0/0.9.0"
IUSE="doc examples +gpm test"
REQUIRED_USE="test? ( !examples )"
RESTRICT="!test? ( test )"

DEPEND="
	sys-libs/ncurses:=[tinfo]
	gpm? ( sys-libs/gpm )
"

# autoconf-archive needed to eautoreconf
BDEPEND="
	dev-build/autoconf-archive
	virtual/pkgconfig
	test? ( >=dev-util/cppunit-1.12.0 )
"

RDEPEND="${DEPEND}"

DOCS=(
	AUTHORS
	ChangeLog
	CODE_OF_CONDUCT.md
	Contributing.md
	SECURITY.md
)

src_prepare() {
	default

	[[ "${PV}" = 9999 ]] || eapply "${FILESDIR}/${P}-fix-tests.ebuild"

	sed -i "/doc_DATA/d" Makefile.am || die

	sed -i "/AM_CPPFLAGS/ s/-Werror//" {examples,final,test}/Makefile.am \
		|| die 'Failed to remove `-Werror` from `CPPFLAGS`'

	for component in doc examples test; do
		if ! use "${component}"; then
			sed -i "/SUBDIRS/ s/${component}//" Makefile.am \
				|| die "Failed to remove ${component} from the building process"
		fi
	done

	eautoreconf
}

src_configure() {
	use test && append-cxxflags -O0 -DDEBUG -DUNIT_TEST

	econf \
		$(use_with gpm) \
		$(use_with test unit-test)
}

src_install() {
	einstalldocs

	emake DESTDIR="${ED}" PACKAGE="${PF}" install

	use doc || dodoc doc/first-steps*

	if use examples; then
			local examples="/usr/share/doc/${PF}/examples"
			docompress -x "${examples}"

			for example in examples/.libs/*; do
					example="${example#examples/.libs/}"

					local install_dir="${examples}/${example}"

					insinto "${install_dir}"
					doins "examples/${example}.cpp"
					exeinto "${install_dir}"
					doexe "examples/${example}"
			done
	fi

	find "${ED}" -name "*.la" -delete || die
}
