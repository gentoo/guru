# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PV="${PV//_p*/}"
MY_P="${PN}-${MY_PV}"

inherit autotools flag-o-matic

DESCRIPTION="A Library for Approximate Nearest Neighbor Searching"
HOMEPAGE="
	https://www.cs.umd.edu/~mount/ANN
	https://tracker.debian.org/pkg/ann
"
SRC_URI="
	mirror://debian/pool/main/a/${PN}/${PN}_${MY_PV}+doc.orig.tar.gz
	mirror://debian/pool/main/a/${PN}/${PN}_${MY_PV}+doc-${PV##*p}.debian.tar.xz
"
S="${WORKDIR}/${MY_P}+doc"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="profile test"

BDEPEND="dev-util/quilt"

RESTRICT="!test? ( test )"
DOCS=( doc/ANNmanual.pdf doc/ReadMe.txt )

src_prepare() {
	export QUILT_PATCHES="${WORKDIR}/debian/patches"
	export QUILT_SERIES="${QUILT_PATCHES}/series"
	quilt push -a || die
	eapply_user

	eautoreconf
}

src_configure() {
	append-cxxflags "-Wl,-soname=libann.so.0"
	use profile && append-cxxflags -DANN_PERF
	econf --disable-static
}

src_test() {
	pushd test || die
	./ann_test < test1.in > /dev/null || die
	./ann_test < test2.in > /dev/null || die
	popd || die
}

src_install() {
	default

	insinto /usr/include/ANN
	doins -r include/ANN/.

	insinto "/usr/share/${P}/sample"
	doins sample/query.pts
	doins sample/sample.save
	doins sample/data.pts

	pushd "${WORKDIR}/debian" || die
	pod2man --center="User Commands" ann2fig.pod ann2fig.1 || die
	pod2man --center="User Commands" ann_sample.pod ann_sample.1 || die
	pod2man --center="User Commands" ann_test.pod ann_test.1 || die
	doman ann_sample.1
	doman ann_test.1
	doman ann2fig.1
	popd || die

	find "${D}" -name '*.la' -delete || die
}
