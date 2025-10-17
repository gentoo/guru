# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DOTNET_PKG_COMPAT="8.0"
NUGETS="
coverlet.collector@3.2.0
DiffPlex@1.5.0
envdte@17.8.37221
GodotSharp@4.5.0
Godot.SourceGenerators@4.5.0
GodotTools.IdeMessaging@1.1.2
Humanizer.Core@2.14.1
Humanizer.Core@2.2.0
JetBrains.Annotations@2019.1.3
JetBrains.Lifetimes@2024.3.0
JetBrains.RdFramework@2024.3.0
JetBrains.Rider.PathLocator@1.0.12
Microsoft.Bcl.AsyncInterfaces@5.0.0
Microsoft.Bcl.AsyncInterfaces@7.0.0
Microsoft.Build@15.1.548
Microsoft.Build.Framework@15.1.548
Microsoft.Build.NoTargets@2.0.1
Microsoft.Build.Locator@1.2.6
Microsoft.CodeAnalysis.Analyzers@3.3.2
Microsoft.CodeAnalysis.Analyzers@3.3.4
Microsoft.CodeAnalysis.Analyzer.Testing@1.1.1
Microsoft.CodeAnalysis.CodeFix.Testing@1.1.1
Microsoft.CodeAnalysis.Common@3.11.0
Microsoft.CodeAnalysis.Common@4.8.0
Microsoft.CodeAnalysis.CSharp@3.11.0
Microsoft.CodeAnalysis.CSharp@4.8.0
Microsoft.CodeAnalysis.CSharp.Analyzer.Testing@1.1.1
Microsoft.CodeAnalysis.CSharp.Analyzer.Testing.XUnit@1.1.1
Microsoft.CodeAnalysis.CSharp.CodeFix.Testing@1.1.1
Microsoft.CodeAnalysis.CSharp.CodeFix.Testing.XUnit@1.1.1
Microsoft.CodeAnalysis.CSharp.SourceGenerators.Testing@1.1.1
Microsoft.CodeAnalysis.CSharp.SourceGenerators.Testing.XUnit@1.1.1
Microsoft.CodeAnalysis.CSharp.Workspaces@3.11.0
Microsoft.CodeAnalysis.CSharp.Workspaces@4.8.0
Microsoft.CodeAnalysis.SourceGenerators.Testing@1.1.1
Microsoft.CodeAnalysis.Testing.Verifiers.XUnit@1.1.1
Microsoft.CodeAnalysis.Workspaces.Common@3.11.0
Microsoft.CodeAnalysis.Workspaces.Common@4.8.0
Microsoft.CodeCoverage@17.7.1
Microsoft.NETCore.Platforms@1.0.1
Microsoft.NETCore.Platforms@1.1.0
Microsoft.NETCore.Platforms@2.0.0
Microsoft.NETCore.Platforms@5.0.0
Microsoft.NETCore.Targets@1.0.1
Microsoft.NETCore.Targets@1.1.0
Microsoft.NETFramework.ReferenceAssemblies@1.0.0
Microsoft.NETFramework.ReferenceAssemblies.net461@1.0.0
Microsoft.NET.Test.Sdk@17.7.1
Microsoft.TestPlatform.ObjectModel@17.7.1
Microsoft.TestPlatform.TestHost@17.7.1
Microsoft.VisualBasic@10.0.1
Microsoft.VisualStudio.Composition@16.1.8
Microsoft.VisualStudio.Composition.NetFxAttributes@16.1.8
Microsoft.VisualStudio.Interop@17.8.37221
Microsoft.VisualStudio.Validation@15.0.82
Microsoft.Win32.Primitives@4.0.1
Microsoft.Win32.Primitives@4.3.0
Microsoft.Win32.Registry@4.0.0
Microsoft.Win32.Registry@4.3.0
Microsoft.Win32.Registry@5.0.0
NETStandard.Library@1.6.1
NETStandard.Library@2.0.3
Newtonsoft.Json@13.0.1
NuGet.Common@5.6.0
NuGet.Configuration@5.6.0
NuGet.Frameworks@6.12.1
NuGet.Frameworks@6.5.0
NuGet.Packaging@5.6.0
NuGet.Protocol@5.6.0
NuGet.Resolver@5.6.0
NuGet.Versioning@5.6.0
ReflectionAnalyzers@0.1.22-dev
runtime.debian.8-x64.runtime.native.System.Security.Cryptography.OpenSsl@4.3.0
runtime.fedora.23-x64.runtime.native.System.Security.Cryptography.OpenSsl@4.3.0
runtime.fedora.24-x64.runtime.native.System.Security.Cryptography.OpenSsl@4.3.0
runtime.native.System@4.0.0
runtime.native.System@4.3.0
runtime.native.System.IO.Compression@4.1.0
runtime.native.System.IO.Compression@4.3.0
runtime.native.System.Net.Http@4.3.0
runtime.native.System.Security.Cryptography.Apple@4.3.0
runtime.native.System.Security.Cryptography.OpenSsl@4.3.0
runtime.opensuse.13.2-x64.runtime.native.System.Security.Cryptography.OpenSsl@4.3.0
runtime.opensuse.42.1-x64.runtime.native.System.Security.Cryptography.OpenSsl@4.3.0
runtime.osx.10.10-x64.runtime.native.System.Security.Cryptography.Apple@4.3.0
runtime.osx.10.10-x64.runtime.native.System.Security.Cryptography.OpenSsl@4.3.0
runtime.rhel.7-x64.runtime.native.System.Security.Cryptography.OpenSsl@4.3.0
runtime.ubuntu.14.04-x64.runtime.native.System.Security.Cryptography.OpenSsl@4.3.0
runtime.ubuntu.16.04-x64.runtime.native.System.Security.Cryptography.OpenSsl@4.3.0
runtime.ubuntu.16.10-x64.runtime.native.System.Security.Cryptography.OpenSsl@4.3.0
System.AppContext@4.1.0
System.AppContext@4.3.0
System.Buffers@4.3.0
System.Buffers@4.5.1
System.Collections@4.0.11
System.Collections@4.3.0
System.Collections.Concurrent@4.0.12
System.Collections.Concurrent@4.3.0
System.Collections.Immutable@1.2.0
System.Collections.Immutable@5.0.0
System.Collections.Immutable@7.0.0
System.Collections.NonGeneric@4.0.1
System.ComponentModel.Composition@4.5.0
System.Composition@1.0.31
System.Composition@7.0.0
System.Composition.AttributedModel@1.0.31
System.Composition.AttributedModel@7.0.0
System.Composition.Convention@1.0.31
System.Composition.Convention@7.0.0
System.Composition.Hosting@1.0.31
System.Composition.Hosting@7.0.0
System.Composition.Runtime@1.0.31
System.Composition.Runtime@7.0.0
System.Composition.TypedParts@1.0.31
System.Composition.TypedParts@7.0.0
System.Console@4.0.0
System.Console@4.3.0
System.Diagnostics.Contracts@4.0.1
System.Diagnostics.Debug@4.0.11
System.Diagnostics.Debug@4.3.0
System.Diagnostics.DiagnosticSource@4.3.0
System.Diagnostics.FileVersionInfo@4.0.0
System.Diagnostics.Process@4.1.0
System.Diagnostics.Process@4.3.0
System.Diagnostics.Tools@4.3.0
System.Diagnostics.TraceSource@4.0.0
System.Diagnostics.Tracing@4.1.0
System.Diagnostics.Tracing@4.3.0
System.Dynamic.Runtime@4.0.11
System.Dynamic.Runtime@4.3.0
System.Globalization@4.0.11
System.Globalization@4.3.0
System.Globalization.Calendars@4.3.0
System.Globalization.Extensions@4.3.0
System.IO@4.1.0
System.IO@4.3.0
System.IO.Compression@4.1.0
System.IO.Compression@4.3.0
System.IO.Compression.ZipFile@4.3.0
System.IO.FileSystem@4.0.1
System.IO.FileSystem@4.3.0
System.IO.FileSystem.Primitives@4.0.1
System.IO.FileSystem.Primitives@4.3.0
System.IO.Pipelines@5.0.1
System.IO.Pipelines@7.0.0
System.IO.Pipes@4.0.0
System.Linq@4.1.0
System.Linq@4.3.0
System.Linq.Expressions@4.1.0
System.Linq.Expressions@4.3.0
System.Linq.Parallel@4.0.1
System.Memory@4.5.4
System.Memory@4.5.5
System.Net.Http@4.3.0
System.Net.Primitives@4.0.11
System.Net.Primitives@4.3.0
System.Net.Sockets@4.1.0
System.Net.Sockets@4.3.0
System.Numerics.Vectors@4.4.0
System.ObjectModel@4.0.12
System.ObjectModel@4.3.0
System.Reflection@4.1.0
System.Reflection@4.3.0
System.Reflection.Emit@4.0.1
System.Reflection.Emit@4.3.0
System.Reflection.Emit.ILGeneration@4.0.1
System.Reflection.Emit.ILGeneration@4.3.0
System.Reflection.Emit.Lightweight@4.0.1
System.Reflection.Emit.Lightweight@4.3.0
System.Reflection.Extensions@4.0.1
System.Reflection.Extensions@4.3.0
System.Reflection.Metadata@1.3.0
System.Reflection.Metadata@5.0.0
System.Reflection.Metadata@7.0.0
System.Reflection.Primitives@4.0.1
System.Reflection.Primitives@4.3.0
System.Reflection.TypeExtensions@4.1.0
System.Reflection.TypeExtensions@4.3.0
System.Resources.ResourceManager@4.0.1
System.Resources.ResourceManager@4.3.0
System.Runtime@4.1.0
System.Runtime@4.3.0
System.Runtime.CompilerServices.Unsafe@5.0.0
System.Runtime.CompilerServices.Unsafe@6.0.0
System.Runtime.Extensions@4.1.0
System.Runtime.Extensions@4.3.0
System.Runtime.Handles@4.0.1
System.Runtime.Handles@4.3.0
System.Runtime.InteropServices@4.1.0
System.Runtime.InteropServices@4.3.0
System.Runtime.InteropServices.RuntimeInformation@4.0.0
System.Runtime.InteropServices.RuntimeInformation@4.3.0
System.Runtime.Loader@4.0.0
System.Runtime.Numerics@4.3.0
System.Security.AccessControl@4.5.0
System.Security.AccessControl@5.0.0
System.Security.Cryptography.Algorithms@4.3.0
System.Security.Cryptography.Cng@4.3.0
System.Security.Cryptography.Csp@4.3.0
System.Security.Cryptography.Encoding@4.3.0
System.Security.Cryptography.OpenSsl@4.3.0
System.Security.Cryptography.Primitives@4.3.0
System.Security.Cryptography.ProtectedData@4.3.0
System.Security.Cryptography.X509Certificates@4.3.0
System.Security.Permissions@4.5.0
System.Security.Principal@4.0.1
System.Security.Principal.Windows@4.5.0
System.Security.Principal.Windows@5.0.0
System.Text.Encoding@4.0.11
System.Text.Encoding@4.3.0
System.Text.Encoding.CodePages@4.5.1
System.Text.Encoding.CodePages@7.0.0
System.Text.Encoding.Extensions@4.0.11
System.Text.Encoding.Extensions@4.3.0
System.Text.RegularExpressions@4.1.0
System.Text.RegularExpressions@4.3.0
System.Threading@4.0.11
System.Threading@4.3.0
System.Threading.Channels@7.0.0
System.Threading.Overlapped@4.0.1
System.Threading.Tasks@4.0.11
System.Threading.Tasks@4.3.0
System.Threading.Tasks.Dataflow@4.6.0
System.Threading.Tasks.Extensions@4.0.0
System.Threading.Tasks.Extensions@4.3.0
System.Threading.Tasks.Extensions@4.5.4
System.Threading.Thread@4.0.0
System.Threading.Thread@4.3.0
System.Threading.ThreadPool@4.0.10
System.Threading.ThreadPool@4.3.0
System.Threading.Timer@4.3.0
System.ValueTuple@4.5.0
System.Xml.ReaderWriter@4.0.11
System.Xml.ReaderWriter@4.3.0
System.Xml.XDocument@4.3.0
System.Xml.XmlDocument@4.0.1
System.Xml.XPath@4.0.1
System.Xml.XPath.XmlDocument@4.0.1
xunit@2.4.2
xunit.abstractions@2.0.3
xunit.analyzers@1.0.0
xunit.assert@2.4.2
xunit.core@2.4.2
xunit.extensibility.core@2.4.2
xunit.extensibility.execution@2.4.2
xunit.runner.visualstudio@2.4.5
"

inherit desktop dotnet-pkg python-any-r1 flag-o-matic scons-utils
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
	sys-libs/zlib:=
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

PATCHES=(
	"${FILESDIR}"/${MY_PN}-4.5-scons.patch
)

src_unpack() {
	default

	dotnet-pkg_src_unpack
}

src_prepare() {
	default

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
	local -x BUILD_NAME=gentoo # replaces "custom_build" in version string

	filter-lto #921017

	local esconsargs=(
		AR="$(tc-getAR)" CC="$(tc-getCC)" CXX="$(tc-getCXX)"

		progress=no
		verbose=yes

		target=$(usex tools editor template_$(usex debug{,} release))
		dev_build=$(usex debug)
		tests=$(usex tools $(usex test)) # bakes in --test in final binary

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
		# TODO: keep an eye on https://github.com/godotengine/godot/pull/110540
		# (reminder: drop IJG and add libjpeg-turbo to unbundle array)
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

		module_mono_enabled=yes

		# modules with optional dependencies, "possible" to disable more but
		# gets messy and breaks all sorts of features (expected enabled)
		#
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

	dotnet-pkg_src_prepare # called here, conflicts with python eclass

	local MSBUILDTERMINALLOGER=off # required for msbuild to succeed?

	# build the C# assemblies; pass flags so assemblies match how engine was built
	python3 modules/mono/build_scripts/build_assemblies.py \
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
	insinto "/usr/$(get_libdir)/godot"
	doins -r bin/.

	# find once
	gd_bin="${ESYSROOT}/usr/$(get_libdir)/godot/$(basename bin/godot*)"

	fperms +x "${gd_bin}"

	dosym "${gd_bin}" /usr/bin/godot

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
