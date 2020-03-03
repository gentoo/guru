# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit autotools eutils flag-o-matic

MY_PV="${PV//_p*/}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="A Library for Approximate Nearest Neighbor Searching"
HOMEPAGE="https://www.cs.umd.edu/~mount/ANN/"
SRC_URI="http://cdn-fastly.deb.debian.org/debian/pool/main/a/${PN}/${PN}_${MY_PV}+doc.orig.tar.gz
http://cdn-fastly.deb.debian.org/debian/pool/main/a/${PN}/${PN}_${MY_PV}+doc-${PV##*p}.debian.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

IUSE="debug test"
RESTRICT="!test? ( test )"

RDEPEND=""
DEPEND=""
BDEPEND="dev-util/quilt"

S="${WORKDIR}/${MY_P}+doc"

DOCS=( doc/ANNmanual.pdf doc/ReadMe.txt )

src_prepare() {
	export QUILT_PATCHES="${WORKDIR}/debian/patches"
	export QUILT_SERIES="${QUILT_PATCHES}/series"
	quilt push -a || die
	eapply_user

	eautoreconf
}

src_configure() {
	use debug && append-cxxflags -DANN_PERF
	econf --disable-static
}

src_test() {
	cd test
	./ann_test < test1.in > /dev/null || die
	./ann_test < test2.in > /dev/null || die
	cd ..
}

src_install() {
	default

	insinto /usr/include/ANN
	doins -r include/ANN/.

	insinto "/usr/share/${P}/sample"
	doins sample/query.pts
	doins sample/sample.save
	doins sample/data.pts

	cd "${WORKDIR}/debian"
	pod2man --center="User Commands" ann2fig.pod ann2fig.1
	pod2man --center="User Commands" ann_sample.pod ann_sample.1
	pod2man --center="User Commands" ann_test.pod ann_test.1
	doman ann_sample.1
	doman ann_test.1
	doman ann2fig.1
	cd "${S}"

	find "${D}" -name '*.la' -delete || die
}
