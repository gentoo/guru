# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..14} )
inherit distutils-r1 pypi

DESCRIPTION="KiCad API Python Bindings for interacting with running KiCad sessions"
HOMEPAGE="https://gitlab.com/kicad/code/kicad-python https://pypi.org/project/kicad-python"

# Proto files version should match kicad release
KICAD_TAG="9.0.6"
KICAD_PROTO_BASE="https://gitlab.com/kicad/code/kicad/-/raw/${KICAD_TAG}/api/proto"

# List of proto files needed
PROTO_FILES=(
	"board/board.proto"
	"board/board_commands.proto"
	"board/board_types.proto"
	"common/commands/base_commands.proto"
	"common/commands/editor_commands.proto"
	"common/commands/project_commands.proto"
	"common/envelope.proto"
	"common/types/base_types.proto"
	"common/types/enums.proto"
	"common/types/project_settings.proto"
	"schematic/schematic_commands.proto"
	"schematic/schematic_types.proto"
)

SRC_URI="$(pypi_sdist_url)"
for _p in "${PROTO_FILES[@]}"; do
	SRC_URI+=" ${KICAD_PROTO_BASE}/${_p} -> kicad-${KICAD_TAG}-${_p//\//-}"
done
unset _p

LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"

# Tests not included in PyPI sdist
RESTRICT="test"

# Regenerate protobuf files at build time to match system protobuf version
# Use := slot operator to trigger rebuild when protobuf is upgraded
RDEPEND="
	>=dev-python/protobuf-5.29:=[${PYTHON_USEDEP}]
	>=dev-python/pynng-0.8.0[${PYTHON_USEDEP}]
	<dev-python/pynng-0.9.0[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/typing-extensions-4.13.2[${PYTHON_USEDEP}]
	' python3_{10..12})
"
BDEPEND="
	${RDEPEND}
	dev-libs/protobuf[protoc(+)]
"

src_prepare() {
	# Remove build script config from pyproject.toml
	sed -i '/\[tool.poetry.build\]/,/^$/d' pyproject.toml || die
	rm -f setup.py build.py || die

	# Setup proto source directory
	local proto_src="${WORKDIR}/proto"
	mkdir -p "${proto_src}"/{board,common/commands,common/types,schematic} || die

	# Copy downloaded proto files to proper structure
	local _p _f
	for _p in "${PROTO_FILES[@]}"; do
		_f="kicad-${KICAD_TAG}-${_p//\//-}"
		cp "${DISTDIR}/${_f}" "${proto_src}/${_p}" || die
	done

	einfo "Regenerating protobuf files with system protoc..."

	# Remove only pre-generated _pb2.py and _pb2.pyi files, keep __init__.py
	find "${S}"/kipy/proto -name '*_pb2.py' -delete || die
	find "${S}"/kipy/proto -name '*_pb2.pyi' -delete || die
	rm -rf "${S}"/build/lib/kipy/proto || die

	# Compile all proto files (output to temp dir first)
	local proto_out="${WORKDIR}/proto_out"
	mkdir -p "${proto_out}" || die

	protoc \
		--proto_path="${proto_src}" \
		--python_out="${proto_out}" \
		--pyi_out="${proto_out}" \
		"${proto_src}"/board/*.proto \
		"${proto_src}"/common/*.proto \
		"${proto_src}"/common/commands/*.proto \
		"${proto_src}"/common/types/*.proto \
		"${proto_src}"/schematic/*.proto \
		|| die "protoc failed"

	# Copy only _pb2.py and _pb2.pyi files to kipy/proto, preserving original __init__.py
	find "${proto_out}" \( -name '*_pb2.py' -o -name '*_pb2.pyi' \) | while read -r f; do
		local rel="${f#${proto_out}/}"
		cp "${f}" "${S}/kipy/proto/${rel}" || die
	done

	# Fix imports: protoc generates absolute imports (e.g., "from common.types import ...")
	# but kipy expects them relative to kipy.proto (e.g., "from kipy.proto.common.types import ...")
	find "${S}/kipy/proto" \( -name '*_pb2.py' -o -name '*_pb2.pyi' \) -exec \
		sed -i -E \
			-e 's/^(from|import) (common|board|schematic)([ .])/\1 kipy.proto.\2\3/g' \
			{} + || die "failed to fix protobuf imports"

	distutils-r1_src_prepare
}
