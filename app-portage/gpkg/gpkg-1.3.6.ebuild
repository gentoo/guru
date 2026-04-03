# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler2@2.0.1
	aho-corasick@1.1.4
	android_system_properties@0.1.5
	anyhow@1.0.102
	async-broadcast@0.7.2
	async-channel@2.5.0
	async-executor@1.14.0
	async-io@2.6.0
	async-lock@3.4.2
	async-process@2.5.0
	async-recursion@1.1.1
	async-signal@0.2.13
	async-task@4.7.1
	async-trait@0.1.89
	atomic-waker@1.1.2
	autocfg@1.5.0
	base64@0.22.1
	bitflags@1.3.2
	bitflags@2.11.0
	block-buffer@0.10.4
	block2@0.6.2
	block@0.1.6
	blocking@1.6.2
	bumpalo@3.20.2
	bytemuck@1.25.0
	byteorder@1.5.0
	bytes@1.11.1
	cairo-rs@0.20.12
	cairo-rs@0.21.5
	cairo-sys-rs@0.20.10
	cairo-sys-rs@0.21.5
	cc@1.2.56
	cfg-expr@0.20.6
	cfg-if@1.0.4
	cfg_aliases@0.2.1
	chrono@0.4.44
	color_quant@1.1.0
	concurrent-queue@2.5.0
	core-foundation-sys@0.8.7
	core-foundation@0.9.4
	core-graphics-types@0.1.3
	core-graphics@0.23.2
	core-text@20.1.0
	cpufeatures@0.2.17
	crc32fast@1.5.0
	crossbeam-utils@0.8.21
	crypto-common@0.1.7
	deranged@0.5.8
	diff@0.1.13
	digest@0.10.7
	directories@5.0.1
	dirs-sys@0.4.1
	dirs-sys@0.5.0
	dirs@6.0.0
	dispatch2@0.3.0
	displaydoc@0.2.5
	dlib@0.5.2
	dwrote@0.11.5
	endi@1.1.1
	enumflags2@0.7.12
	enumflags2_derive@0.7.12
	equivalent@1.0.2
	errno@0.3.14
	event-listener-strategy@0.5.4
	event-listener@5.4.1
	fastrand@2.3.0
	fdeflate@0.3.7
	field-offset@0.3.6
	filetime@0.2.27
	find-msvc-tools@0.1.9
	flate2@1.1.9
	float-ord@0.3.2
	foldhash@0.1.5
	font-kit@0.14.3
	foreign-types-macros@0.2.3
	foreign-types-shared@0.3.1
	foreign-types@0.5.0
	form_urlencoded@1.2.2
	freetype-sys@0.20.1
	fsevent-sys@4.1.0
	futures-channel@0.3.32
	futures-core@0.3.32
	futures-executor@0.3.32
	futures-io@0.3.32
	futures-lite@2.6.1
	futures-macro@0.3.32
	futures-sink@0.3.32
	futures-task@0.3.32
	futures-util@0.3.32
	gdk-pixbuf-sys@0.21.5
	gdk-pixbuf@0.21.5
	gdk4-sys@0.10.3
	gdk4@0.10.3
	generic-array@0.14.7
	getrandom@0.2.17
	getrandom@0.3.4
	getrandom@0.4.1
	gettext-rs@0.7.7
	gettext-sys@0.26.0
	gif@0.12.0
	gio-sys@0.20.10
	gio-sys@0.21.5
	gio@0.20.12
	gio@0.21.5
	glib-build-tools@0.20.0
	glib-macros@0.20.12
	glib-macros@0.21.5
	glib-sys@0.20.10
	glib-sys@0.21.5
	glib@0.20.12
	glib@0.21.5
	gobject-sys@0.20.10
	gobject-sys@0.21.5
	graphene-rs@0.21.5
	graphene-sys@0.21.5
	gsk4-sys@0.10.3
	gsk4@0.10.3
	gtk4-macros@0.10.3
	gtk4-sys@0.10.3
	gtk4@0.10.3
	hashbrown@0.15.5
	hashbrown@0.16.1
	heck@0.5.0
	hermit-abi@0.5.2
	hex@0.4.3
	http-body-util@0.1.3
	http-body@1.0.1
	http@1.4.0
	httparse@1.10.1
	hyper-rustls@0.27.7
	hyper-util@0.1.20
	hyper@1.8.1
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.65
	icu_collections@2.1.1
	icu_locale_core@2.1.1
	icu_normalizer@2.1.1
	icu_normalizer_data@2.1.1
	icu_properties@2.1.2
	icu_properties_data@2.1.2
	icu_provider@2.1.1
	id-arena@2.3.0
	idna@1.1.0
	idna_adapter@1.2.1
	image@0.24.9
	indexmap@2.13.0
	inotify-sys@0.1.5
	inotify@0.10.2
	instant@0.1.13
	io-lifetimes@2.0.4
	ipnet@2.12.0
	iri-string@0.7.10
	itoa@1.0.17
	jpeg-decoder@0.3.2
	js-sys@0.3.89
	kqueue-sys@1.0.4
	kqueue@1.1.1
	lazy_static@1.5.0
	leb128fmt@0.1.0
	libadwaita-sys@0.8.1
	libadwaita@0.8.1
	libc@0.2.182
	libloading@0.8.9
	libredox@0.1.12
	linux-raw-sys@0.12.1
	litemap@0.8.1
	locale_config@0.3.0
	lock_api@0.4.14
	log@0.4.29
	lru-slab@0.1.2
	mac-notification-sys@0.6.9
	malloc_buf@0.0.6
	matchers@0.2.0
	memchr@2.8.0
	memoffset@0.9.1
	minimal-lexical@0.2.1
	miniz_oxide@0.8.9
	mio@1.1.1
	nix@0.29.0
	nom@7.1.3
	notify-rust@4.12.0
	notify-types@1.0.1
	notify@7.0.0
	nu-ansi-term@0.50.3
	num-conv@0.2.0
	num-traits@0.2.19
	objc-foundation@0.1.1
	objc2-core-foundation@0.3.2
	objc2-encode@4.1.0
	objc2-foundation@0.3.2
	objc2@0.6.3
	objc@0.2.7
	objc_id@0.1.1
	once_cell@1.21.3
	option-ext@0.2.0
	ordered-stream@0.2.0
	pango-sys@0.21.5
	pango@0.21.5
	parking@2.2.1
	parking_lot@0.12.5
	parking_lot_core@0.9.12
	pathfinder_geometry@0.5.1
	pathfinder_simd@0.5.5
	percent-encoding@2.3.2
	pin-project-lite@0.2.16
	pin-utils@0.1.0
	piper@0.2.4
	pkg-config@0.3.32
	plotters-backend@0.3.7
	plotters-bitmap@0.3.7
	plotters-cairo@0.7.0
	plotters-svg@0.3.7
	plotters@0.3.7
	png@0.17.16
	polling@3.11.0
	potential_utf@0.1.4
	powerfmt@0.2.0
	ppv-lite86@0.2.21
	pretty_assertions@1.4.1
	prettyplease@0.2.37
	proc-macro-crate@3.4.0
	proc-macro2@1.0.106
	quick-xml@0.37.5
	quinn-proto@0.11.13
	quinn-udp@0.5.14
	quinn@0.11.9
	quote@1.0.44
	r-efi@5.3.0
	rand@0.8.5
	rand@0.9.2
	rand_chacha@0.3.1
	rand_chacha@0.9.0
	rand_core@0.6.4
	rand_core@0.9.5
	redox_syscall@0.5.18
	redox_syscall@0.7.1
	redox_users@0.4.6
	redox_users@0.5.2
	regex-automata@0.4.14
	regex-syntax@0.8.9
	regex@1.12.3
	reqwest@0.12.28
	ring@0.17.14
	roxmltree@0.20.0
	rustc-hash@2.1.1
	rustc_version@0.4.1
	rustix@1.1.4
	rustls-pki-types@1.14.0
	rustls-webpki@0.103.9
	rustls@0.23.37
	rustversion@1.0.22
	ryu@1.0.23
	same-file@1.0.6
	scopeguard@1.2.0
	semver@1.0.27
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	serde_json@1.0.149
	serde_repr@0.1.20
	serde_spanned@0.6.9
	serde_spanned@1.0.4
	serde_urlencoded@0.7.1
	sha1@0.10.6
	sharded-slab@0.1.7
	shlex@1.3.0
	signal-hook-registry@1.4.8
	simd-adler32@0.3.8
	slab@0.4.12
	smallvec@1.15.1
	socket2@0.6.2
	sourceview5-sys@0.10.1
	sourceview5@0.10.0
	stable_deref_trait@1.2.1
	static_assertions@1.1.0
	subtle@2.6.1
	syn@2.0.117
	sync_wrapper@1.0.2
	synstructure@0.13.2
	system-deps@7.0.7
	target-lexicon@0.13.3
	tauri-winrt-notification@0.7.2
	temp-dir@0.1.16
	tempfile@3.26.0
	thiserror-impl@1.0.69
	thiserror-impl@2.0.18
	thiserror@1.0.69
	thiserror@2.0.18
	thread_local@1.1.9
	time-core@0.1.8
	time@0.3.47
	tinystr@0.8.2
	tinyvec@1.10.0
	tinyvec_macros@0.1.1
	tokio-macros@2.6.0
	tokio-rustls@0.26.4
	tokio@1.49.0
	toml@0.8.23
	toml@0.9.12+spec-1.1.0
	toml_datetime@0.6.11
	toml_datetime@0.7.5+spec-1.1.0
	toml_edit@0.22.27
	toml_edit@0.23.10+spec-1.0.0
	toml_parser@1.0.9+spec-1.1.0
	toml_write@0.1.2
	toml_writer@1.0.6+spec-1.1.0
	tower-http@0.6.8
	tower-layer@0.3.3
	tower-service@0.3.3
	tower@0.5.3
	tracing-attributes@0.1.31
	tracing-core@0.1.36
	tracing-journald@0.3.2
	tracing-log@0.2.0
	tracing-subscriber@0.3.22
	tracing@0.1.44
	try-lock@0.2.5
	ttf-parser@0.20.0
	typenum@1.19.0
	uds_windows@1.1.0
	unicode-ident@1.0.24
	unicode-xid@0.2.6
	untrusted@0.9.0
	url@2.5.8
	utf8_iter@1.0.4
	uuid@1.21.0
	valuable@0.1.1
	version-compare@0.2.1
	version_check@0.9.5
	vte4-sys@0.9.0
	vte4@0.9.0
	walkdir@2.5.0
	want@0.3.1
	wasi@0.11.1+wasi-snapshot-preview1
	wasip2@1.0.2+wasi-0.2.9
	wasip3@0.4.0+wasi-0.3.0-rc-2026-01-06
	wasm-bindgen-futures@0.4.62
	wasm-bindgen-macro-support@0.2.112
	wasm-bindgen-macro@0.2.112
	wasm-bindgen-shared@0.2.112
	wasm-bindgen@0.2.112
	wasm-encoder@0.244.0
	wasm-metadata@0.244.0
	wasmparser@0.244.0
	web-sys@0.3.89
	web-time@1.1.0
	webpki-roots@1.0.6
	weezl@0.1.12
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.11
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-collections@0.2.0
	windows-core@0.61.2
	windows-core@0.62.2
	windows-future@0.2.1
	windows-implement@0.60.2
	windows-interface@0.59.3
	windows-link@0.1.3
	windows-link@0.2.1
	windows-numerics@0.2.0
	windows-result@0.3.4
	windows-result@0.4.1
	windows-strings@0.4.2
	windows-strings@0.5.1
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-sys@0.60.2
	windows-sys@0.61.2
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows-targets@0.53.5
	windows-threading@0.1.0
	windows-version@0.1.7
	windows@0.61.3
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_gnullvm@0.53.1
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_aarch64_msvc@0.53.1
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnu@0.53.1
	windows_i686_gnullvm@0.52.6
	windows_i686_gnullvm@0.53.1
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_i686_msvc@0.53.1
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnu@0.53.1
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_gnullvm@0.53.1
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	windows_x86_64_msvc@0.53.1
	winnow@0.7.14
	wio@0.2.2
	wit-bindgen-core@0.51.0
	wit-bindgen-rust-macro@0.51.0
	wit-bindgen-rust@0.51.0
	wit-bindgen@0.51.0
	wit-component@0.244.0
	wit-parser@0.244.0
	writeable@0.6.2
	xdg-home@1.3.0
	yansi@1.0.1
	yeslogic-fontconfig-sys@6.0.0
	yoke-derive@0.8.1
	yoke@0.8.1
	zbus@4.4.0
	zbus@5.14.0
	zbus_macros@4.4.0
	zbus_macros@5.14.0
	zbus_names@3.0.0
	zbus_names@4.3.1
	zerocopy-derive@0.8.39
	zerocopy@0.8.39
	zerofrom-derive@0.1.6
	zerofrom@0.1.6
	zeroize@1.8.2
	zerotrie@0.2.3
	zerovec-derive@0.11.2
	zerovec@0.11.5
	zmij@1.0.21
	zvariant@4.2.0
	zvariant@5.10.0
	zvariant_derive@4.2.0
	zvariant_derive@5.10.0
	zvariant_utils@2.1.0
	zvariant_utils@3.3.0
"

RUST_MIN_VER="1.75.0"

inherit cargo desktop systemd xdg-utils

DESCRIPTION="Graphical package manager for Gentoo Linux (Portage frontend)"
HOMEPAGE="https://codeberg.org/NoBodyZ/gpkg"
SRC_URI="
	https://codeberg.org/NoBodyZ/gpkg/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

S="${WORKDIR}/gpkg"

LICENSE="GPL-2"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD ISC MIT MPL-2.0 Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+sourceview +vte btrfs dracut appindicator grub2 kerneltools limine refind systemd systemd-boot"
REQUIRED_USE="
	kerneltools? ( ^^ ( limine grub2 systemd-boot refind ) )
	btrfs? ( kerneltools )
	dracut? ( kerneltools )
	limine? ( kerneltools )
	grub2? ( kerneltools )
	systemd-boot? ( kerneltools )
	refind? ( kerneltools )
"

DEPEND="
	>=gui-libs/gtk-4.12:4
	>=gui-libs/libadwaita-1.4:1
	>=dev-libs/glib-2.76:2
	sys-apps/dbus
	media-libs/graphene
	x11-libs/cairo
	x11-libs/pango
	x11-libs/gdk-pixbuf:2
	media-libs/freetype:2
	media-libs/fontconfig
	sys-devel/gettext
	vte? ( >=gui-libs/vte-0.74:2.91-gtk4 )
	sourceview? ( >=gui-libs/gtksourceview-5.10:5 )
"
RDEPEND="
	${DEPEND}
	sys-apps/portage
	app-portage/gentoolkit
	app-portage/eix
	sys-auth/polkit
	kerneltools? (
		|| ( sys-apps/systemd sys-apps/systemd-utils[kernel-install] )
		sys-kernel/linux-firmware
	)
	dracut? ( sys-kernel/dracut )
	btrfs? ( app-backup/snapper )
	appindicator? ( gnome-extra/gnome-shell-extension-appindicator )
"
BDEPEND="
	virtual/pkgconfig
"

QA_FLAGS_IGNORED="
	usr/bin/gpkg
	usr/bin/gpkg-daemon
"

src_configure() {
	local myfeatures=(
		$(usev vte)
		$(usev sourceview)
		$(usev kerneltools)
		$(usev limine)
		$(usev grub2)
		$(usev systemd-boot)
		$(usev refind)
		$(usev btrfs)
		$(usev dracut)
	)
	cargo_src_configure
}

src_compile() {
	cargo_src_compile
}

src_test() {
	cargo_src_test
}

src_install() {
	# Install binaries from workspace build (cargo_src_compile already built
	# everything with correct per-crate feature resolution; cargo install
	# would fail because gpkg-daemon doesn't define the GUI features)
	dobin target/release/gpkg-daemon
	dobin target/release/gpkg

	# D-Bus system bus configuration
	insinto /etc/dbus-1/system.d
	doins data/dbus/org.gentoo.PkgMngt.conf

	# D-Bus service activation file
	insinto /usr/share/dbus-1/system-services
	doins data/dbus/org.gentoo.PkgMngt.service

	# Polkit authorization policies
	insinto /usr/share/polkit-1/actions
	doins data/polkit/org.gentoo.pkgmngt.policy

	# Desktop file
	domenu data/org.gentoo.PkgMngt.desktop

	# Icons — all sizes (PNG) + scalable SVGs + systray status icons
	insinto /usr/share/icons
	doins -r data/icons/hicolor

	# AppStream metainfo
	insinto /usr/share/metainfo
	doins data/org.gentoo.PkgMngt.metainfo.xml

	# CSS stylesheet
	insinto /usr/share/gpkg
	doins data/style/style.css

	# Locale
	insinto /usr/share/locale/fr/LC_MESSAGES
	newins po/fr.mo gpkg.mo

	# Kernel tools (USE=kerneltools)
	if use kerneltools; then
		exeinto /usr/lib/kernel
		doexe data/kernel/scripts/compile-kernel.sh

		exeinto /usr/lib/kernel/install.d
		use limine && doexe data/kernel/hooks/95-limine-gentoo.install

		# Portage hook for auto-compile on emerge *-sources
		insinto /etc/portage
		newins data/kernel/hooks/portage-bashrc bashrc

		insinto /etc/kernel
		doins data/kernel/configs/auto-compile.conf
		doins data/kernel/configs/default-type

		keepdir /var/log/kernel-compile
	fi

	# Systemd service unit
	if use systemd; then
		systemd_dounit systemd/gpkg-daemon.service
	fi

	# OpenRC init script and config
	newinitd "${FILESDIR}"/gpkg-daemon.initd gpkg-daemon
	newconfd "${FILESDIR}"/gpkg-daemon.confd gpkg-daemon

	# Documentation
	dodoc README.md
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update

	elog ""
	elog "To start the gpkg daemon:"
	elog ""
	if use systemd; then
		elog "  systemctl enable --now gpkg-daemon"
	else
		elog "  rc-update add gpkg-daemon default"
		elog "  rc-service gpkg-daemon start"
	fi
	elog ""
	elog "Then launch the GUI:  gpkg"
	elog ""
	elog "The console tab works without the daemon."
	elog "All other tabs require a running gpkg-daemon."
	elog ""

	if use kerneltools; then
		elog "Kernel tools installed:"
		elog "  - Automatic kernel compilation hooks"
		elog "  - Kernel Conf tab in the GUI"
		use limine && elog "  - Limine bootloader integration"
		use btrfs && elog "  - Btrfs snapshot management"
		elog ""
		elog "To enable auto-compilation, toggle it in the Kernel Conf tab"
		elog "or edit /etc/kernel/auto-compile.conf"
		elog ""
	fi
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
