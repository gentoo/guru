# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Python wheels for all tree sitter languages"
HOMEPAGE="
	https://github.com/grantjenks/py-tree-sitter-languages
	https://pypi.org/project/tree-sitter-languages/
"
TS="tree-sitter"
SRC_URI="
	https://github.com/grantjenks/py-${TS}-languages/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
	https://github.com/WhatsApp/${TS}-erlang/archive/54b6f814f43c4eac81eeedefaa7cc8762fec6683.tar.gz
		-> ${TS}-erlang-54b6f81.gh.tar.gz
	https://github.com/Azganoth/${TS}-lua/archive/6b02dfd7f07f36c223270e97eb0adf84e15a4cef.tar.gz
		-> ${TS}-lua-6b02dfd.gh.tar.gz
	https://github.com/Wilfred/${TS}-elisp/archive/4b0e4a3891337514126ec72c7af394c0ff2cf48c.tar.gz
		-> ${TS}-elisp-4b0e4a3.gh.tar.gz
	https://github.com/ZedThree/${TS}-fixed-form-fortran/archive/3142d317c73de80882beb95cc431af7eb6c28c51.tar.gz
		-> ${TS}-fixed-form-fortran-3142d31.gh.tar.gz
	https://github.com/alemuller/${TS}-make/archive/a4b9187417d6be349ee5fd4b6e77b4172c6827dd.tar.gz
		-> ${TS}-make-a4b9187.gh.tar.gz
	https://github.com/camdencheek/${TS}-dockerfile/archive/25c71d6a24cdba8f0c74ef40d4d2d93defd7e196.tar.gz
		-> ${TS}-dockerfile-25c71d6.gh.tar.gz
	https://github.com/camdencheek/${TS}-go-mod/archive/4a65743dbc2bb3094114dd2b43da03c820aa5234.tar.gz
		-> ${TS}-go-mod-4a65743.gh.tar.gz
	https://github.com/dhcmrlchtdj/${TS}-sqlite/archive/993be0a91c0c90b0cc7799e6ff65922390e2cefe.tar.gz
		-> ${TS}-sqlite-993be0a.gh.tar.gz
	https://github.com/elixir-lang/${TS}-elixir/archive/11426c5fd20eef360d5ecaf10729191f6bc5d715.tar.gz
		-> ${TS}-elixir-11426c5.gh.tar.gz
	https://github.com/elm-tooling/${TS}-elm/archive/c26afd7f2316f689410a1622f1780eff054994b1.tar.gz
		-> ${TS}-elm-c26afd7.gh.tar.gz
	https://github.com/fwcd/${TS}-kotlin/archive/0ef87892401bb01c84b40916e1f150197bc134b1.tar.gz
		-> ${TS}-kotlin-0ef8789.gh.tar.gz
	https://github.com/ganezdragon/${TS}-perl/archive/15a6914b9b891974c888ba7bf6c432665b920a3f.tar.gz
		-> ${TS}-perl-15a6914.gh.tar.gz
	https://github.com/ikatyang/${TS}-markdown/archive/8b8b77af0493e26d378135a3e7f5ae25b555b375.tar.gz
		-> ${TS}-markdown-8b8b77a.gh.tar.gz
	https://github.com/ikatyang/${TS}-yaml/archive/0e36bed171768908f331ff7dff9d956bae016efb.tar.gz
		-> ${TS}-yaml-0e36bed.gh.tar.gz
	https://github.com/jiyee/${TS}-objc/archive/afec0de5a32d5894070b67932d6ff09e4f7c5879.tar.gz
		-> ${TS}-objc-afec0de.gh.tar.gz
	https://github.com/m-novikov/${TS}-sql/archive/218b672499729ef71e4d66a949e4a1614488aeaa.tar.gz
		-> ${TS}-sql-218b672.gh.tar.gz
	https://github.com/MichaHoffmann/${TS}-hcl/archive/e135399cb31b95fac0760b094556d1d5ce84acf0.tar.gz
		-> ${TS}-hcl-e135399.gh.tar.gz
	https://github.com/r-lib/${TS}-r/archive/c55f8b4dfaa32c80ddef6c0ac0e79b05cb0cbf57.tar.gz
		-> ${TS}-r-c55f8b4.gh.tar.gz
	https://github.com/rydesun/${TS}-dot/archive/917230743aa10f45a408fea2ddb54bbbf5fbe7b7.tar.gz
		-> ${TS}-dot-9172307.gh.tar.gz
	https://github.com/slackhq/${TS}-hack/archive/fca1e294f6dce8ec5659233a6a21f5bd0ed5b4f2.tar.gz
		-> ${TS}-hack-fca1e29.gh.tar.gz
	https://github.com/stadelmanma/${TS}-fortran/archive/f73d473e3530862dee7cbb38520f28824e7804f6.tar.gz
		-> ${TS}-fortran-f73d473.gh.tar.gz
	https://github.com/stsewd/${TS}-rst/archive/3ba9eb9b5a47aadb1f2356a3cab0dd3d2bd00b4b.tar.gz
		-> ${TS}-rst-3ba9eb9.gh.tar.gz
	https://github.com/theHamsta/${TS}-commonlisp/archive/c7e814975ab0d0d04333d1f32391c41180c58919.tar.gz
		-> ${TS}-commonlisp-c7e8149.gh.tar.gz
	https://github.com/${TS}/${TS}-bash/archive/f7239f638d3dc16762563a9027faeee518ce1bd9.tar.gz
		-> ${TS}-bash-f7239f6.gh.tar.gz
	https://github.com/${TS}/${TS}-c/archive/34f4c7e751f4d661be3e23682fe2631d6615141d.tar.gz
		-> ${TS}-c-34f4c7e.gh.tar.gz
	https://github.com/${TS}/${TS}-c-sharp/archive/dd5e59721a5f8dae34604060833902b882023aaf.tar.gz
		-> ${TS}-c-sharp-dd5e597.gh.tar.gz
	https://github.com/${TS}/${TS}-cpp/archive/a71474021410973b29bfe99440d57bcd750246b1.tar.gz
		-> ${TS}-cpp-a714740.gh.tar.gz
	https://github.com/${TS}/${TS}-css/archive/98c7b3dceb24f1ee17f1322f3947e55638251c37.tar.gz
		-> ${TS}-css-98c7b3d.gh.tar.gz
	https://github.com/${TS}/${TS}-embedded-template/archive/203f7bd3c1bbfbd98fc19add4b8fcb213c059205.tar.gz
		-> ${TS}-embedded-template-203f7bd.gh.tar.gz
	https://github.com/${TS}/${TS}-go/archive/ff86c7f1734873c8c4874ca4dd95603695686d7a.tar.gz
		-> ${TS}-go-ff86c7f.gh.tar.gz
	https://github.com/${TS}/${TS}-haskell/archive/dd924b8df1eb76261f009e149fc6f3291c5081c2.tar.gz
		-> ${TS}-haskell-dd924b8.gh.tar.gz
	https://github.com/${TS}/${TS}-html/archive/949b78051835564bca937565241e5e337d838502.tar.gz
		-> ${TS}-html-949b780.gh.tar.gz
	https://github.com/${TS}/${TS}-java/archive/2b57cd9541f9fd3a89207d054ce8fbe72657c444.tar.gz
		-> ${TS}-java-2b57cd9.gh.tar.gz
	https://github.com/${TS}/${TS}-javascript/archive/f1e5a09b8d02f8209a68249c93f0ad647b228e6e.tar.gz
		-> ${TS}-javascript-f1e5a09.gh.tar.gz
	https://github.com/${TS}/${TS}-jsdoc/archive/d01984de49927c979b46ea5c01b78c8ddd79baf9.tar.gz
		-> ${TS}-jsdoc-d01984d.gh.tar.gz
	https://github.com/${TS}/${TS}-json/archive/3fef30de8aee74600f25ec2e319b62a1a870d51e.tar.gz
		-> ${TS}-json-3fef30d.gh.tar.gz
	https://github.com/${TS}/${TS}-julia/archive/0c088d1ad270f02c4e84189247ac7001e86fe342.tar.gz
		-> ${TS}-julia-0c088d1.gh.tar.gz
	https://github.com/${TS}/${TS}-ocaml/archive/4abfdc1c7af2c6c77a370aee974627be1c285b3b.tar.gz
		-> ${TS}-ocaml-4abfdc1.gh.tar.gz
	https://github.com/${TS}/${TS}-php/archive/33e30169e6f9bb29845c80afaa62a4a87f23f6d6.tar.gz
		-> ${TS}-php-33e3016.gh.tar.gz
	https://github.com/${TS}/${TS}-python/archive/4bfdd9033a2225cc95032ce77066b7aeca9e2efc.tar.gz
		-> ${TS}-python-4bfdd90.gh.tar.gz
	https://github.com/${TS}/${TS}-ql/archive/bd087020f0d8c183080ca615d38de0ec827aeeaf.tar.gz
		-> ${TS}-ql-bd08702.gh.tar.gz
	https://github.com/${TS}/${TS}-regex/archive/2354482d7e2e8f8ff33c1ef6c8aa5690410fbc96.tar.gz
		-> ${TS}-regex-2354482.gh.tar.gz
	https://github.com/${TS}/${TS}-ruby/archive/4d9ad3f010fdc47a8433adcf9ae30c8eb8475ae7.tar.gz
		-> ${TS}-ruby-4d9ad3f.gh.tar.gz
	https://github.com/${TS}/${TS}-rust/archive/e0e8b6de6e4aa354749c794f5f36a906dcccda74.tar.gz
		-> ${TS}-rust-e0e8b6d.gh.tar.gz
	https://github.com/${TS}/${TS}-scala/archive/45b5ba0e749a8477a8fd2666f082f352859bdc3c.tar.gz
		-> ${TS}-scala-45b5ba0.gh.tar.gz
	https://github.com/${TS}/${TS}-toml/archive/342d9be207c2dba869b9967124c679b5e6fd0ebe.tar.gz
		-> ${TS}-toml-342d9be.gh.tar.gz
	https://github.com/${TS}/${TS}-tsq/archive/b665659d3238e6036e22ed0e24935e60efb39415.tar.gz
		-> ${TS}-tsq-b665659.gh.tar.gz
	https://github.com/${TS}/${TS}-typescript/archive/d847898fec3fe596798c9fda55cb8c05a799001a.tar.gz
		-> ${TS}-typescript-d847898.gh.tar.gz
"
S="${WORKDIR}/py-${P}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/tree-sitter[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	test? (
		${RDEPEND}
	)
"

python_prepare_all() {
	mkdir "${S}/vendor"
	while read repo commit; do
		name="${repo##*/}"
		cp -r "${WORKDIR}/${name}-${commit}" "${S}/vendor/${name}"
	done < "${S}/repos.txt"

	distutils-r1_python_prepare_all
}

python_compile() {
	echo "Compiling the languages" # For some reason, the print statements in build.py are shown after the script ran
	"${EPYTHON}" build.py || die

	distutils-r1_python_compile
}

distutils_enable_tests pytest
python_test() {
	rm -rf tree_sitter_languages || die
	epytest
}
