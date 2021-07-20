# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DOCS_AUTODOC=0
DOCS_BUILDER="sphinx"
DOCS_DIR="docs"
PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit autotools python-any-r1 docs

DESCRIPTION="A malware identification and classification tool"
HOMEPAGE="
	http://virustotal.github.io/yara
	https://github.com/virustotal/yara
"
SRC_URI="https://github.com/virustotal/yara/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cpu-profiler cuckoo +dex debug-dex dotnet jemalloc macho magic profile tcmalloc"
#TODO: test https://github.com/VirusTotal/yara/issues/1524

REQUIRED_USE="?? ( jemalloc tcmalloc )"
DEPEND="
	dev-libs/openssl:0=

	cpu-profiler? ( dev-util/google-perftools )
	cuckoo? ( dev-libs/jansson )
	jemalloc? ( dev-libs/jemalloc )
	magic? ( sys-apps/file )
	tcmalloc? ( dev-util/google-perftools )
"
RDEPEND="${DEPEND}"

DOCS=( CONTRIBUTORS sample.{file,rules} )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-address-sanitizer
		--disable-debug
		--disable-gcov
		--disable-pb-tests
		--enable-optimization
		--with-crypto

		$(use_enable cuckoo)
		$(use_enable debug-dex)
		$(use_enable dex)
		$(use_enable dotnet)
		$(use_enable macho)
		$(use_enable magic)
		$(use_enable profile profiling)

		$(use_with cpu-profiler)
		$(use_with jemalloc)
		$(use_with tcmalloc)
	)
	econf "${myconf[@]}"
}

src_compile() {
	default
	docs_compile
}

src_install() {
	default
	einstalldocs
	find "${ED}" \( -name "*.a" -o -name "*.la" \) -delete || die
}
