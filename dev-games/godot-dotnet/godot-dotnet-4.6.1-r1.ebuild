# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Fork of dev-games/godot::gentoo

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DOTNET_PKG_COMPAT="8.0"
NUGETS="
coverlet.collector@6.0.4
diffplex@1.7.2
envdte@17.8.37221
humanizer.core@2.14.1
humanizer.core@2.2.0
jetbrains.annotations@2019.1.3
jetbrains.lifetimes@2024.3.0
jetbrains.rdframework@2024.3.0
jetbrains.rider.pathlocator@1.0.12
microsoft.bcl.asyncinterfaces@5.0.0
microsoft.bcl.asyncinterfaces@7.0.0
microsoft.bcl.cryptography@9.0.10
microsoft.build@15.1.548
microsoft.build.framework@15.1.548
microsoft.build.locator@1.2.6
microsoft.build.notargets@2.0.1
microsoft.codeanalysis.analyzers@3.3.2
microsoft.codeanalysis.analyzers@3.3.4
microsoft.codeanalysis.analyzer.testing@1.1.2
microsoft.codeanalysis.codefix.testing@1.1.2
microsoft.codeanalysis.common@3.11.0
microsoft.codeanalysis.common@4.11.0
microsoft.codeanalysis.common@4.8.0
microsoft.codeanalysis.csharp@3.11.0
microsoft.codeanalysis.csharp@4.11.0
microsoft.codeanalysis.csharp@4.8.0
microsoft.codeanalysis.csharp.analyzer.testing@1.1.2
microsoft.codeanalysis.csharp.analyzer.testing.xunit@1.1.2
microsoft.codeanalysis.csharp.codefix.testing@1.1.2
microsoft.codeanalysis.csharp.codefix.testing.xunit@1.1.2
microsoft.codeanalysis.csharp.sourcegenerators.testing@1.1.2
microsoft.codeanalysis.csharp.sourcegenerators.testing.xunit@1.1.2
microsoft.codeanalysis.csharp.workspaces@3.11.0
microsoft.codeanalysis.csharp.workspaces@4.8.0
microsoft.codeanalysis.sourcegenerators.testing@1.1.2
microsoft.codeanalysis.testing.verifiers.xunit@1.1.2
microsoft.codeanalysis.workspaces.common@3.11.0
microsoft.codeanalysis.workspaces.common@4.8.0
microsoft.codecoverage@18.0.0
microsoft.netcore.platforms@1.0.1
microsoft.netcore.platforms@1.1.0
microsoft.netcore.platforms@2.0.0
microsoft.netcore.platforms@5.0.0
microsoft.netcore.targets@1.0.1
microsoft.netcore.targets@1.1.0
microsoft.netframework.referenceassemblies@1.0.0
microsoft.netframework.referenceassemblies.net461@1.0.0
microsoft.net.test.sdk@18.0.0
microsoft.testplatform.objectmodel@18.0.0
microsoft.testplatform.testhost@18.0.0
microsoft.visualstudio.composition@16.1.8
microsoft.visualstudio.composition.netfxattributes@16.1.8
microsoft.visualstudio.interop@17.8.37221
microsoft.visualstudio.solutionpersistence@1.0.52
microsoft.visualstudio.validation@15.0.82
microsoft.win32.primitives@4.0.1
microsoft.win32.registry@4.0.0
microsoft.win32.registry@5.0.0
netstandard.library@2.0.3
newtonsoft.json@13.0.1
newtonsoft.json@13.0.3
nuget.common@6.3.4
nuget.configuration@6.3.4
nuget.frameworks@6.12.1
nuget.frameworks@6.3.4
nuget.packaging@6.3.4
nuget.protocol@6.3.4
nuget.resolver@6.3.4
nuget.versioning@6.3.4
reflectionanalyzers@0.1.22-dev
runtime.native.system@4.0.0
runtime.native.system.io.compression@4.1.0
system.appcontext@4.1.0
system.buffers@4.5.1
system.collections@4.0.11
system.collections@4.3.0
system.collections.concurrent@4.0.12
system.collections.immutable@1.2.0
system.collections.immutable@5.0.0
system.collections.immutable@7.0.0
system.collections.immutable@8.0.0
system.collections.nongeneric@4.0.1
system.componentmodel.composition@4.5.0
system.composition@1.0.31
system.composition@7.0.0
system.composition.attributedmodel@1.0.31
system.composition.attributedmodel@7.0.0
system.composition.convention@1.0.31
system.composition.convention@7.0.0
system.composition.hosting@1.0.31
system.composition.hosting@7.0.0
system.composition.runtime@1.0.31
system.composition.runtime@7.0.0
system.composition.typedparts@1.0.31
system.composition.typedparts@7.0.0
system.console@4.0.0
system.diagnostics.contracts@4.0.1
system.diagnostics.debug@4.0.11
system.diagnostics.debug@4.3.0
system.diagnostics.fileversioninfo@4.0.0
system.diagnostics.process@4.1.0
system.diagnostics.tools@4.3.0
system.diagnostics.tracesource@4.0.0
system.diagnostics.tracing@4.1.0
system.dynamic.runtime@4.0.11
system.formats.asn1@9.0.10
system.globalization@4.0.11
system.globalization@4.3.0
system.io@4.1.0
system.io@4.3.0
system.io.compression@4.1.0
system.io.filesystem@4.0.1
system.io.filesystem.primitives@4.0.1
system.io.pipelines@5.0.1
system.io.pipelines@7.0.0
system.io.pipes@4.0.0
system.linq@4.1.0
system.linq@4.3.0
system.linq.expressions@4.1.0
system.linq.expressions@4.3.0
system.linq.parallel@4.0.1
system.memory@4.5.4
system.memory@4.5.5
system.net.primitives@4.0.11
system.net.sockets@4.1.0
system.numerics.vectors@4.4.0
system.objectmodel@4.0.12
system.objectmodel@4.3.0
system.reflection@4.1.0
system.reflection@4.3.0
system.reflection.emit@4.0.1
system.reflection.emit@4.3.0
system.reflection.emit.ilgeneration@4.0.1
system.reflection.emit.ilgeneration@4.3.0
system.reflection.emit.lightweight@4.0.1
system.reflection.emit.lightweight@4.3.0
system.reflection.extensions@4.0.1
system.reflection.extensions@4.3.0
system.reflection.metadata@1.3.0
system.reflection.metadata@5.0.0
system.reflection.metadata@7.0.0
system.reflection.metadata@8.0.0
system.reflection.primitives@4.0.1
system.reflection.primitives@4.3.0
system.reflection.typeextensions@4.1.0
system.reflection.typeextensions@4.3.0
system.resources.resourcemanager@4.0.1
system.resources.resourcemanager@4.3.0
system.runtime@4.1.0
system.runtime@4.3.0
system.runtime.compilerservices.unsafe@5.0.0
system.runtime.compilerservices.unsafe@6.0.0
system.runtime.extensions@4.1.0
system.runtime.extensions@4.3.0
system.runtime.handles@4.0.1
system.runtime.interopservices@4.1.0
system.runtime.interopservices.runtimeinformation@4.0.0
system.runtime.loader@4.0.0
system.security.accesscontrol@4.5.0
system.security.accesscontrol@5.0.0
system.security.cryptography.cng@5.0.0
system.security.cryptography.pkcs@9.0.10
system.security.cryptography.protecteddata@4.4.0
system.security.permissions@4.5.0
system.security.principal@4.0.1
system.security.principal.windows@4.5.0
system.security.principal.windows@5.0.0
system.text.encoding@4.0.11
system.text.encoding@4.3.0
system.text.encoding.codepages@4.5.1
system.text.encoding.codepages@7.0.0
system.text.encoding.extensions@4.0.11
system.text.regularexpressions@4.1.0
system.threading@4.0.11
system.threading@4.3.0
system.threading.channels@7.0.0
system.threading.overlapped@4.0.1
system.threading.tasks@4.0.11
system.threading.tasks@4.3.0
system.threading.tasks.dataflow@4.6.0
system.threading.tasks.extensions@4.0.0
system.threading.tasks.extensions@4.5.4
system.threading.thread@4.0.0
system.threading.threadpool@4.0.10
system.xml.readerwriter@4.0.11
system.xml.xmldocument@4.0.1
system.xml.xpath@4.0.1
system.xml.xpath.xmldocument@4.0.1
xunit@2.9.3
xunit.abstractions@2.0.3
xunit.analyzers@1.18.0
xunit.assert@2.9.3
xunit.core@2.9.3
xunit.extensibility.core@2.9.3
xunit.extensibility.execution@2.9.3
xunit.runner.visualstudio@3.1.5
"

inherit branding desktop dotnet-pkg python-any-r1 flag-o-matic scons-utils
inherit shell-completion toolchain-funcs xdg

MY_PN=godot
MY_P=${MY_PN}-${PV}

DESCRIPTION="Multi-platform 2D and 3D game engine with a feature-rich editor"
HOMEPAGE="https://godotengine.org/"
SRC_URI="
	https://github.com/godotengine/godot/releases/download/${PV}-stable/${MY_P}-stable.tar.xz
"

SRC_URI+=" ${NUGET_URIS} "

S=${WORKDIR}/${MY_P}-stable
LICENSE="
	MIT
	Apache-2.0 BSD Boost-1.0 CC0-1.0 Unlicense ZLIB
	gui? ( CC-BY-4.0 ) tools? ( OFL-1.1 )
"
SLOT="0"
KEYWORDS="~amd64"
# Enable roughly same as upstream by default so it works as expected,
# except raycast (tools-only heavy dependency), and deprecated.
IUSE="
	accessibility alsa +dbus debug deprecated double-precision +fontconfig
	+gui pulseaudio raycast speech test +sdl +theora +tools +udev +upnp
	+vulkan wayland +webp
"
REQUIRED_USE="wayland? ( gui )"
# TODO: tests still need more figuring out
RESTRICT="test"

# dlopen: libglvnd
RDEPEND="
	!!dev-games/godot
	app-arch/brotli:=
	app-arch/zstd:=
	dev-games/recastnavigation:=
	dev-libs/icu:=
	dev-libs/libpcre2:=[pcre32]
	media-libs/freetype[brotli,harfbuzz]
	media-libs/harfbuzz:=[icu]
	media-libs/libjpeg-turbo:=
	media-libs/libogg
	media-libs/libpng:=
	media-libs/libvorbis
	>=net-libs/mbedtls-3.6.2-r101:3=
	net-libs/wslay
	virtual/zlib:=
	alsa? ( media-libs/alsa-lib )
	dbus? ( sys-apps/dbus )
	fontconfig? ( media-libs/fontconfig )
	gui? (
		media-libs/libglvnd
		x11-libs/libX11
		x11-libs/libXcursor
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXinerama
		x11-libs/libXrandr
		x11-libs/libXrender
		x11-libs/libxkbcommon
		tools? ( raycast? ( media-libs/embree:4 ) )
		vulkan? ( media-libs/vulkan-loader[X,wayland?] )
	)
	pulseaudio? ( media-libs/libpulse )
	sdl? ( media-libs/libsdl3 )
	speech? ( app-accessibility/speech-dispatcher )
	theora? (
		media-libs/libtheora:=
		tools? ( media-libs/libtheora[encode] )
	)
	tools? ( app-misc/ca-certificates )
	udev? ( virtual/udev )
	upnp? ( net-libs/miniupnpc:= )
	virtual/dotnet-sdk:8.0
	wayland? (
		dev-libs/wayland
		gui-libs/libdecor
	)
	webp? ( media-libs/libwebp:= )
"
DEPEND="
	${RDEPEND}
	gui? ( x11-base/xorg-proto )
	tools? ( test? ( dev-cpp/doctest ) )
"
BDEPEND="
	virtual/pkgconfig
	wayland? ( dev-util/wayland-scanner )
"

src_prepare() {
	default

	# PATCHES fails due to calling dotnet-pkg_src_prepare?
	eapply "${FILESDIR}"/${MY_PN}-4.5-scons.patch

	dotnet-pkg_src_prepare

	# mbedtls normally has mbedtls.pc, but Gentoo's slotted one is mbedtls-3.pc
	sed -E "/pkg-config/s/(mbedtls|mbedcrypto|mbedx509)/&-3/g" \
		-i platform/linuxbsd/detect.py || die

	sed -i "s|pkg-config |$(tc-getPKG_CONFIG) |" platform/linuxbsd/detect.py || die

	# use of builtin_ switches can be messy (see below), delete to be sure
	local unbundle=(
		brotli doctest embree freetype graphite harfbuzz icu4c libjpeg-turbo
		libogg libpng libtheora libvorbis libwebp linuxbsd_headers mbedtls
		miniupnpc pcre2 recastnavigation sdl volk wslay zlib zstd
		# certs: unused by generated header, but scons panics if not found
	)
	rm -r "${unbundle[@]/#/thirdparty/}" || die

	ln -s -- "${ESYSROOT}"/usr/include/doctest thirdparty/ || die
}

src_compile() {
	local -x BUILD_NAME=${BRANDING_OS_ID} # replaces "custom_build" in version

	filter-lto #921017

	local esconsargs=(
		AR="$(tc-getAR)" CC="$(tc-getCC)" CXX="$(tc-getCXX)"

		progress=no
		verbose=yes

		target=$(usex tools editor template_$(usex debug{,} release))
		dev_build=$(usex debug)
		tests=$(usex tools $(usex test)) # bakes in --test in final binary

		# TODO?: libgodot requires a separate build given the executable
		# the library are mutally exculsive and so, unless we really need
		# it, skipping support to ease maintenance at least for now
		#library_type=$(usex libgodot shared_library executable)

		accesskit=$(usex accessibility)
		alsa=$(usex alsa)
		dbus=$(usex dbus)
		deprecated=$(usex deprecated)
		precision=$(usex double-precision double single)
		execinfo=no # not packaged, disables crash handler if non-glibc
		fontconfig=$(usex fontconfig)
		opengl3=$(usex gui)
		pulseaudio=$(usex pulseaudio)
		sdl=$(usex sdl)
		speechd=$(usex speech)
		udev=$(usex udev)
		use_sowrap=no
		use_volk=no # unnecessary when linking directly to libvulkan
		vulkan=$(usex gui $(usex vulkan))
		wayland=$(usex wayland)
		# TODO: retry to add optional USE=X, wayland support is new
		# and gui build is not well wired to handle USE="-X wayland" yet
		x11=$(usex gui)

		system_certs_path="${EPREFIX}"/etc/ssl/certs/ca-certificates.crt

		# platform/*/detect.py uses builtin_* switches to check if need
		# to link with system libraries, but many ignore whether the dep
		# is actually used, so "enable" deleted builtins on disabled deps
		builtin_accesskit=yes # not packaged
		builtin_brotli=no
		builtin_certs=no
		builtin_clipper2=yes # not packaged
		builtin_embree=$(usex !gui yes $(usex !tools yes $(usex !raycast)))
		builtin_enet=yes # bundled copy is patched for IPv6+DTLS support
		builtin_freetype=no
		builtin_glslang=yes #879111 (for now, may revisit if more stable)
		builtin_graphite=no
		builtin_harfbuzz=no
		builtin_icu4c=no
		builtin_libjpeg_turbo=no
		builtin_libogg=no
		builtin_libpng=no
		builtin_libtheora=$(usex !theora)
		builtin_libvorbis=no
		builtin_libwebp=$(usex !webp)
		builtin_mbedtls=no
		builtin_miniupnpc=$(usex !upnp)
		builtin_msdfgen=yes # not wired for unbundling nor packaged
		builtin_openxr=yes # not packaged
		builtin_pcre2=no
		builtin_recastnavigation=no
		builtin_rvo2=yes # bundled copy has godot-specific changes
		builtin_sdl=$(usex !sdl)
		builtin_wslay=no
		builtin_xatlas=yes # not wired for unbundling nor packaged
		builtin_zlib=no
		builtin_zstd=no
		# (more is bundled in third_party/ but they lack builtin_* switches)

		# modules with optional dependencies, "possible" to disable more but
		# gets messy and breaks all sorts of features (expected enabled)
		module_mono_enabled=yes
		# note raycast is only enabled on amd64+arm64 and USE should
		# be masked for other keywords if added, see raycast/config.py
		module_raycast_enabled=$(usex gui $(usex tools $(usex raycast)))
		module_theora_enabled=$(usex theora)
		module_upnp_enabled=$(usex upnp)
		module_webp_enabled=$(usex webp)

		# let *FLAGS handle these
		debug_symbols=no
		lto=none
		optimize=custom
		use_static_cpp=no
	)

	escons "${esconsargs[@]}"

	# godot requires access to input devices?
	addwrite /dev/input
	addwrite /dev/bus/usb

	# generate mono glue
	bin/godot* --headless --generate-mono-glue modules/mono/glue || die "Failed to generate mono glue"

	local MSBUILDTERMINALLOGER=off # required for msbuild to succeed?

	# build the C# assemblies; pass flags so assemblies match how engine was built
	"${EPYTHON}" modules/mono/build_scripts/build_assemblies.py \
		--godot-output-dir "${S}/bin" \
		--precision="$(usex double-precision double single)" \
		$(usex debug --dev-debug "") \
		$(usex deprecated "" --no-deprecated) \
		--push-nupkgs-local="${T}/.nuget/packages" \
		|| die "Failed to build mono assemblies"
}

src_test() {
	xdg_environment_reset

	bin/godot* --headless --test || die
}

src_install() {
	local instdir
	instdir="/usr/$(get_libdir)/godot"

	insinto "${instdir}"
	doins -r bin/GodotSharp

	exeinto "${instdir}"

	local gin
	gin=$(basename bin/godot*) # get once

	doexe "bin/${gin}"

	dosym "..${instdir#/usr}/${gin}" /usr/bin/godot

	doman misc/dist/linux/godot.6
	dodoc AUTHORS.md CHANGELOG.md DONORS.md README.md

	if use gui; then
		newicon icon.svg godot.svg
		domenu misc/dist/linux/org.godotengine.Godot.desktop

		insinto /usr/share/metainfo
		doins misc/dist/linux/org.godotengine.Godot.appdata.xml

		insinto /usr/share/mime/application
		doins misc/dist/linux/org.godotengine.Godot.xml
	fi

	newbashcomp misc/dist/shell/godot.bash-completion godot
	newfishcomp misc/dist/shell/godot.fish godot.fish
	newzshcomp misc/dist/shell/_godot.zsh-completion _godot
}
