# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop optfeature xdg-utils

DESCRIPTION="Nyxt - the hacker's power-browser"
HOMEPAGE="https://nyxt.atlas.engineer/"

if [[ "${PV}" = *9999* ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/atlas-engineer/${PN}.git"
else
	KEYWORDS="~amd64"
	MY_PV="3-pre-release-3"
	S="${WORKDIR}/${PN}-${MY_PV}"

	# Specify commits for each submodules
	# Some regex substitutions allows to automate this process...
	# Commit hashes are obtained from -9999 version on ${NYXTCOMMIT}
	# Full list can be found here: https://github.com/atlas-engineer/nyxt/tree/master/_build
	ALEXANDRIACOMMIT="f35e232ceb2ada8d10e7fdf27ccac07f781eea0e"
	NYXTRTCOMMIT="a6a7503a0b47953bc7579c90f02a6dba1f6e4c5a"
	BORDEAUXTHREADSCOMMIT="076fe2380abbc59b06e495dc7a35aea8eb26ba3b"
	FIVEAMCOMMIT="ec56fa7ce3955a751691cea1ff712afbdebc9bc4"
	ASDFFLVCOMMIT="fc5b7399767ca35bfb420bbeb9e08494e441dc69"
	LIFTCOMMIT="2594160d6ca3a77d8750110dfa63214256aab852"
	CALISPELCOMMIT="e9f2f9c1af97f4d7bb4c8ac25fb2a8f3e8fada7a"
	CLJPLUTILCOMMIT="0311ed374e19a49d43318064d729fe3abd9a3b62"
	EAGERFUTURECOMMIT="54df8effd9d9eccac917509590286b5ac5f9cb30"
	TRIVIALGARBAGECOMMIT="b1f757132a0f50aa844b99714b6bbaee974448f7"
	CLCONTAINERSCOMMIT="3d1df53c22403121bffb5d553cf7acb1503850e7"
	METATILITIESCOMMIT="6eaa9e3ff0939a93a92109dd0fcd218de85417d5"
	CLCUSTOMHASHTABLECOMMIT="f26983133940f5edf826ebbc8077acc04816ddfa"
	CLHTMLDIFFCOMMIT="5a0b39d1c524278d6f60851d7786bb2585614310"
	CLDIFFLIBCOMMIT="98eb335c693f1881584b83ca7be4a0fe05355c4e"
	CLJSONCOMMIT="6dfebb9540bfc3cc33582d0c03c9ec27cb913e79"
	CLPPCRECOMMIT="1ca0cd9ca0d161acd49c463d6cb5fff897596e2f"
	FLEXISTREAMSCOMMIT="e0de6bb62cb780650e808fe4de62c4be786ec7aa"
	TRIVIALGRAYSTREAMSCOMMIT="ebd59b1afed03b9dc8544320f8f432fdf92ab010"
	CLPREVALENCECOMMIT="e6b27640ce89ae5f8af38beb740e319bb6cd2368"
	SSYSDEPSCOMMIT="7f8de283b7fbd8b038fdf08493063a736db36ce7"
	USOCKETCOMMIT="fdf4fd1e0051ce83340ccfbbc8a43a462bb19cf2"
	SPLITSEQUENCECOMMIT="a5c593769b2fd4837d5b646cecbc9c7614f43344"
	CLOSERMOPCOMMIT="19c9d33f576e10715fd79cc1d4f688dab0f241d6"
	CLUFFERCOMMIT="4aad29c276a58a593064e79972ee4d77cae0af4a"
	ACCLIMATIONCOMMIT="4d51150902568fcd59335f4cc4cfa022df6116a5"
	CLUMPCOMMIT="1ea4dbac1cb86713acff9ae58727dd187d21048a"
	DEXADORCOMMIT="953090f04c4d1a9ee6632b90133cdc297b68badc"
	BABELCOMMIT="aeed2d1b76358db48e6b70a64399c05678a6b9ea"
	TRIVIALFEATURESCOMMIT="f6e8dd7268ae0137dbde4be469101a7f735f6416"
	HUDWIMSTEFILCOMMIT="414902c6f575818c39a8a156b8b61b1adfa73dad"
	HUDWIMASDFCOMMIT="67cdf84390e530af4303cc4bc815fdf2a5e48f59"
	FASTHTTPCOMMIT="502a37715dcb8544cc8528b78143a942de662c5a"
	PROCPARSECOMMIT="ac3636834d561bdc2686c956dbd82494537285fd"
	CLANSITEXTCOMMIT="53badf7878f27f22f2d4a2a43e6df458e43acbe9"
	CLCOLORSCOMMIT="827410584553f5c717eec6182343b7605f707f75"
	LETPLUSCOMMIT="5f14af61d501ecead02ec6b5a5c810efc0c9fdbb"
	ANAPHORACOMMIT="aeace4c68cf55098a67112750b28f8f2dc6d0e30"
	XSUBSEQCOMMIT="5ce430b3da5cda3a73b9cf5cee4df2843034422b"
	SMARTBUFFERCOMMIT="09b9a9a0b3abaa37abe9a730f5aac2643dca4e62"
	CLSYNTAXCOMMIT="03f0c329bbd55b8622c37161e6278366525e2ccc"
	CLANNOTCOMMIT="c99e69c15d935eabc671b483349a406e0da9518d"
	CLINTERPOLCOMMIT="70a1137f41dd8889004dbab9536b1adeac2497aa"
	CLUNICODECOMMIT="8073fc5634c9d4802888ac03abf11dfe383e16fa"
	NAMEDREADTABLESCOMMIT="585a28eee8b1b1999279b48cb7e9731187e14b66"
	TRIVIALTYPESCOMMIT="ee869f2b7504d8aa9a74403641a5b42b16f47d88"
	QURICOMMIT="bff2617a7d2c3f767c9407ec61ad04d277098278"
	FASTIOCOMMIT="603f4903dd74fb221859da7058ae6ca3853fe64b"
	STATICVECTORSCOMMIT="89fa07afcc3c0fb53b66361c29f85220b10c0bca"
	CFFICOMMIT="677cabae64b181330a3bbbda9c11891a2a8edcdc"
	CHECKLCOMMIT="80328800d047fef9b6e32dfe6bdc98396aee3cc9"
	CLMARSHALCOMMIT="eff1b15f2b0af2f26f71ad6a4dd5c4beab9299ec"
	CHUNGACOMMIT="16330852d01dfde4dd97dee7cd985a88ea571e7e"
	CLCOOKIECOMMIT="cea55aed8b9ad25fafd13defbcb9fe8f41b29546"
	LOCALTIMECOMMIT="a177eb911c0e8116e2bfceb79049265a884b701b"
	TRIVIALMIMESCOMMIT="fd07c43e6bc39fefee7608a41cc4c9286ef81e59"
	CLFADCOMMIT="c13d81c4bd9ba3a172631fd05dd213ab90e7d4cb"
	CHIPZCOMMIT="75dfbc660a5a28161c57f115adf74c8a926bfc4d"
	CLBASE64COMMIT="577683b18fd880b82274d99fc96a18a710e3987a"
	PTESTERCOMMIT="fe69fde54f4bce00ce577feb918796c293fc7253"
	KMRCLCOMMIT="4a27407aad9deb607ffb8847630cde3d041ea25a"
	CLREEXPORTCOMMIT="312f3661bbe187b5f28536cd7ec2956e91366c3b"
	CLPLUSSSLCOMMIT="09e896b04c112e7eb0f9d443a5801d557fbcd3ea"
	LACKCOMMIT="abff8efeb0c3a848e6bb0022f2b8b7fa3a1bc88b"
	CIRCULARSTREAMSCOMMIT="e770bade1919c5e8533dd2078c93c3d3bbeb38df"
	HTTPBODYCOMMIT="dd01dc4f5842e3d29728552e5163acce8386eb73"
	JONATHANCOMMIT="1f448b4f7ac8265e56e1c02b32ce383e65316300"
	IRONCLADCOMMIT="6cc4da8554558ee2e89ea38802bbf6d83100d4ea"
	CLACKCOMMIT="e3e032843bb1220ab96263c411aa7f2feb4746e0"
	CLFASTCGICOMMIT="de8b49b26de9863996ec18db28af8ab7e8ac4e20"
	HUNCHENTOOTCOMMIT="4b9da48807c09b8a7a72ca4b51b1f7f5cbef6ba4"
	MD5COMMIT="fd134e71b71a10ab78905833a7cb9d4d6817c589"
	RFC2388COMMIT="591bcf7e77f2c222c43953a80f8c297751dc0c4e"
	CLWHOCOMMIT="2c08caa4bafba720409af9171feeba3f32e86d32"
	DRAKMACOMMIT="d00401891a9038cd0928834bf96a9c33b2935ab8"
	PURICOMMIT="4bbab89d9ccbb26346899d1f496c97604fec567b"
	CLENCHANTCOMMIT="6af162a7bf10541cbcfcfa6513894900329713fa"
	FSETCOMMIT="6d2f9ded8934d2b42f2571a0ba5bda091037d852"
	DEVELCOMMIT="101c05112bf2f1e1bbf527396822d2f50ca6327a"
	HUDWIMDEFCLASSSTARCOMMIT="3086878a485074f9b2913c58267a9b764cd632fd"
	IOLIBCOMMIT="6977fa8c41c568150e5d559a70a584ca9b242c4c"
	IDNACOMMIT="bf789e6029b695ecba635964deac38130f55c7b4"
	SWAPBYTESCOMMIT="4f1f90284a0d73e931aeca0f0ee1d7884572fd34"
	LOG4CLCOMMIT="8c48d6f41d3a1475d0a91eed0638b9eecc398e35"
	STEFILCOMMIT="0398548ec95dceb50fc2c2c03e5fb0ce49b86c7a"
	METABANGBINDCOMMIT="c93b7f7e1c18c954c2283efd6a7fdab36746ab5e"
	SLIMECOMMIT="fb12bac676ab51b75be19197e21ab4674479d627"
	MOPTILITIESCOMMIT="a436f16b357c96b82397ec018ea469574c10dd41"
	PARENSCRIPTCOMMIT="7a1ac46353cecd144fc91915ba9f122aafcf4766"
	PLUMPCOMMIT="34f890fe46efdebe7bb70d218f1937e98f632bf9"
	ARRAYUTILSCOMMIT="f90eb9070d0b2205af51126a35033574725e5c56"
	DOCUMENTATIONUTILSCOMMIT="98630dd5f7e36ae057fa09da3523f42ccb5d1f55"
	TRIVIALINDENTCOMMIT="2d016941751647c6cc5bd471751c2cf68861c94a"
	PARACHUTECOMMIT="ca04dd8e43010a6dfffa26dbe1d62af86008d666"
	FORMFIDDLECOMMIT="e0c23599dbb8cff3e83e012f3d86d0764188ad18"
	SERAPEUMCOMMIT="c29a52ff0c5f6e60b09919c3a0daa8df7599ddb9"
	NCOMMIT="f304bdab86e7d689c15bdef9f3584dbabccebc54"
	TRIVIACOMMIT="7286d5d2a4f685f1cac8370816f95276c0851111"
	FAREQUASIQUOTECOMMIT="640d39a0451094071b3e093c97667b3947f43639"
	FAREUTILSCOMMIT="66e9c6f1499140bc00ccc22febf2aa528cbb5724"
	OPTIMACOMMIT="373b245b928c1a5cce91a6cb5bfe5dd77eb36195"
	EOSCOMMIT="b4413bccc4d142cbe1bf49516c3a0a22c9d99243"
	LISPNAMESPACECOMMIT="28107cafe34e4c1c67490fde60c7f92dc610b2e0"
	TRIVIALCLTL2COMMIT="8a3bda30dc25d2f65fcf514d0eb6e6db75252c61"
	TYPEICOMMIT="d34440ab4ebf5a46a58deccb35950b15670e3667"
	INTROSPECTENVIRONMENTCOMMIT="fff42f8f8fd0d99db5ad6c5812e53de7d660020b"
	STRINGCASECOMMIT="718c761e33749e297cd2809c7ba3ade1985c49f7"
	PARSENUMBERCOMMIT="7707b224c4b941c2cbd28459113534242cee3a31"
	PARSEDECLARATIONSCOMMIT="549aebbfb9403a7fe948654126b9c814f443f4f2"
	GLOBALVARSCOMMIT="c749f32c9b606a1457daa47d59630708ac0c266e"
	TRIVIALFILESIZECOMMIT="1c1d672a01a446ba0391dbb4ffc40be3b0476f23"
	TRIVIALMACROEXPANDALLCOMMIT="933270ac7107477de1bc92c1fd641fe646a7a8a9"
	CLSTRCOMMIT="f873716a991c270969c829ae911305f13c78311f"
	CLCHANGECASECOMMIT="45c70b601125889689e0c1c37d7e727a3a0af022"
	TRIVIALCLIPBOARDCOMMIT="8a580cb97196be7cf096548eb1f46794cd22bb39"
	TRIVIALPACKAGELOCALNICKNAMESCOMMIT="16b7ad4c2b120f50da65154191f468ea5598460e"
	UNIXOPTSCOMMIT="44823b077d0e4359e18fa4808f8e98ba46d2b692"
	CLCFFIGTKCOMMIT="e9a46df65995d9a16e6c8dbdc1e09b775eb4a966"
	CLWEBKITCOMMIT="bb0e15b513da28582314dd9efb2df38fee422f7e"
	CLGOBJECTINTROSPECTIONCOMMIT="d0136c8d9ade2560123af1fc55bbf70d2e3db539"
	LPARALLELCOMMIT="9c11f40018155a472c540b63684049acc9b36e15"
	JPLQUEUESCOMMIT="b774d24b3a2935b6e5ad17f83ff20ff359e2df81"
	MT19937COMMIT="831284f0c7fbda54ddfd135eee1e80afad7cc16e"
	SXMLCOMMIT="194cceaf90fb1a268d63f25f9b36e570af07cfb1"
	CLUTILITIESCOMMIT="dce2d2f6387091ea90357a130fa6d13a6776884b"
	CLQRENCODECOMMIT="0de2d8a3877b499a9a0bbb0a9e1247056ae4311e"
	CLSSCOMMIT="f62b849189c5d1be378f0bd3d403cda8d4fe310b"
	SPINNERETCOMMIT="52709ab953c46b24cbc2f0e3a50ae362916e730c"
	SALZA2COMMIT="dc8cda846c36b0b0b34601fbda207bc2dafa014d"
	ZPNGCOMMIT="c808a48eb9ece6f04eb25a11a2eedb738fd4f0e2"
	ITERATECOMMIT="b12ed5994137a67e15c46e6fd6f1ffd38d6bac81"
	RTCOMMIT="a6a7503a0b47953bc7579c90f02a6dba1f6e4c5a"
	OSICATCOMMIT="eab6b8cabd71b59e894b51dc555e171683ec3387"
	CLGOPHERCOMMIT="62cfd180378f56e7e8b57e4302b183810c86e337"
	PHOSCOMMIT="d9b03c3523a190a439a6e2417f75c5cdddd98313"
	CLTLDCOMMIT="f5014da8d831fa9481d4181d4450f10a52850c75"
	NFILESCOMMIT="98673fd4cf5b51003635a7f6e42469bce56b9b43"
	NKEYMAPSCOMMIT="d43267a56f0ac264e4bdb3c75bbfc426f5ac5b2e"
	SLYCOMMIT="b501b4335096fd4306c2c1eb86382b69e91c09e5"
	PYCONFIGPARSERCOMMIT="ea22fbde55cb91e2152fd1dcb28edc33423dbed6"
	DISSECTCOMMIT="82944bd7c3cd1b46a7a33ac0a7b004b51e9247f0"
	TRIVIALCUSTOMDEBUGGERCOMMIT="a560594a673bbcd88136af82086107ee5ff9ca81"
	NDEBUGCOMMIT="f5475e26363826d5382391ac38320b111e456918"
	LISPUNIT2COMMIT="0da1efc694d175c1eda60ee6451767ed2a73213d"
	OSPMCOMMIT="df261dedaa2e98f00b4b9ef6c41c08d231558682"
	MONTEZUMACOMMIT="ee2129eece7065760de4ebbaeffaadcb27644738"
	NSYMBOLSCOMMIT="873d855c2d86501341ab0eca1572a64aac7585a3"
	CLOSERMOPCOMMIT="60d05d6057bd2c8f37790989ffe2a2676c179f23"
	LASSCOMMIT="a7a4452f6a670b8fb01a73d3007030d16bd1ec2c"
	NJSONCOMMIT="960e0dde7397a154caa2afc75f61120c5eb9213b"
	HISTORYTREECOMMIT="f20e6bdf0c69e48946bcb1c3e7c707fc499c302c"
	TRIVIALBACKTRACECOMMIT="43ef7d947f4b4de767d0f91f28b50d9c03ad29d6"
	CLUNICODECOMMIT="2790a6b8912be1cb051437f463400b4a7198748a"

	SRC_URI="https://github.com/atlas-engineer/${PN}/archive/${MY_PV}.tar.gz -> ${P}.gh.tar.gz
		https://github.com/sionescu/bordeaux-threads/archive/${BORDEAUXTHREADSCOMMIT}.tar.gz -> \
			bordeaux-threads-${BORDEAUXTHREADSCOMMIT}.gh.tar.gz
		https://github.com/sionescu/fiveam/archive/${FIVEAMCOMMIT}.tar.gz -> fiream-${FIVEAMCOMMIT}.gh.tar.gz
		https://github.com/didierverna/asdf-flv/archive/${ASDFFLVCOMMIT}.tar.gz -> asdf-flv-${ASDFFLVCOMMIT}.gh.tar.gz
		https://github.com/gwkkwg/trivial-backtrace/archive/${TRIVIALBACKTRACECOMMIT}.tar.gz -> \
			trivial-backtrace-${TRIVIALBACKTRACECOMMIT}.gh.tar.gz
		https://github.com/gwkkwg/lift/archive/${LIFTCOMMIT}.tar.gz -> lift-${LIFTCOMMIT}.gh.tar.gz
		https://github.com/hawkir/calispel/archive/${CALISPELCOMMIT}.tar.gz -> \
			calispel-${CALISPELCOMMIT}.gh.tar.gz
		https://github.com/hawkir/cl-jpl-util/archive/${CLJPLUTILCOMMIT}.tar.gz -> \
			cl-jpl-util-${CLJPLUTILCOMMIT}.gh.tar.gz
		https://github.com/trivial-garbage/trivial-garbage/archive/${TRIVIALGARBAGECOMMIT}.tar.gz -> \
			trivial-garbage-${TRIVIALGARBAGECOMMIT}.gh.tar.gz
		https://github.com/gwkkwg/cl-containers/archive/${CLCONTAINERSCOMMIT}.tar.gz -> \
			cl-containers${CLCONTAINERSCOMMIT}.gh.tar.gz
		https://github.com/gwkkwg/metatilities-base/archive/${METATILITIESCOMMIT}.tar.gz -> \
			metatilities-base-${METATILITIESCOMMIT}.gh.tar.gz
		https://github.com/metawilm/cl-custom-hash-table/archive/${CLCUSTOMHASHTABLECOMMIT}.tar.gz -> \
			cl-custom-hash-table-${CLCUSTOMHASHTABLECOMMIT}.gh.tar.gz
		https://github.com/wiseman/cl-html-diff/archive/${CLHTMLDIFFCOMMIT}.tar.gz -> \
			cl-html-diff-${CLHTMLDIFFCOMMIT}.gh.tar.gz
		https://github.com/wiseman/cl-difflib/archive/${CLDIFFLIBCOMMIT}.tar.gz -> cl-difflib-${CLDIFFLIBCOMMIT}.gh.tar.gz
		https://github.com/hankhero/cl-json/archive/${CLJSONCOMMIT}.tar.gz -> cl-json-${CLJSONCOMMIT}.gh.tar.gz
		https://github.com/edicl/cl-ppcre/archive/${CLPPCRECOMMIT}.tar.gz -> \
			cl-ppcre-${CLPPCRECOMMIT}.gh.tar.gz
		https://github.com/edicl/flexi-streams/archive/${FLEXISTREAMSCOMMIT}.tar.gz -> \
			flexi-streams-${FLEXISTREAMSCOMMIT}.gh.tar.gz
		https://github.com/trivial-gray-streams/trivial-gray-streams/archive/${TRIVIALGRAYSTREAMSCOMMIT}.tar.gz -> \
			trivial-gray-streams-${TRIVIALGRAYSTREAMSCOMMIT}.gh.tar.gz
		https://github.com/40ants/cl-prevalence/archive/${CLPREVALENCECOMMIT}.tar.gz -> \
			cl-prevalence-${CLPREVALENCECOMMIT}.gh.tar.gz
		https://github.com/svenvc/s-sysdeps/archive/${SSYSDEPSCOMMIT}.tar.gz -> s-sysdeps-${SSYSDEPSCOMMIT}.gh.tar.gz
		https://github.com/usocket/usocket/archive/${USOCKETCOMMIT}.tar.gz -> usocket-${USOCKETCOMMIT}.gh.tar.gz
		https://github.com/sharplispers/split-sequence/archive/${SPLITSEQUENCECOMMIT}.tar.gz -> \
			split-sequence-${SPLITSEQUENCECOMMIT}.gh.tar.gz
		https://github.com/pcostanza/closer-mop/archive/${CLOSERMOPCOMMIT}.tar.gz -> closer-mop-${CLOSERMOPCOMMIT}.gh.tar.gz
		https://github.com/robert-strandh/cluffer/archive/${CLUFFERCOMMIT}.tar.gz -> cluffer-${CLUFFERCOMMIT}.gh.tar.gz
		https://github.com/robert-strandh/Acclimation/archive/${ACCLIMATIONCOMMIT}.tar.gz -> \
			acclimation-${ACCLIMATIONCOMMIT}.gh.tar.gz
		https://github.com/robert-strandh/Clump/archive/${CLUMPCOMMIT}.tar.gz -> clump-${CLUMPCOMMIT}.gh.tar.gz
		https://github.com/fukamachi/dexador/archive/${DEXADORCOMMIT}.tar.gz -> dexador-${DEXADORCOMMIT}.gh.tar.gz
		https://github.com/cl-babel/babel/archive/${BABELCOMMIT}.tar.gz -> babel-${BABELCOMMIT}.gh.tar.gz
		https://github.com/trivial-features/trivial-features/archive/${TRIVIALFEATURESCOMMIT}.tar.gz -> \
			trivial-features-${TRIVIALFEATURESCOMMIT}.gh.tar.gz
		https://github.com/hu-dwim/hu.dwim.stefil/archive/${HUDWIMSTEFILCOMMIT}.tar.gz -> \
			hu-dwim-stefil-${HUDWIMSTEFILCOMMIT}.gh.tar.gz
		https://github.com/hu-dwim/hu.dwim.asdf/archive/${HUDWIMASDFCOMMIT}.tar.gz -> \
			hu-dwim-asdf-${HUDWIMASDFCOMMIT}.gh.tar.gz
		https://github.com/fukamachi/fast-http/archive/${FASTHTTPCOMMIT}.tar.gz -> fast-http-${FASTHTTPCOMMIT}.gh.tar.gz
		https://github.com/fukamachi/proc-parse/archive/${PROCPARSECOMMIT}.tar.gz -> proc-parse-${PROCPARSECOMMIT}.gh.tar.gz
		https://github.com/pnathan/cl-ansi-text/archive/${CLANSITEXTCOMMIT}.tar.gz -> \
			cl-ansi-text-${CLANSITEXTCOMMIT}.gh.tar.gz
		https://github.com/tpapp/cl-colors/archive/${CLCOLORSCOMMIT}.tar.gz -> cl-colors-${CLCOLORSCOMMIT}.gh.tar.gz
		https://github.com/sharplispers/let-plus/archive/${LETPLUSCOMMIT}.tar.gz -> let-plus-${LETPLUSCOMMIT}.gh.tar.gz
		https://github.com/tokenrove/anaphora/archive/${ANAPHORACOMMIT}.tar.gz -> anaphora-${ANAPHORACOMMIT}.gh.tar.gz
		https://github.com/fukamachi/xsubseq/archive/${XSUBSEQCOMMIT}.tar.gz -> xsubseq-${XSUBSEQCOMMIT}.gh.tar.gz
		https://github.com/fukamachi/smart-buffer/archive/${SMARTBUFFERCOMMIT}.tar.gz -> \
			smart-buffer-${SMARTBUFFERCOMMIT}.gh.tar.gz
		https://github.com/m2ym/cl-syntax/archive/${CLSYNTAXCOMMIT}.tar.gz -> cl-syntax-${CLSYNTAXCOMMIT}.gh.tar.gz
		https://github.com/m2ym/cl-annot/archive/${CLANNOTCOMMIT}.tar.gz -> cl-annot-${CLANNOTCOMMIT}.gh.tar.gz
		https://github.com/edicl/cl-interpol/archive/${CLINTERPOLCOMMIT}.tar.gz -> cl-intelpol-${CLINTERPOLCOMMIT}.gh.tar.gz
		https://github.com/edicl/cl-unicode/archive/${CLUNICODECOMMIT}.tar.gz -> cl-unicode-${CLUNICODECOMMIT}.gh.tar.gz
		https://github.com/melisgl/named-readtables/archive/${NAMEDREADTABLESCOMMIT}.tar.gz -> \
			named-readtables-${NAMEDREADTABLESCOMMIT}.gh.tar.gz
		https://github.com/m2ym/trivial-types/archive/${TRIVIALTYPESCOMMIT}.tar.gz -> \
			trivial-types-${TRIVIALTYPESCOMMIT}.gh.tar.gz
		https://github.com/fukamachi/quri/archive/${QURICOMMIT}.tar.gz -> quri-${QURICOMMIT}.gh.tar.gz
		https://github.com/rpav/fast-io/archive/${FASTIOCOMMIT}.tar.gz -> fast-io-${FASTIOCOMMIT}.gh.tar.gz
		https://github.com/sionescu/static-vectors/archive/${STATICVECTORSCOMMIT}.tar.gz -> \
			static-vectors-${STATICVECTORSCOMMIT}.gh.tar.gz
		https://github.com/cffi/cffi/archive/${CFFICOMMIT}.tar.gz -> cffi-${CFFICOMMIT}.gh.tar.gz
		https://github.com/rpav/CheckL/archive/${CHECKLCOMMIT}.tar.gz -> checkl-${CHECKLCOMMIT}.gh.tar.gz
		https://github.com/wlbr/cl-marshal/archive/${CLMARSHALCOMMIT}.tar.gz -> cl-marshal-${CLMARSHALCOMMIT}.gh.tar.gz
		https://github.com/edicl/chunga/archive/${CHUNGACOMMIT}.tar.gz -> chunga-${CHUNGACOMMIT}.gh.tar.gz
		https://github.com/fukamachi/cl-cookie/archive/${CLCOOKIECOMMIT}.tar.gz -> cl-cookie-${CLCOOKIECOMMIT}.gh.tar.gz
		https://github.com/dlowe-net/local-time/archive/${LOCALTIMECOMMIT}.tar.gz -> local-time-${LOCALTIMECOMMIT}.gh.tar.gz
		https://github.com/Shinmera/trivial-mimes/archive/${TRIVIALMIMESCOMMIT}.tar.gz -> \
			trivial-mimes-${TRIVIALMIMESCOMMIT}.gh.tar.gz
		https://github.com/edicl/cl-fad//archive/${CLFADCOMMIT}.tar.gz -> cl-fad-${CLFADCOMMIT}.gh.tar.gz
		https://github.com/froydnj/chipz/archive/${CHIPZCOMMIT}.tar.gz -> chipz-${CHIPZCOMMIT}.gh.tar.gz
		https://github.com/takagi/cl-reexport/archive/${CLREEXPORTCOMMIT}.tar.gz -> cl-reexport-${CLREEXPORTCOMMIT}.gh.tar.gz
		https://github.com/cl-plus-ssl/cl-plus-ssl/archive/${CLPLUSSSLCOMMIT}.tar.gz -> \
			cl-plus-ssl-${CLPLUSSSLCOMMIT}.gh.tar.gz
		https://github.com/fukamachi/lack/archive/${LACKCOMMIT}.tar.gz -> lack-${LACKCOMMIT}.gh.tar.gz
		https://github.com/fukamachi/circular-streams/archive/${CIRCULARSTREAMSCOMMIT}.tar.gz -> \
			circular-streams-${CIRCULARSTREAMSCOMMIT}.gh.tar.gz
		https://github.com/fukamachi/http-body/archive/${HTTPBODYCOMMIT}.tar.gz -> http-body-${HTTPBODYCOMMIT}.gh.tar.gz
		https://github.com/Rudolph-Miller/jonathan/archive/${JONATHANCOMMIT}.tar.gz -> jonathan-${JONATHANCOMMIT}.gh.tar.gz
		https://github.com/sharplispers/ironclad/archive/${IRONCLADCOMMIT}.tar.gz -> ironclad-${IRONCLADCOMMIT}.gh.tar.gz
		https://github.com/fukamachi/clack/archive/${CLACKCOMMIT}.tar.gz -> clack-${CLACKCOMMIT}.gh.tar.gz
		https://github.com/KDr2/cl-fastcgi//archive/${CLFASTCGICOMMIT}.tar.gz -> cl-fastcgi-${CLFASTCGICOMMIT}.gh.tar.gz
		https://github.com/edicl/hunchentoot/archive/${HUNCHENTOOTCOMMIT}.tar.gz -> \
			hunchentoot-${HUNCHENTOOTCOMMIT}.gh.tar.gz
		https://github.com/pmai/md5/archive/${MD5COMMIT}.tar.gz -> mde-${MD5COMMIT}.gh.tar.gz
		https://github.com/jdz/rfc2388/archive/${RFC2388COMMIT}.tar.gz -> rfc2388-${RFC2388COMMIT}.gh.tar.gz
		https://github.com/edicl/cl-who/archive/${CLWHOCOMMIT}.tar.gz -> cl-who-${CLWHOCOMMIT}.gh.tar.gz
		https://github.com/edicl/drakma/archive/${DRAKMACOMMIT}.tar.gz -> drakma-${DRAKMACOMMIT}.gh.tar.gz
		https://github.com/tlikonen/cl-enchant/archive/${CLENCHANTCOMMIT}.tar.gz -> cl-enchant-${CLENCHANTCOMMIT}.gh.tar.gz
		https://github.com/slburson/fset/archive/${FSETCOMMIT}.tar.gz -> fset-${FSETCOMMIT}.gh.tar.gz
		https://github.com/hu-dwim/hu.dwim.defclass-star/archive/${HUDWIMDEFCLASSSTARCOMMIT}.tar.gz -> \
			hu-dwim-defclass-star-${HUDWIMDEFCLASSSTARCOMMIT}.gh.tar.gz
		https://github.com/sionescu/iolib/archive/${IOLIBCOMMIT}.tar.gz -> iolib-${IOLIBCOMMIT}.gh.tar.gz
		https://github.com/antifuchs/idna/archive/${IDNACOMMIT}.tar.gz -> idna-${IDNACOMMIT}.gh.tar.gz
		https://github.com/sionescu/swap-bytes/archive/${SWAPBYTESCOMMIT}.tar.gz -> swap-bytes-${SWAPBYTESCOMMIT}.gh.tar.gz
		https://github.com/sharplispers/log4cl/archive/${LOG4CLCOMMIT}.tar.gz -> log4cl-${LOG4CLCOMMIT}.gh.tar.gz
		https://github.com/gwkkwg/metabang-bind/archive/${METABANGBINDCOMMIT}.tar.gz -> \
			metabang-bind-${METABANGBINDCOMMIT}.gh.tar.gz
		https://github.com/slime/slime/archive/${SLIMECOMMIT}.tar.gz -> slime-${SLIMECOMMIT}.gh.tar.gz
		https://github.com/gwkkwg/moptilities/archive/${MOPTILITIESCOMMIT}.tar.gz -> \
			moptilities-${MOPTILITIESCOMMIT}.gh.tar.gz
		https://github.com/Shinmera/plump/archive/${PLUMPCOMMIT}.tar.gz -> plump-${PLUMPCOMMIT}.gh.tar.gz
		https://github.com/Shinmera/array-utils/archive/${ARRAYUTILSCOMMIT}.tar.gz -> \
			array-utils-${ARRAYUTILSCOMMIT}.gh.tar.gz
		https://github.com/Shinmera/documentation-utils/archive/${DOCUMENTATIONUTILSCOMMIT}.tar.gz -> \
			documentation-utils-${DOCUMENTATIONUTILSCOMMIT}.gh.tar.gz
		https://github.com/Shinmera/trivial-indent/archive/${TRIVIALINDENTCOMMIT}.tar.gz -> \
			trivial-indent-${TRIVIALINDENTCOMMIT}.gh.tar.gz
		https://github.com/Shinmera/parachute/archive/${PARACHUTECOMMIT}.tar.gz -> parachute-${PARACHUTECOMMIT}.gh.tar.gz
		https://github.com/Shinmera/form-fiddle/archive/${FORMFIDDLECOMMIT}.tar.gz -> \
			form-fiddle-${FORMFIDDLECOMMIT}.gh.tar.gz
		https://github.com/ruricolist/serapeum/archive/${SERAPEUMCOMMIT}.tar.gz -> serapeum-${SERAPEUMCOMMIT}.gh.tar.gz
		https://github.com/atlas-engineer/nhooks/archive/${NCOMMIT}.tar.gz -> nhooks-${NCOMMIT}.gh.tar.gz
		https://github.com/guicho271828/trivia/archive/${TRIVIACOMMIT}.tar.gz -> trivia-${TRIVIACOMMIT}.gh.tar.gz
		https://github.com/m2ym/optima/archive/${OPTIMACOMMIT}.tar.gz -> optima-${OPTIMACOMMIT}.gh.tar.gz
		https://github.com/adlai/Eos/archive/${EOSCOMMIT}.tar.gz -> eos-${EOSCOMMIT}.gh.tar.gz
		https://github.com/guicho271828/lisp-namespace/archive/${LISPNAMESPACECOMMIT}.tar.gz -> \
			lisp-namespace-${LISPNAMESPACECOMMIT}.gh.tar.gz
		https://github.com/Zulu-Inuoe/trivial-cltl2/archive/${TRIVIALCLTL2COMMIT}.tar.gz -> \
			trivial-cltl2-${TRIVIALCLTL2COMMIT}.gh.tar.gz
		https://github.com/guicho271828/type-i/archive/${TYPEICOMMIT}.tar.gz -> type-i-${TYPEICOMMIT}.gh.tar.gz
		https://github.com/Bike/introspect-environment/archive/${INTROSPECTENVIRONMENTCOMMIT}.tar.gz -> \
			introspect-environment-${INTROSPECTENVIRONMENTCOMMIT}.gh.tar.gz
		https://github.com/pkhuong/string-case/archive/${STRINGCASECOMMIT}.tar.gz -> \
			string-case-${STRINGCASECOMMIT}.gh.tar.gz
		https://github.com/sharplispers/parse-number/archive/${PARSENUMBERCOMMIT}.tar.gz -> \
			parse-number-${PARSENUMBERCOMMIT}.gh.tar.gz
		https://github.com/lmj/global-vars/archive/${GLOBALVARSCOMMIT}.tar.gz -> global-vars-${GLOBALVARSCOMMIT}.gh.tar.gz
		https://github.com/ruricolist/trivial-file-size/archive/${TRIVIALFILESIZECOMMIT}.tar.gz -> \
			trivial-file-size-${TRIVIALFILESIZECOMMIT}.gh.tar.gz
		https://github.com/cbaggers/trivial-macroexpand-all/archive/${TRIVIALMACROEXPANDALLCOMMIT}.tar.gz -> \
			trivial-macroexpand-all-${TRIVIALMACROEXPANDALLCOMMIT}.gh.tar.gz
		https://github.com/vindarel/cl-str/archive/${CLSTRCOMMIT}.tar.gz -> cl-str-${CLSTRCOMMIT}.gh.tar.gz
		https://github.com/rudolfochrist/cl-change-case/archive/${CLCHANGECASECOMMIT}.tar.gz -> \
			cl-change-case-${CLCHANGECASECOMMIT}.gh.tar.gz
		https://github.com/snmsts/trivial-clipboard/archive/${TRIVIALCLIPBOARDCOMMIT}.tar.gz -> \
			trivial-clipboard-${TRIVIALCLIPBOARDCOMMIT}.gh.tar.gz
		https://github.com/phoe/trivial-package-local-nicknames/archive/${TRIVIALPACKAGELOCALNICKNAMESCOMMIT}.tar.gz -> \
			trivial-package-local-nicknames-${TRIVIALPACKAGELOCALNICKNAMESCOMMIT}.gh.tar.gz
		https://github.com/libre-man/unix-opts/archive/${UNIXOPTSCOMMIT}.tar.gz -> unix-opts-${UNIXOPTSCOMMIT}.gh.tar.gz
		https://github.com/Ferada/cl-cffi-gtk/archive/${CLCFFIGTKCOMMIT}.tar.gz -> cl-cffi-gtk-${CLCFFIGTKCOMMIT}.gh.tar.gz
		https://github.com/joachifm/cl-webkit/archive/${CLWEBKITCOMMIT}.tar.gz -> cl-webkit-${CLWEBKITCOMMIT}.gh.tar.gz
		https://github.com/andy128k/cl-gobject-introspection/archive/${CLGOBJECTINTROSPECTIONCOMMIT}.tar.gz -> \
			cl-gobject-introspection-${CLGOBJECTINTROSPECTIONCOMMIT}.gh.tar.gz
		https://github.com/lmj/lparallel/archive/${LPARALLELCOMMIT}.tar.gz -> lparallel-${LPARALLELCOMMIT}.gh.tar.gz
		https://github.com/jnjcc/cl-qrencode/archive/${CLQRENCODECOMMIT}.tar.gz -> cl-qrencore-${CLQRENCODECOMMIT}.gh.tar.gz
		https://github.com/Shinmera/clss/archive/${CLSSCOMMIT}.tar.gz -> clss-${CLSSCOMMIT}.gh.tar.gz
		https://github.com/ruricolist/spinneret/archive/${SPINNERETCOMMIT}.tar.gz -> spinneret-${SPINNERETCOMMIT}.gh.tar.gz
		https://github.com/xach/salza2/archive/${SALZA2COMMIT}.tar.gz -> salza2-${SALZA2COMMIT}.gh.tar.gz
		https://github.com/xach/zpng/archive/${ZPNGCOMMIT}.tar.gz -> zpng-${ZPNGCOMMIT}.gh.tar.gz
		https://github.com/osicat/osicat/archive/${OSICATCOMMIT}.tar.gz -> osicat-${OSICATCOMMIT}.gh.tar.gz
		https://github.com/knusbaum/cl-gopher/archive/${CLGOPHERCOMMIT}.tar.gz -> cl-gopher-${CLGOPHERCOMMIT}.gh.tar.gz
		https://github.com/omar-polo/phos/archive/${PHOSCOMMIT}.tar.gz -> phos-${PHOSCOMMIT}.gh.tar.gz
		https://github.com/lu4nx/cl-tld/archive/${CLTLDCOMMIT}.tar.gz -> cl-tld-${CLTLDCOMMIT}.gh.tar.gz
		https://github.com/atlas-engineer/nfiles/archive/${NFILESCOMMIT}.tar.gz -> nfiles-${NFILESCOMMIT}.gh.tar.gz
		https://github.com/atlas-engineer/nkeymaps/archive/${NKEYMAPSCOMMIT}.tar.gz -> nkeymaps-${NKEYMAPSCOMMIT}.gh.tar.gz
		https://github.com/joaotavora/sly/archive/${SLYCOMMIT}.tar.gz -> sly-${SLYCOMMIT}.gh.tar.gz
		https://github.com/Shinmera/dissect/archive/${DISSECTCOMMIT}.tar.gz -> dissect-${DISSECTCOMMIT}.gh.tar.gz
		https://github.com/phoe/trivial-custom-debugger/archive/${TRIVIALCUSTOMDEBUGGERCOMMIT}.tar.gz -> \
			trivial-custom-debugger-${TRIVIALCUSTOMDEBUGGERCOMMIT}.gh.tar.gz
		https://github.com/atlas-engineer/ndebug/archive/${NDEBUGCOMMIT}.tar.gz -> ndebug-${NDEBUGCOMMIT}.gh.tar.gz
		https://github.com/AccelerationNet/lisp-unit2/archive/${LISPUNIT2COMMIT}.tar.gz -> \
			lisp-unit2-${LISPUNIT2COMMIT}.gh.tar.gz
		https://github.com/atlas-engineer/ospm/archive/${OSPMCOMMIT}.tar.gz -> ospm-${OSPMCOMMIT}.gh.tar.gz
		https://github.com/sharplispers/montezuma/archive/${MONTEZUMACOMMIT}.tar.gz -> montezuma-${MONTEZUMACOMMIT}.gh.tar.gz
		https://github.com/atlas-engineer/nsymbols/archive/${NSYMBOLSCOMMIT}.tar.gz -> nsymbols-${NSYMBOLSCOMMIT}.gh.tar.gz
		https://github.com/Shinmera/LASS/archive/${LASSCOMMIT}.tar.gz -> lass-${LASSCOMMIT}.gh.tar.gz
		https://github.com/atlas-engineer/njson/archive/${NJSONCOMMIT}.tar.gz -> njson-${NJSONCOMMIT}.gh.tar.gz
		https://github.com/atlas-engineer/history-tree/archive/${HISTORYTREECOMMIT}.tar.gz -> \
			history-tree-${HISTORYTREECOMMIT}.gh.tar.gz
		https://gitlab.common-lisp.net/alexandria/alexandria/-/archive/${ALEXANDRIACOMMIT}.tar.bz2 -> \
			alexandria-${ALEXANDRIACOMMIT}.tar.bz2
		https://gitlab.common-lisp.net/nyxt/rt/-/archive/${NYXTRTCOMMIT}.tar.bz2 -> rt-${NYXTRTCOMMIT}.tar.bz2
		https://gitlab.common-lisp.net/vsedach/eager-future2/-/archive/${EAGERFUTURECOMMIT}.tar.bz2 -> \
			eager-future2-${EAGERFUTURECOMMIT}.tar.bz2
		https://gitlab.common-lisp.net/nyxt/cl-base64/-/archive/${CLBASE64COMMIT}.tar.bz2 -> \
			cl-base64-${CLBASE64COMMIT}.tar.bz2
		https://gitlab.common-lisp.net/nyxt/ptester/-/archive/${PTESTERCOMMIT}.tar.bz2 -> ptester-${PTESTERCOMMIT}.tar.bz2
		https://gitlab.common-lisp.net/nyxt/kmrcl/-/archive/${KMRCLCOMMIT}.tar.bz2 -> kmrcl-${KMRCLCOMMIT}.tar.bz2
		https://gitlab.common-lisp.net/nyxt/puri/-/archive/${PURICOMMIT}.tar.bz2 -> pyri-${PURICOMMIT}.tar.bz2
		https://gitlab.common-lisp.net/stefil/stefil/-/archive/${STEFILCOMMIT}.tar.bz2 -> stefil-${STEFILCOMMIT}.tar.bz2
		https://gitlab.common-lisp.net/parenscript/parenscript/-/archive/${PARENSCRIPTCOMMIT}.tar.bz2 -> \
			parenscript-${PARENSCRIPTCOMMIT}.tar.bz2
		https://gitlab.common-lisp.net/frideau/fare-quasiquote/-/archive/${FAREQUASIQUOTECOMMIT}.tar.bz2 -> \
			fare-quasiquote-${FAREQUASIQUOTECOMMIT}.tar.bz2
		https://gitlab.common-lisp.net/frideau/fare-utils/-/archive/${FAREUTILSCOMMIT}.tar.bz2 -> \
			fare-utils-${FAREUTILSCOMMIT}.tar.bz2
		https://gitlab.common-lisp.net/nyxt/jpl-queues/-/archive/${JPLQUEUESCOMMIT}.tar.bz2 -> \
			jpl-queues-${JPLQUEUESCOMMIT}.tar.bz2
		https://gitlab.common-lisp.net/nyxt/mt19937/-/archive/${MT19937COMMIT}.tar.bz2 -> mt19937-${MT19937COMMIT}.tar.bz2
		https://gitlab.common-lisp.net/s-xml/s-xml/-/archive/${SXMLCOMMIT}.tar.bz2 -> s-xml-${SXMLCOMMIT}.tar.bz2
		https://gitlab.common-lisp.net/cl-utilities/cl-utilities/-/archive/${CLUTILITIESCOMMIT}.tar.bz2 -> \
			cl-utilities-${CLUTILITIESCOMMIT}.tar.bz2
		https://gitlab.common-lisp.net/rtoy/rt/-/archive/${RTCOMMIT}.tar.bz2 -> rt-${RTCOMMIT}.tar.bz2
		https://gitlab.common-lisp.net/nyxt/py-configparser/-/archive/${PYCONFIGPARSERCOMMIT}.tar.bz2 -> \
			py-configparser-${PYCONFIGPARSERCOMMIT}.tar.bz2
		https://gitlab.common-lisp.net/iterate/iterate/-/archive/${ITERATECOMMIT}.tar.bz2 -> iterate-${ITERATECOMMIT}.tar.bz2
		https://gitlab.common-lisp.net/parse-declarations/parse-declarations/-/archive/${PARSEDECLARATIONSCOMMIT}.tar.bz2 -> \
			parse-declarations-${PARSEDECLARATIONSCOMMIT}.tar.bz2
		https://gitlab.common-lisp.net/misc-extensions/devel/-/archive/${DEVELCOMMIT}.tar.bz2 -> devel-${DEVELCOMMIT}.tar.bz2
"
fi

# Portage replaces the nyxt binary with scbl when stripping
RESTRICT="mirror strip"

LICENSE="BSD CC-BY-SA-3.0"
SLOT="0"
IUSE="doc"

RDEPEND="
	dev-libs/gobject-introspection
	gnome-base/gsettings-desktop-schemas
	media-libs/gst-plugins-bad
	media-libs/gst-plugins-base
	media-libs/gst-plugins-good
	media-libs/gst-plugins-ugly
	media-plugins/gst-plugins-libav
	net-libs/glib-networking
	net-libs/webkit-gtk:4.1
	sys-libs/libfixposix
"

DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-lisp/sbcl-2.0.0
	!!net-libs/webkit-gtk:5
"
# If webkit-gtk:5 is installed, nyxt won't compile
# https://github.com/atlas-engineer/nyxt/issues/2743

src_unpack() {
	default

	# Unpack the submodules in the _build directory
	if [[ "${PV}" != *9999* ]]
	then
		mv "Acclimation-${ACCLIMATIONCOMMIT}" "${S}/_build" || die
		mv "alexandria-${ALEXANDRIACOMMIT}" "${S}/_build" || die
		mv "anaphora-${ANAPHORACOMMIT}" "${S}/_build" || die
		mv "array-utils-${ARRAYUTILSCOMMIT}" "${S}/_build" || die
		mv "asdf-flv-${ASDFFLVCOMMIT}" "${S}/_build" || die
		mv "babel-${BABELCOMMIT}" "${S}/_build" || die
		mv "bordeaux-threads-${BORDEAUXTHREADSCOMMIT}" "${S}/_build" || die
		mv "calispel-${CALISPELCOMMIT}" "${S}/_build" || die
		mv "cffi-${CFFICOMMIT}" "${S}/_build" || die
		mv "CheckL-${CHECKLCOMMIT}" "${S}/_build" || die
		mv "chipz-${CHIPZCOMMIT}" "${S}/_build" || die
		mv "chunga-${CHUNGACOMMIT}" "${S}/_build" || die
		mv "circular-streams-${CIRCULARSTREAMSCOMMIT}" "${S}/_build" || die
		mv "clack-${CLACKCOMMIT}" "${S}/_build" || die
		mv "cl-annot-${CLANNOTCOMMIT}" "${S}/_build" || die
		mv "cl-ansi-text-${CLANSITEXTCOMMIT}" "${S}/_build" || die
		mv "cl-base64-${CLBASE64COMMIT}" "${S}/_build" || die
		mv "cl-cffi-gtk-${CLCFFIGTKCOMMIT}" "${S}/_build" || die
		mv "cl-change-case-${CLCHANGECASECOMMIT}" "${S}/_build" || die
		mv "cl-colors-${CLCOLORSCOMMIT}" "${S}/_build" || die
		mv "cl-containers-${CLCONTAINERSCOMMIT}" "${S}/_build" || die
		mv "cl-cookie-${CLCOOKIECOMMIT}" "${S}/_build" || die
		mv "cl-custom-hash-table-${CLCUSTOMHASHTABLECOMMIT}" "${S}/_build" || die
		mv "cl-difflib-${CLDIFFLIBCOMMIT}" "${S}/_build" || die
		mv "cl-enchant-${CLENCHANTCOMMIT}" "${S}/_build" || die
		mv "cl-fad-${CLFADCOMMIT}" "${S}/_build" || die
		mv "cl-fastcgi-${CLFASTCGICOMMIT}" "${S}/_build" || die
		mv "cl-gobject-introspection-${CLGOBJECTINTROSPECTIONCOMMIT}" "${S}/_build" || die
		mv "cl-gopher-${CLGOPHERCOMMIT}" "${S}/_build" || die
		mv "cl-html-diff-${CLHTMLDIFFCOMMIT}" "${S}/_build" || die
		mv "cl-interpol-${CLINTERPOLCOMMIT}" "${S}/_build" || die
		mv "cl-jpl-util-${CLJPLUTILCOMMIT}" "${S}/_build" || die
		mv "cl-json-${CLJSONCOMMIT}" "${S}/_build" || die
		mv "cl-marshal-${CLMARSHALCOMMIT}" "${S}/_build" || die
		mv "closer-mop-${CLOSERMOPCOMMIT}" "${S}/_build" || die
		mv "cl-plus-ssl-${CLPLUSSSLCOMMIT}" "${S}/_build" || die
		mv "cl-ppcre-${CLPPCRECOMMIT}" "${S}/_build" || die
		mv "cl-prevalence-${CLPREVALENCECOMMIT}" "${S}/_build" || die
		mv "cl-qrencode-${CLQRENCODECOMMIT}" "${S}/_build" || die
		mv "cl-reexport-${CLREEXPORTCOMMIT}" "${S}/_build" || die
		mv "CLSS-${CLSSCOMMIT}" "${S}/_build" || die
		mv "cl-str-${CLSTRCOMMIT}" "${S}/_build" || die
		mv "cl-syntax-${CLSYNTAXCOMMIT}" "${S}/_build" || die
		mv "cl-tld-${CLTLDCOMMIT}" "${S}/_build" || die
		mv "Cluffer-${CLUFFERCOMMIT}" "${S}/_build" || die
		mv "Clump-${CLUMPCOMMIT}" "${S}/_build" || die
		mv "cl-unicode-${CLUNICODECOMMIT}" "${S}/_build" || die
		mv "cl-utilities-${CLUTILITIESCOMMIT}" "${S}/_build" || die
		mv "cl-webkit-${CLWEBKITCOMMIT}" "${S}/_build" || die
		mv "cl-who-${CLWHOCOMMIT}" "${S}/_build" || die
		mv "devel-${DEVELCOMMIT}" "${S}/_build" || die
		mv "dexador-${DEXADORCOMMIT}" "${S}/_build" || die
		mv "dissect-${DISSECTCOMMIT}" "${S}/_build" || die
		mv "documentation-utils-${DOCUMENTATIONUTILSCOMMIT}" "${S}/_build" || die
		mv "drakma-${DRAKMACOMMIT}" "${S}/_build" || die
		mv "eager-future2-${EAGERFUTURECOMMIT}" "${S}/_build" || die
		mv "Eos-${EOSCOMMIT}" "${S}/_build" || die
		mv "fare-quasiquote-${FAREQUASIQUOTECOMMIT}" "${S}/_build" || die
		mv "fare-utils-${FAREUTILSCOMMIT}" "${S}/_build" || die
		mv "fast-http-${FASTHTTPCOMMIT}" "${S}/_build" || die
		mv "fast-io-${FASTIOCOMMIT}" "${S}/_build" || die
		mv "fiveam-${FIVEAMCOMMIT}" "${S}/_build" || die
		mv "flexi-streams-${FLEXISTREAMSCOMMIT}" "${S}/_build" || die
		mv "form-fiddle-${FORMFIDDLECOMMIT}" "${S}/_build" || die
		mv "fset-${FSETCOMMIT}" "${S}/_build" || die
		mv "global-vars-${GLOBALVARSCOMMIT}" "${S}/_build" || die
		mv "history-tree-${HISTORYTREECOMMIT}" "${S}/_build" || die
		mv "http-body-${HTTPBODYCOMMIT}" "${S}/_build" || die
		mv "hu.dwim.asdf-${HUDWIMASDFCOMMIT}" "${S}/_build" || die
		mv "hu.dwim.defclass-star-${HUDWIMDEFCLASSSTARCOMMIT}" "${S}/_build" || die
		mv "hu.dwim.stefil-${HUDWIMSTEFILCOMMIT}" "${S}/_build" || die
		mv "hunchentoot-${HUNCHENTOOTCOMMIT}" "${S}/_build" || die
		mv "idna-${IDNACOMMIT}" "${S}/_build" || die
		mv "introspect-environment-${INTROSPECTENVIRONMENTCOMMIT}" "${S}/_build" || die
		mv "iolib-${IOLIBCOMMIT}" "${S}/_build" || die
		mv "ironclad-${IRONCLADCOMMIT}" "${S}/_build" || die
		mv "iterate-${ITERATECOMMIT}" "${S}/_build" || die
		mv "jonathan-${JONATHANCOMMIT}" "${S}/_build" || die
		mv "jpl-queues-${JPLQUEUESCOMMIT}" "${S}/_build" || die
		mv "kmrcl-${KMRCLCOMMIT}" "${S}/_build" || die
		mv "lack-${LACKCOMMIT}" "${S}/_build" || die
		mv "LASS-${LASSCOMMIT}" "${S}/_build" || die
		mv "let-plus-${LETPLUSCOMMIT}" "${S}/_build" || die
		mv "lift-${LIFTCOMMIT}" "${S}/_build" || die
		mv "lisp-namespace-${LISPNAMESPACECOMMIT}" "${S}/_build" || die
		mv "lisp-unit2-${LISPUNIT2COMMIT}" "${S}/_build" || die
		mv "local-time-${LOCALTIMECOMMIT}" "${S}/_build" || die
		mv "log4cl-${LOG4CLCOMMIT}" "${S}/_build" || die
		mv "lparallel-${LPARALLELCOMMIT}" "${S}/_build" || die
		mv "md5-${MD5COMMIT}" "${S}/_build" || die
		mv "metabang-bind-${METABANGBINDCOMMIT}" "${S}/_build" || die
		mv "metatilities-base-${METATILITIESCOMMIT}" "${S}/_build" || die
		mv "montezuma-${MONTEZUMACOMMIT}" "${S}/_build" || die
		mv "moptilities-${MOPTILITIESCOMMIT}" "${S}/_build" || die
		mv "mt19937-${MT19937COMMIT}" "${S}/_build" || die
		mv "named-readtables-${NAMEDREADTABLESCOMMIT}" "${S}/_build" || die
		mv "ndebug-${NDEBUGCOMMIT}" "${S}/_build" || die
		mv "nfiles-${NFILESCOMMIT}" "${S}/_build" || die
		mv "nhooks-${NCOMMIT}" "${S}/_build" || die
		mv "njson-${NJSONCOMMIT}" "${S}/_build" || die
		mv "nkeymaps-${NKEYMAPSCOMMIT}" "${S}/_build" || die
		mv "nsymbols-${NSYMBOLSCOMMIT}" "${S}/_build" || die
		mv "optima-${OPTIMACOMMIT}" "${S}/_build" || die
		mv "osicat-${OSICATCOMMIT}" "${S}/_build" || die
		mv "ospm-${OSPMCOMMIT}" "${S}/_build" || die
		mv "parachute-${PARACHUTECOMMIT}" "${S}/_build" || die
		mv "parenscript-${PARENSCRIPTCOMMIT}" "${S}/_build" || die
		mv "parse-declarations-${PARSEDECLARATIONSCOMMIT}" "${S}/_build" || die
		mv "parse-number-${PARSENUMBERCOMMIT}" "${S}/_build" || die
		mv "phos-${PHOSCOMMIT}" "${S}/_build" || die
		mv "plump-${PLUMPCOMMIT}" "${S}/_build" || die
		mv "proc-parse-${PROCPARSECOMMIT}" "${S}/_build" || die
		mv "ptester-${PTESTERCOMMIT}" "${S}/_build" || die
		mv "puri-${PURICOMMIT}" "${S}/_build" || die
		mv "py-configparser-${PYCONFIGPARSERCOMMIT}" "${S}/_build" || die
		mv "quri-${QURICOMMIT}" "${S}/_build" || die
		mv "rfc2388-${RFC2388COMMIT}" "${S}/_build" || die
		mv "rt-${RTCOMMIT}" "${S}/_build" || die
		mv "salza2-${SALZA2COMMIT}" "${S}/_build" || die
		mv "serapeum-${SERAPEUMCOMMIT}" "${S}/_build" || die
		mv "slime-${SLIMECOMMIT}" "${S}/_build" || die
		mv "sly-${SLYCOMMIT}" "${S}/_build" || die
		mv "smart-buffer-${SMARTBUFFERCOMMIT}" "${S}/_build" || die
		mv "spinneret-${SPINNERETCOMMIT}" "${S}/_build" || die
		mv "split-sequence-${SPLITSEQUENCECOMMIT}" "${S}/_build" || die
		mv "s-sysdeps-${SSYSDEPSCOMMIT}" "${S}/_build" || die
		mv "static-vectors-${STATICVECTORSCOMMIT}" "${S}/_build" || die
		mv "stefil-${STEFILCOMMIT}" "${S}/_build" || die
		mv "string-case-${STRINGCASECOMMIT}" "${S}/_build" || die
		mv "swap-bytes-${SWAPBYTESCOMMIT}" "${S}/_build" || die
		mv "s-xml-${SXMLCOMMIT}" "${S}/_build" || die
		mv "trivia-${TRIVIACOMMIT}" "${S}/_build" || die
		mv "trivial-backtrace-${TRIVIALBACKTRACECOMMIT}" "${S}/_build" || die
		mv "trivial-clipboard-${TRIVIALCLIPBOARDCOMMIT}" "${S}/_build" || die
		mv "trivial-cltl2-${TRIVIALCLTL2COMMIT}" "${S}/_build" || die
		mv "trivial-custom-debugger-${TRIVIALCUSTOMDEBUGGERCOMMIT}" "${S}/_build" || die
		mv "trivial-features-${TRIVIALFEATURESCOMMIT}" "${S}/_build" || die
		mv "trivial-file-size-${TRIVIALFILESIZECOMMIT}" "${S}/_build" || die
		mv "trivial-garbage-${TRIVIALGARBAGECOMMIT}" "${S}/_build" || die
		mv "trivial-gray-streams-${TRIVIALGRAYSTREAMSCOMMIT}" "${S}/_build" || die
		mv "trivial-indent-${TRIVIALINDENTCOMMIT}" "${S}/_build" || die
		mv "trivial-macroexpand-all-${TRIVIALMACROEXPANDALLCOMMIT}" "${S}/_build" || die
		mv "trivial-mimes-${TRIVIALMIMESCOMMIT}" "${S}/_build" || die
		mv "trivial-package-local-nicknames-${TRIVIALPACKAGELOCALNICKNAMESCOMMIT}" "${S}/_build" || die
		mv "trivial-types-${TRIVIALTYPESCOMMIT}" "${S}/_build" || die
		mv "type-i-${TYPEICOMMIT}" "${S}/_build" || die
		mv "unix-opts-${UNIXOPTSCOMMIT}" "${S}/_build" || die
		mv "usocket-${USOCKETCOMMIT}" "${S}/_build" || die
		mv "xsubseq-${XSUBSEQCOMMIT}" "${S}/_build" || die
		mv "zpng-${ZPNGCOMMIT}" "${S}/_build" || die
	fi
}

src_compile() {
	emake all
	use doc && emake doc
}

src_install(){
	dobin "${S}/nyxt"

	if [ "$(use doc)" ]
	then
		docinto "/usr/share/doc/${P}"
		dodoc "${S}/manual.html"
	fi

	doicon "${S}/assets/icon_512x512.png.ico"
	domenu "${S}/assets/nyxt.desktop"
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	xdg_icon_cache_update
	optfeature "for X11 clipboard support" "x11-misc/xclip"
	optfeature "for spellchecking" "app-text/enchant"
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}
