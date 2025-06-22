# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
        adler2@2.0.0
        anstream@0.6.19
        anstyle-parse@0.2.7
        anstyle-query@1.1.3
        anstyle-wincon@3.0.9
        anstyle@1.0.11
        assert_cmd@2.0.17
        autocfg@1.4.0
        bit_field@0.10.2
        bitflags@1.3.2
        bitflags@2.9.1
        bstr@1.12.0
        bytemuck@1.23.1
        byteorder-lite@0.1.0
        cfg-if@1.0.0
        clap@4.5.39
        clap_builder@4.5.39
        clap_complete@4.5.52
        clap_derive@4.5.32
        clap_lex@0.7.4
        color_quant@1.1.0
        colorchoice@1.0.4
        crc32fast@1.4.2
        crossbeam-deque@0.8.6
        crossbeam-epoch@0.9.18
        crossbeam-utils@0.8.21
        crunchy@0.2.3
        difflib@0.4.0
        doc-comment@0.3.3
        document-features@0.2.11
        errno@0.3.12
        exr@1.73.0
        fast_image_resize@5.1.4
        fastrand@2.3.0
        fdeflate@0.3.7
        flate2@1.1.2
        gif@0.13.1
        half@2.6.0
        heck@0.5.0
        image-webp@0.2.2
        image@0.25.6
        is_terminal_polyfill@1.70.1
        jpeg-decoder@0.3.1
        keyframe@1.1.1
        lebe@0.5.2
        libc@0.2.172
        libm@0.2.15
        linux-raw-sys@0.9.4
        litrs@0.4.1
        log@0.4.27
        memchr@2.7.4
        miniz_oxide@0.8.8
        mint@0.5.9
        num-traits@0.2.19
        once_cell_polyfill@1.70.1
        pkg-config@0.3.32
        png@0.17.16
        predicates-core@1.0.9
        predicates-tree@1.0.12
        predicates@3.1.3
        proc-macro2@1.0.95
        qoi@0.4.1
        quick-error@2.0.1
        quick-xml@0.37.5
        quote@1.0.40
        rayon-core@1.12.1
        regex-automata@0.4.9
        rustix@1.0.7
        sd-notify@0.4.5
        serde@1.0.219
        serde_derive@1.0.219
        simd-adler32@0.3.7
        smallvec@1.15.1
        strsim@0.11.1
        syn@2.0.101
        terminal_size@0.4.2
        termtree@0.5.1
        thiserror-impl@1.0.69
        thiserror@1.0.69
        tiff@0.9.1
        tiny-bench@0.4.0
        unicode-ident@1.0.18
        utf8parse@0.2.2
        wait-timeout@0.2.1
        waybackend-scanner@0.4.3
        waybackend@0.4.3
        weezl@0.1.10
        windows-sys@0.59.0
        windows-targets@0.52.6
        windows_aarch64_gnullvm@0.52.6
        windows_aarch64_msvc@0.52.6
        windows_i686_gnu@0.52.6
        windows_i686_gnullvm@0.52.6
        windows_i686_msvc@0.52.6
        windows_x86_64_gnu@0.52.6
        windows_x86_64_gnullvm@0.52.6
        windows_x86_64_msvc@0.52.6
        zune-core@0.4.12
        zune-inflate@0.2.54
        zune-jpeg@0.4.17
"

inherit cargo shell-completion

DESCRIPTION="Efficient animated wallpaper daemon for wayland, controlled at runtime"
HOMEPAGE="https://github.com/LGFae/swww"
if [[ ${PV} == *9999* ]]; then
    inherit git-r3
    EGIT_REPO_URI="https://github.com/LGFae/${PN}.git"
else
    SRC_URI="
    https://github.com/LGFae/swww/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
    ${CARGO_CRATE_URIS}
    "
    KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+=" BSD MIT Unicode-3.0"
SLOT="0"
RUST_MIN_VER="1.87.0"

DEPEND="
	app-arch/lz4:=
	x11-libs/libxkbcommon[wayland]
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-text/scdoc
"

QA_FLAGS_IGNORED="
	usr/bin/${PN}
	usr/bin/${PN}-daemon
"

src_unpack() {
    if [[ "${PV}" == *9999* ]]; then
        git-r3_src_unpack
        cargo_live_src_unpack
    else
        cargo_src_unpack
    fi
}

src_compile() {
	cargo_src_compile
	./doc/gen.sh || die # generate man pages
}

src_install() {
	dobin "$(cargo_target_dir)"/swww{,-daemon}
	doman doc/generated/*.1

	dodoc README.md CHANGELOG.md
	newbashcomp completions/swww.bash swww
	dofishcomp completions/swww.fish
	dozshcomp completions/_swww
}
