# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# The package version is based on the date all the commit hashes
# were generated, with an automatic script. You will need to change some capitalisations around.
# Script is at https://github.com/Matr1x-101/gentoo-helper-scripts/blob/main/darling-generate.sh
# TODO: Add USE flags for metal and multilib support (multlib depends on ABI x86="64 32")

EAPI=8
PYTHON_COMPAT=( python3_{10..14} )

inherit cmake flag-o-matic python-any-r1 check-reqs linux-info

DESCRIPTION="Translation layer for running macOS software on Linux"
HOMEPAGE="https://www.darlinghq.org"

SRC_URI="
	https://github.com/darlinghq/darling/archive/4a68f33a3af304814300d647ff8850bad87048dc.tar.gz
		-> darling-${PV}.tar.gz
	https://github.com/darlinghq/darling-libressl/archive/c5e9edb9d82ccf5fde5d8ae32b162fec8fe11318.tar.gz
		-> darling-libressl-2.2.9-${PV}.tar.gz
	https://github.com/darlinghq/darling-libressl/archive/1f663b5bdc9082178717c080e4728fe3e7084de4.tar.gz
		-> darling-libressl-2.5.5-${PV}.tar.gz
	https://github.com/darlinghq/darling-libressl/archive/30826df38d7c0f416158a94e0112c928188e0327.tar.gz
		-> darling-libressl-2.6.5-${PV}.tar.gz
	https://github.com/darlinghq/darling-libressl/archive/2a56b36b77a00573c53ccd8e6932eb136172c950.tar.gz
		-> darling-libressl-2.8.3-${PV}.tar.gz
	https://github.com/darlinghq/cctools-port/archive/d9456c221e1f462e17c0b3297748bc089d5a861e.tar.gz
		-> cctools-port-${PV}.tar.gz
	https://github.com/darlinghq/darling-adv_cmds/archive/56dcf5ebeb822650d7929f666be58544b2391f6e.tar.gz
		-> darling-adv_cmds-${PV}.tar.gz
	https://github.com/darlinghq/darling-apr/archive/5aa6eba89e497a67f1b9db7842371141a8616674.tar.gz
		-> darling-apr-${PV}.tar.gz
	https://github.com/darlinghq/darling-architecture/archive/63162c4744e9bd07673d4c29f8825f105f670e44.tar.gz
		-> darling-architecture-${PV}.tar.gz
	https://github.com/darlinghq/darling-AvailabilityVersions/archive/e28c029a8fa46fa933cbf6d6d9a1c00978c5fad1.tar.gz
		-> darling-AvailabilityVersions-${PV}.tar.gz
	https://github.com/darlinghq/darling-awk/archive/5d46e527461bce5fa10b89320a1c6ce5f1ae38b6.tar.gz
		-> darling-awk-${PV}.tar.gz
	https://github.com/darlinghq/darling-bash/archive/b6f335bb607258172356bb47c489230d479e55b0.tar.gz
		-> darling-bash-${PV}.tar.gz
	https://github.com/darlinghq/darling-basic_cmds/archive/b1ed4f0f6a981590542071d8b36535cf3e441be0.tar.gz
		-> darling-basic_cmds-${PV}.tar.gz
	https://github.com/darlinghq/darling-bc/archive/666e93c8223f509ae9c3c69e3c20af45d49a749c.tar.gz
		-> darling-bc-${PV}.tar.gz
	https://github.com/darlinghq/darling-BerkeleyDB/archive/1411173f0eb71f96ab6134de4e052d16acb8c673.tar.gz
		-> darling-BerkeleyDB-${PV}.tar.gz
	https://github.com/darlinghq/darling-bind9/archive/7542d50b3087edb4a46a2bdb11ba75034aa2bffa.tar.gz
		-> darling-bind9-${PV}.tar.gz
	https://github.com/darlinghq/darling-bmalloc/archive/66c88bc0b977ef843a9eaa706d586d9cec2608da.tar.gz
		-> darling-bmalloc-${PV}.tar.gz
	https://github.com/darlinghq/darling-bootstrap_cmds/archive/0f300a7a04bb1174a3b7db58b57d738aadc14e13.tar.gz
		-> darling-bootstrap_cmds-${PV}.tar.gz
	https://github.com/darlinghq/darling-bsm/archive/bec0dd61bb07469d1fcb3985822d350abc9934f7.tar.gz
		-> darling-bsm-${PV}.tar.gz
	https://github.com/darlinghq/darling-bzip2/archive/dc8c6839093afed1f288715260d32314ad362084.tar.gz
		-> darling-bzip2-${PV}.tar.gz
	https://github.com/darlinghq/darling-cctools/archive/8777b6dc7c4de87087c028e17db075795b3684d3.tar.gz
		-> darling-cctools-${PV}.tar.gz
	https://github.com/darlinghq/darling-cfnetwork/archive/e7e3db881008d883f82914765a72ce842bcba735.tar.gz
		-> darling-cfnetwork-${PV}.tar.gz
	https://github.com/darlinghq/darling-cocotron/archive/29720ecda116645910db015f7c893de92e86da67.tar.gz
		-> darling-cocotron-${PV}.tar.gz
	https://github.com/darlinghq/darling-commoncrypto/archive/910de477aac2c7af4cb2cc50e909f9b559502090.tar.gz
		-> darling-commoncrypto-${PV}.tar.gz
	https://github.com/darlinghq/darling-compiler-rt/archive/5fd9bc0effa307b99b35da59ce579e8e031c22da.tar.gz
		-> darling-compiler-rt-${PV}.tar.gz
	https://github.com/darlinghq/darling-configd/archive/b1627eefca647933ad84dc36b5adc73025a7e5c7.tar.gz
		-> darling-configd-${PV}.tar.gz
	https://github.com/darlinghq/darling-copyfile/archive/ed6094c9a2f8ba19aa55b7b504c3665797078e8f.tar.gz
		-> darling-copyfile-${PV}.tar.gz
	https://github.com/darlinghq/darling-corecrypto/archive/6868755769326c13c6cdb2b0689deb5731a932e3.tar.gz
		-> darling-corecrypto-${PV}.tar.gz
	https://github.com/darlinghq/darling-corefoundation/archive/ef09be6e9a691129733464dbc0df4910410d0889.tar.gz
		-> darling-corefoundation-${PV}.tar.gz
	https://github.com/darlinghq/darling-coretls/archive/b61a4f075726e7d5ef4652033f8d7b829c008d06.tar.gz
		-> darling-coretls-${PV}.tar.gz
	https://github.com/darlinghq/darling-crontabs/archive/b5bc00d2a75f6c622976e2ebbe244fb2d7d602ea.tar.gz
		-> darling-crontabs-${PV}.tar.gz
	https://github.com/darlinghq/darling-csu/archive/93b25cf0930a727b44fa50893bffd71056ad032f.tar.gz
		-> darling-csu-${PV}.tar.gz
	https://github.com/darlinghq/darling-cups/archive/51b7c251ef5ff81adc20284544394de8cc2e1315.tar.gz
		-> darling-cups-${PV}.tar.gz
	https://github.com/darlinghq/darling-curl/archive/92f54fd7eceabed2c2382a4acc0f7293dedd92ff.tar.gz
		-> darling-curl-${PV}.tar.gz
	https://github.com/darlinghq/darling-dbuskit/archive/890e51fda949e4dd2c46765e39074f790c10ca18.tar.gz
		-> darling-dbuskit-${PV}.tar.gz
	https://github.com/darlinghq/darling-DirectoryService/archive/feb9742f574ab812a210634fd3997f19b645095f.tar.gz
		-> darling-DirectoryService-${PV}.tar.gz
	https://github.com/darlinghq/darling-dmg/archive/1a6de10c5886c40a414090701b2520bd0417ce29.tar.gz
		-> darling-dmg-${PV}.tar.gz
	https://github.com/darlinghq/darling-doc_cmds/archive/60c6a2b858abe1f27b441f479aad2b0a9d0f9ba2.tar.gz
		-> darling-doc_cmds-${PV}.tar.gz
	https://github.com/darlinghq/darling-DSTools/archive/e015256b16965ac032412f2277c608c7213c03b3.tar.gz
		-> darling-DSTools-${PV}.tar.gz
	https://github.com/darlinghq/darling-dtrace/archive/4f52343b36756e32a81eb302242ac6472e9075fa.tar.gz
		-> darling-dtrace-${PV}.tar.gz
	https://github.com/darlinghq/darling-dyld/archive/63f667cf06d7ed59553adebb0c8d70a117135ac9.tar.gz
		-> darling-dyld-${PV}.tar.gz
	https://github.com/darlinghq/darling-energytrace/archive/e277fcfd430ddab2d8b52187cf480f2857629104.tar.gz
		-> darling-energytrace-${PV}.tar.gz
	https://github.com/darlinghq/darling-expat/archive/70006a0c32d7c8653c11e53fc0c905f1bb498218.tar.gz
		-> darling-expat-${PV}.tar.gz
	https://github.com/darlinghq/darling-file_cmds/archive/c0d72b5c98888a9d8e0b73cf8aac0df908e615f2.tar.gz
		-> darling-file_cmds-${PV}.tar.gz
	https://github.com/darlinghq/darling-file/archive/c6ee65265d253d24b1a496f8ca54b5e449fe108c.tar.gz
		-> darling-file-${PV}.tar.gz
	https://github.com/darlinghq/darling-files/archive/1c45a50ae0d6ca5bbb8b01d2b588f52bc0e39263.tar.gz
		-> darling-files-${PV}.tar.gz
	https://github.com/darlinghq/darling-foundation/archive/75cbb13e17b2b63087b9a03fc780aa482832be5a.tar.gz
		-> darling-foundation-${PV}.tar.gz
	https://github.com/darlinghq/darling-glut/archive/b53a2d8f0c6dc0c2052aef410a120d14ee553056.tar.gz
		-> darling-glut-${PV}.tar.gz
	https://github.com/darlinghq/darling-gnudiff/archive/ae0ab716658296164a032be7406f082cdc31c954.tar.gz
		-> darling-gnudiff-${PV}.tar.gz
	https://github.com/darlinghq/darling-gnutar/archive/1414bc8a8bd2e9dae701831e749febe2e2e84d68.tar.gz
		-> darling-gnutar-${PV}.tar.gz
	https://github.com/darlinghq/darling-gpatch/archive/49acc897e8cb832a26b7ac4d2f7db51d3c6ba037.tar.gz
		-> darling-gpatch-${PV}.tar.gz
	https://github.com/darlinghq/darling-grep/archive/62d70fada3a01de87aff927a86b8df0f7f2a837a.tar.gz
		-> darling-grep-${PV}.tar.gz
	https://github.com/darlinghq/darling-groff/archive/10dd5a6be4915a99065bc15dfc6b6b1e9e1a2714.tar.gz
		-> darling-groff-${PV}.tar.gz
	https://github.com/darlinghq/darling-Heimdal/archive/94a5c2feff43fb6661e10721d52a9c350c84bbb0.tar.gz
		-> darling-Heimdal-${PV}.tar.gz
	https://github.com/darlinghq/darling-icu/archive/6b609b2b0ce9a620543f357de4e549f09afec4ea.tar.gz
		-> darling-icu-${PV}.tar.gz
	https://github.com/darlinghq/darling-installer/archive/88764e6149f92f1747442c27ab00231f40de278c.tar.gz
		-> darling-installer-${PV}.tar.gz
	https://github.com/darlinghq/darling-IOGraphics/archive/905186151d713259296f3ae9458195a7097ea323.tar.gz
		-> darling-IOGraphics-${PV}.tar.gz
	https://github.com/darlinghq/darling-IOHIDFamily/archive/189e98e32092d5f5a2c365cc85fd36ac7da2d371.tar.gz
		-> darling-IOHIDFamily-${PV}.tar.gz
	https://github.com/darlinghq/darling-iokitd/archive/5549ac4cd2db923c256f016a1381b3bfb716730a.tar.gz
		-> darling-iokitd-${PV}.tar.gz
	https://github.com/darlinghq/darling-IOKitTools/archive/df58be2f134f7adbdd3c760a165ad3501ee82fb5.tar.gz
		-> darling-IOKitTools-${PV}.tar.gz
	https://github.com/darlinghq/darling-iokituser/archive/9843fd575a87926ab3cd3ee011215b97e90c1006.tar.gz
		-> darling-iokituser-${PV}.tar.gz
	https://github.com/darlinghq/darling-IONetworkingFamily/archive/28afb431947b8e8dbbb120db7632ba6de229bf23.tar.gz
		-> darling-IONetworkingFamily-${PV}.tar.gz
	https://github.com/darlinghq/darling-iostoragefamily/archive/33178aef923d9c99f1819db2ada253054f4dd812.tar.gz
		-> darling-iostoragefamily-${PV}.tar.gz
	https://github.com/darlinghq/darling-JavaScriptCore/archive/93410cc0dbc7a961d58d048c151117acdb18a566.tar.gz
		-> darling-JavaScriptCore-${PV}.tar.gz
	https://github.com/darlinghq/darling-keymgr/archive/43b4230aec2e9018b0ffd3069b8b23a34ba257fb.tar.gz
		-> darling-keymgr-${PV}.tar.gz
	https://github.com/darlinghq/darling-less/archive/a6bc77c8e72aaa35da92b903172a70eaa4ef78fa.tar.gz
		-> darling-less-${PV}.tar.gz
	https://github.com/darlinghq/darling-libarchive/archive/998d739c602a1b35e2377ec9161e9c13d1d8604d.tar.gz
		-> darling-libarchive-${PV}.tar.gz
	https://github.com/darlinghq/darling-libauto/archive/2be7312b25736a8e9fc12058d63cbb79eb5f4e25.tar.gz
		-> darling-libauto-${PV}.tar.gz
	https://github.com/darlinghq/darling-Libc/archive/5a38c8dabf9e76b39407c24bc13134e33e5594e6.tar.gz
		-> darling-Libc-${PV}.tar.gz
	https://github.com/darlinghq/darling-libclosure/archive/b4122f19c89512d9e930259a85c5f2674eff2b2b.tar.gz
		-> darling-libclosure-${PV}.tar.gz
	https://github.com/darlinghq/darling-libcxx/archive/c47677d3ba33bdabbfb07e75f531831579355a2d.tar.gz
		-> darling-libcxx-${PV}.tar.gz
	https://github.com/darlinghq/darling-libcxxabi/archive/c9c851718eb304a9aefa097aeaaf8c3bd1dff1bc.tar.gz
		-> darling-libcxxabi-${PV}.tar.gz
	https://github.com/darlinghq/darling-libdispatch/archive/380f03c180b80d940134fb35783ddc714784a53a.tar.gz
		-> darling-libdispatch-${PV}.tar.gz
	https://github.com/darlinghq/darling-libedit/archive/f9b44b8541614e33b09451fc2847f7e30bfb9b70.tar.gz
		-> darling-libedit-${PV}.tar.gz
	https://github.com/darlinghq/darling-libffi/archive/c796ec121cfd950aa5cc901ea47854a8431948ac.tar.gz
		-> darling-libffi-${PV}.tar.gz
	https://github.com/darlinghq/darling-libiconv/archive/0d6f47d33a7cc97e468e864099fff74875b41937.tar.gz
		-> darling-libiconv-${PV}.tar.gz
	https://github.com/darlinghq/darling-Libinfo/archive/30f771b21a0b6bcd937288b5fc25e5d29b75321d.tar.gz
		-> darling-Libinfo-${PV}.tar.gz
	https://github.com/darlinghq/darling-libkqueue/archive/f673c801cbc4011d3ae35301bb8b5073eb41c103.tar.gz
		-> darling-libkqueue-${PV}.tar.gz
	https://github.com/darlinghq/darling-liblzma/archive/855ebc93f8208ae4b6e77a018d4ba4a4be4d2ab7.tar.gz
		-> darling-liblzma-${PV}.tar.gz
	https://github.com/darlinghq/darling-libmalloc/archive/a57991e2651226a675654bd96e5d9ab6bec288c5.tar.gz
		-> darling-libmalloc-${PV}.tar.gz
	https://github.com/darlinghq/darling-libnetwork/archive/56c5fad43f24a40d8ca7f8a1d0badedfeaf7e64e.tar.gz
		-> darling-libnetwork-${PV}.tar.gz
	https://github.com/darlinghq/darling-Libnotify/archive/98156d3f847a3ced6c5f52c12a889047bc4f9b20.tar.gz
		-> darling-Libnotify-${PV}.tar.gz
	https://github.com/darlinghq/darling-libplatform/archive/5a3e5b529d25c70257dcfa97e94f1826e71e9f40.tar.gz
		-> darling-libplatform-${PV}.tar.gz
	https://github.com/darlinghq/darling-libpthread/archive/f07f265bfbcf071c1adfc808de971e053ea5edc5.tar.gz
		-> darling-libpthread-${PV}.tar.gz
	https://github.com/darlinghq/darling-libresolv/archive/af5c8ad53d5ff8ec65276b8432641067d9c30a24.tar.gz
		-> darling-libresolv-${PV}.tar.gz
	https://github.com/darlinghq/darling-librpcsvc/archive/0cc1d42e53c61446616719597e96b29aeda51eb3.tar.gz
		-> darling-librpcsvc-${PV}.tar.gz
	https://github.com/darlinghq/darling-libstdcxx/archive/73eb757fe23170c372bef17d6de41787c1271c80.tar.gz
		-> darling-libstdcxx-${PV}.tar.gz
	https://github.com/darlinghq/darling-Libsystem/archive/08df454b6eb0df9400aa4c39839a7efd6efd2c3c.tar.gz
		-> darling-Libsystem-${PV}.tar.gz
	https://github.com/darlinghq/darling-libtelnet/archive/1ebd4eef48d06e6411ed2a0f60ba5d3fce5ab455.tar.gz
		-> darling-libtelnet-${PV}.tar.gz
	https://github.com/darlinghq/darling-libtrace/archive/8cf07f02b15f7dca6436882a03678fff0392eaf6.tar.gz
		-> darling-libtrace-${PV}.tar.gz
	https://github.com/darlinghq/darling-libunwind/archive/a91da1a0e262e04eb601152a84228ff733e48422.tar.gz
		-> darling-libunwind-${PV}.tar.gz
	https://github.com/darlinghq/darling-libutil/archive/e3782a467c248c8d181aba1200ee0642abb65baf.tar.gz
		-> darling-libutil-${PV}.tar.gz
	https://github.com/darlinghq/darling-libxml2/archive/d4f2967c8ca84a23a886978098c0520fe2963b92.tar.gz
		-> darling-libxml2-${PV}.tar.gz
	https://github.com/darlinghq/darling-libxpc/archive/394e033333d3c253a12f08a99090c113b0917d00.tar.gz
		-> darling-libxpc-${PV}.tar.gz
	https://github.com/darlinghq/darling-libxslt/archive/50d22bd5b761a1885009b690e48d858ff73e768b.tar.gz
		-> darling-libxslt-${PV}.tar.gz
	https://github.com/darlinghq/darling-mail_cmds/archive/4afbcf4b9b8a6c33acaf7e9025e51ce72b3725a7.tar.gz
		-> darling-mail_cmds-${PV}.tar.gz
	https://github.com/darlinghq/darling-man/archive/9af6690f3c7c3c713bb0a20ba1163d3c4278257d.tar.gz
		-> darling-man-${PV}.tar.gz
	https://github.com/darlinghq/darling-mDNSResponder/archive/7e38ef562b4f3d41bffabb3e30d844d8042d3bbd.tar.gz
		-> darling-mDNSResponder-${PV}.tar.gz
	https://github.com/darlinghq/darling-metal/archive/f815654533fe0515f709bf4def29ae523b09414c.tar.gz
		-> darling-metal-${PV}.tar.gz
	https://github.com/darlinghq/darling-misc_cmds/archive/85b24ec0e2625d75e7ee75b597b9134a49d18b1f.tar.gz
		-> darling-misc_cmds-${PV}.tar.gz
	https://github.com/darlinghq/darling-MITKerberosShim/archive/39c014d0c54f9ae922be0d697aa6cc1b19c117b6.tar.gz
		-> darling-MITKerberosShim-${PV}.tar.gz
	https://github.com/darlinghq/darling-nano/archive/7514f5f1115fffedd8fc2095107ca86ff82c54d6.tar.gz
		-> darling-nano-${PV}.tar.gz
	https://github.com/darlinghq/darling-ncurses/archive/4cc72a9a1bce214593c10811b0154a8d51db0239.tar.gz
		-> darling-ncurses-${PV}.tar.gz
	https://github.com/darlinghq/darling-netcat/archive/fd29177d56d84f88406e33784c327ebabfe7be58.tar.gz
		-> darling-netcat-${PV}.tar.gz
	https://github.com/darlinghq/darling-network_cmds/archive/9a0a90e2021ecdde91986b91f65a236eda158023.tar.gz
		-> darling-network_cmds-${PV}.tar.gz
	https://github.com/darlinghq/darling-nghttp2/archive/1a1853837b4350d4393bd25e1e4cb6018ab2d918.tar.gz
		-> darling-nghttp2-${PV}.tar.gz
	https://github.com/darlinghq/darling-objc4/archive/1a12df76d12bfc9fdfffadb290f7742763568765.tar.gz
		-> darling-objc4-${PV}.tar.gz
	https://github.com/darlinghq/darling-openal/archive/7c60cf7109b7a3a8f5d41ed8b84d340a8d768525.tar.gz
		-> darling-openal-${PV}.tar.gz
	https://github.com/darlinghq/darling-opendirectory/archive/750636a898284fb392a10603ac7894658b632678.tar.gz
		-> darling-opendirectory-${PV}.tar.gz
	https://github.com/darlinghq/darling-openjdk/archive/5a541c1844a9508e48b3addaf2d38775683abb38.tar.gz
		-> darling-openjdk-${PV}.tar.gz
	https://github.com/darlinghq/darling-OpenLDAP/archive/3b15390bbcad8234aabb3246b0552105b17118d0.tar.gz
		-> darling-OpenLDAP-${PV}.tar.gz
	https://github.com/darlinghq/darling-openpam/archive/8362545bac04032fcf59287cd66e6f4662a3692b.tar.gz
		-> darling-openpam-${PV}.tar.gz
	https://github.com/darlinghq/darling-openssh/archive/9137305e5793d31124bcf2fdf0c6fa28c2e3e812.tar.gz
		-> darling-openssh-${PV}.tar.gz
	https://github.com/darlinghq/darling-openssl_certificates/archive/cca4f47e3ca18b58961157ef0ec6a6fc135b8cd2.tar.gz
		-> darling-openssl_certificates-${PV}.tar.gz
	https://github.com/darlinghq/darling-openssl/archive/dc7bf84efa5a0befa0d970d4d5177853ac448d6f.tar.gz
		-> darling-openssl-${PV}.tar.gz
	https://github.com/darlinghq/darling-pam_modules/archive/241bbee0da845d1dfebc747b16a62aaed22f165b.tar.gz
		-> darling-pam_modules-${PV}.tar.gz
	https://github.com/darlinghq/darling-passwordserver_sasl/archive/794093ece0203718ce5da5645a689b5c6e766208.tar.gz
		-> darling-passwordserver_sasl-${PV}.tar.gz
	https://github.com/darlinghq/darling-patch_cmds/archive/0670c7fbadfd715ac78d5476552788416cad0020.tar.gz
		-> darling-patch_cmds-${PV}.tar.gz
	https://github.com/darlinghq/darling-pcre/archive/6f67e33869a2b08da9465034c41e64e16fc7faf9.tar.gz
		-> darling-pcre-${PV}.tar.gz
	https://github.com/darlinghq/darling-perl/archive/a65d68be2146d85928e511aabc8f3a2b05e564ba.tar.gz
		-> darling-perl-${PV}.tar.gz
	https://github.com/darlinghq/darling-pyobjc/archive/c0912a6c46c25e958eeb70f47f046b5a55ebb387.tar.gz
		-> darling-pyobjc-${PV}.tar.gz
	https://github.com/darlinghq/darling-python_modules/archive/24d01b41cb38fafc810cdd27562224c4014a4761.tar.gz
		-> darling-python_modules-${PV}.tar.gz
	https://github.com/darlinghq/darling-python/archive/4856509729cc320006a1235291e47408cd7b13ce.tar.gz
		-> darling-python-${PV}.tar.gz
	https://github.com/darlinghq/darling-remote_cmds/archive/3bb9f88724726d0d3073c04dfdc4785564113341.tar.gz
		-> darling-remote_cmds-${PV}.tar.gz
	https://github.com/darlinghq/darling-removefile/archive/24b6d73021fe355811986b21f9adfeb1f23df044.tar.gz
		-> darling-removefile-${PV}.tar.gz
	https://github.com/darlinghq/darling-rsync/archive/316c5b6b2780a28179f692f3fc0d63ebc2985705.tar.gz
		-> darling-rsync-${PV}.tar.gz
	https://github.com/darlinghq/darling-ruby/archive/423f2439478d2e24d7c19b2e0ea4a67ee3e80c3d.tar.gz
		-> darling-ruby-${PV}.tar.gz
	https://github.com/darlinghq/darling-screen/archive/4bed52587563ede850bf9ff834567478ac1e616b.tar.gz
		-> darling-screen-${PV}.tar.gz
	https://github.com/darlinghq/darling-security/archive/3cfffcf2c5b5900169c964facdf42cc05c23005c.tar.gz
		-> darling-security-${PV}.tar.gz
	https://github.com/darlinghq/darling-SecurityTokend/archive/c826860db4061667af6f0c3aa55282aab0924e1a.tar.gz
		-> darling-SecurityTokend-${PV}.tar.gz
	https://github.com/darlinghq/darling-shell_cmds/archive/5191dabbeff0aec230fc1275bae1653281ba52b2.tar.gz
		-> darling-shell_cmds-${PV}.tar.gz
	https://github.com/darlinghq/darling-SmartCardServices/archive/ec53ce56972565047a716ab166176f203f520393.tar.gz
		-> darling-SmartCardServices-${PV}.tar.gz
	https://github.com/darlinghq/darling-sqlite/archive/3472e2568cb7fcc25fe91af80da8d2fe884d9ac0.tar.gz
		-> darling-sqlite-${PV}.tar.gz
	https://github.com/darlinghq/darling-swift/archive/471514f4b4985a604b192e1facac9bbc53dedad3.tar.gz
		-> darling-swift-${PV}.tar.gz
	https://github.com/darlinghq/darling-swift-corelibs-foundation/archive/ea1ea0bb416025a8cc5a282df03c2e8f12788e2d.tar.gz
		-> darling-swift-corelibs-foundation-${PV}.tar.gz
	https://github.com/darlinghq/darling-syslog/archive/36ab27964cac4affe3907a598047bd21b8958919.tar.gz
		-> darling-syslog-${PV}.tar.gz
	https://github.com/darlinghq/darling-system_cmds/archive/b01129f3dc0ecab524dbd0fd08e29ec9f0e18196.tar.gz
		-> darling-system_cmds-${PV}.tar.gz
	https://github.com/darlinghq/darling-tcsh/archive/7737644ec31303be19c533aab093209f3458e060.tar.gz
		-> darling-tcsh-${PV}.tar.gz
	https://github.com/darlinghq/darling-text_cmds/archive/3edd740c82b8b87c17ec9cfaae7606f6176626df.tar.gz
		-> darling-text_cmds-${PV}.tar.gz
	https://github.com/darlinghq/darling-TextEdit/archive/99ec72a94dab166eefa264e9802ebd0d80aca845.tar.gz
		-> darling-TextEdit-${PV}.tar.gz
	https://github.com/darlinghq/darling-top/archive/4e27f81b5cfeef9d31d8fe5d938a80d26cca9ab5.tar.gz
		-> darling-top-${PV}.tar.gz
	https://github.com/darlinghq/darling-usertemplate/archive/5f8cca97aa03ff9290d6ccc0a4d185aa1a913875.tar.gz
		-> darling-usertemplate-${PV}.tar.gz
	https://github.com/darlinghq/darling-vim/archive/7f8da1dd66fc8f0654ebfa597b6013c8cf15185a.tar.gz
		-> darling-vim-${PV}.tar.gz
	https://github.com/darlinghq/darling-WebCore/archive/47fac4c8130ea9afc9b9df68c81ade56ca7ea57e.tar.gz
		-> darling-WebCore-${PV}.tar.gz
	https://github.com/darlinghq/darling-WTF/archive/88a36e496a6f285a9e15140c2c431b817bae353b.tar.gz
		-> darling-WTF-${PV}.tar.gz
	https://github.com/darlinghq/darling-xar/archive/887bd4f42eb4ac9139a7f621b5811065aa86f3e3.tar.gz
		-> darling-xar-${PV}.tar.gz
	https://github.com/darlinghq/darling-xnu/archive/5f26a4c2365d9774b5a1e66ae7da20b61ab6d2db.tar.gz
		-> darling-xnu-${PV}.tar.gz
	https://github.com/darlinghq/darling-zip/archive/caf41ebbc3ebab0250e4d13aa42221ef91a9802c.tar.gz
		-> darling-zip-${PV}.tar.gz
	https://github.com/darlinghq/darling-zlib/archive/677de9b1c2bea1e428f56d8fc63300aa471eaf99.tar.gz
		-> darling-zlib-${PV}.tar.gz
	https://github.com/darlinghq/darling-zsh/archive/4a7a6ebf6216395c7db698a4993db16e484aa54d.tar.gz
		-> darling-zsh-${PV}.tar.gz
	https://github.com/darlinghq/darling/archive/4a68f33a3af304814300d647ff8850bad87048dc.tar.gz
		-> darling-${PV}.tar.gz
	https://github.com/darlinghq/darlingserver/archive/89751e64bc6c2082f7725061824ee0e33395b0de.tar.gz
		-> darlingserver-${PV}.tar.gz
	https://github.com/darlinghq/fmdb/archive/ad2fdd660d02c24b262d64d7d23d3d4645768f44.tar.gz
		-> fmdb-${PV}.tar.gz
	https://github.com/darlinghq/indium/archive/8423a7d2f053167030d2bc4a227f96243c740667.tar.gz
		-> indium-${PV}.tar.gz
	https://github.com/darlinghq/lzfse/archive/451f291743bb919cb1b78ced4110402fca52cf97.tar.gz
		-> lzfse-${PV}.tar.gz
	https://github.com/darlinghq/xcbuild/archive/a903c6952fc5617816113cbb7b551ac701dba2ff.tar.gz
		-> xcbuild-${PV}.tar.gz
"

S="${WORKDIR}/darling-4a68f33a3af304814300d647ff8850bad87048dc"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	x11-misc/xdg-user-dirs
	sys-fs/fuse:0
	media-libs/freetype
	media-libs/libjpeg-turbo
	media-libs/libpng:=
	media-libs/tiff:=
	media-libs/giflib:=
	media-libs/mesa[X]
	virtual/opengl
	virtual/glu
	media-libs/fontconfig
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrandr
	x11-libs/libXcursor
	x11-libs/libxkbfile
	x11-libs/cairo
	sys-apps/dbus
	media-video/ffmpeg:=
	media-libs/libpulse
	dev-libs/icu:=
	dev-libs/libbsd
	dev-libs/libxml2:2
	media-libs/vulkan-loader
	llvm-core/llvm:=
"

BDEPEND="
	>=llvm-core/clang-11
	sys-devel/flex
	sys-devel/bison
	dev-build/cmake
	virtual/pkgconfig
	llvm-core/llvm:=
	${PYTHON_DEPS}
	dev-util/vulkan-headers
"

RDEPEND="${DEPEND}"

QA_SONAME="*"

pkg_pretend(){
	# https://unix.stackexchange.com/questions/131954/check-sse3-support-from-bash
	if ! grep -qE '^flags.* (sse3|pni)' /proc/cpuinfo; then
		eerror "darling requires a cpu with support of the sse3 instruction set"
		die "cpu doesn't support sse3 instruction set"
	fi

	if kernel_is -lt 5 0; then
		eerror "darling requires Linux kernel 5.0 or newer to be installed"
		die "darling requires Linux kernel 5.0 or newer"
	fi

	CHECKREQS_DISK_BUILD="16G"
	CHECKREQS_MEMORY="4G"

	check-reqs_pkg_pretend
}

pkg_setup(){
	# https://unix.stackexchange.com/questions/131954/check-sse3-support-from-bash
	if ! grep -qE '^flags.* (sse3|pni)' /proc/cpuinfo; then
		eerror "darling requires a cpu with support of the sse3 instruction set"
		die "cpu doesn't support sse3 instruction set"
	fi

	if kernel_is -lt 5 0; then
		eerror "darling requires Linux kernel 5.0 or newer to be installed"
		die "darling requires Linux kernel 5.0 or newer"
	fi

	CHECKREQS_DISK_BUILD="16G"
	CHECKREQS_MEMORY="4G"

	check-reqs_pkg_setup
	python-any-r1_pkg_setup
}

src_prepare() {
	default

	# Move all submodules to their correct locations
	# GitHub archives extract to reponame-commithash format
	cd "${S}/src/external/"
	find . -type d -empty -delete -maxdepth 1

	mv "${WORKDIR}/darling-libressl-c5e9edb9d82ccf5fde5d8ae32b162fec8fe11318" \
		"${S}/src/external/libressl-2.2.9" || die
	mv "${WORKDIR}/darling-libressl-1f663b5bdc9082178717c080e4728fe3e7084de4" \
		"${S}/src/external/libressl-2.5.5" || die
	mv "${WORKDIR}/darling-libressl-30826df38d7c0f416158a94e0112c928188e0327" \
		"${S}/src/external/libressl-2.6.5" || die
	mv "${WORKDIR}/darling-libressl-2a56b36b77a00573c53ccd8e6932eb136172c950" \
		"${S}/src/external/libressl-2.8.3" || die
	mv "${WORKDIR}/cctools-port-d9456c221e1f462e17c0b3297748bc089d5a861e" \
		"${S}/src/external/cctools-port" || die
	mv "${WORKDIR}/darling-adv_cmds-56dcf5ebeb822650d7929f666be58544b2391f6e" \
		"${S}/src/external/adv_cmds" || die
	mv "${WORKDIR}/darling-apr-5aa6eba89e497a67f1b9db7842371141a8616674" \
		"${S}/src/external/apr" || die
	mv "${WORKDIR}/darling-architecture-63162c4744e9bd07673d4c29f8825f105f670e44" \
		"${S}/src/external/architecture" || die
	mv "${WORKDIR}/darling-AvailabilityVersions-e28c029a8fa46fa933cbf6d6d9a1c00978c5fad1" \
		"${S}/src/external/AvailabilityVersions" || die
	mv "${WORKDIR}/darling-awk-5d46e527461bce5fa10b89320a1c6ce5f1ae38b6" \
		"${S}/src/external/awk" || die
	mv "${WORKDIR}/darling-bash-b6f335bb607258172356bb47c489230d479e55b0" \
		"${S}/src/external/bash" || die
	mv "${WORKDIR}/darling-basic_cmds-b1ed4f0f6a981590542071d8b36535cf3e441be0" \
		"${S}/src/external/basic_cmds" || die
	mv "${WORKDIR}/darling-bc-666e93c8223f509ae9c3c69e3c20af45d49a749c" \
		"${S}/src/external/bc" || die
	mv "${WORKDIR}/darling-BerkeleyDB-1411173f0eb71f96ab6134de4e052d16acb8c673" \
		"${S}/src/external/BerkeleyDB" || die
	mv "${WORKDIR}/darling-bind9-7542d50b3087edb4a46a2bdb11ba75034aa2bffa" \
		"${S}/src/external/bind9" || die
	mv "${WORKDIR}/darling-bmalloc-66c88bc0b977ef843a9eaa706d586d9cec2608da" \
		"${S}/src/external/bmalloc" || die
	mv "${WORKDIR}/darling-bootstrap_cmds-0f300a7a04bb1174a3b7db58b57d738aadc14e13" \
		"${S}/src/external/bootstrap_cmds" || die
	mv "${WORKDIR}/darling-bsm-bec0dd61bb07469d1fcb3985822d350abc9934f7" \
		"${S}/src/external/bsm" || die
	mv "${WORKDIR}/darling-bzip2-dc8c6839093afed1f288715260d32314ad362084" \
		"${S}/src/external/bzip2" || die
	mv "${WORKDIR}/darling-cctools-8777b6dc7c4de87087c028e17db075795b3684d3" \
		"${S}/src/external/cctools" || die
	mv "${WORKDIR}/darling-cfnetwork-e7e3db881008d883f82914765a72ce842bcba735" \
		"${S}/src/external/cfnetwork" || die
	mv "${WORKDIR}/darling-cocotron-29720ecda116645910db015f7c893de92e86da67" \
		"${S}/src/external/cocotron" || die
	mv "${WORKDIR}/darling-commoncrypto-910de477aac2c7af4cb2cc50e909f9b559502090" \
		"${S}/src/external/commoncrypto" || die
	mv "${WORKDIR}/darling-compiler-rt-5fd9bc0effa307b99b35da59ce579e8e031c22da" \
		"${S}/src/external/compiler-rt" || die
	mv "${WORKDIR}/darling-configd-b1627eefca647933ad84dc36b5adc73025a7e5c7" \
		"${S}/src/external/configd" || die
	mv "${WORKDIR}/darling-copyfile-ed6094c9a2f8ba19aa55b7b504c3665797078e8f" \
		"${S}/src/external/copyfile" || die
	mv "${WORKDIR}/darling-corecrypto-6868755769326c13c6cdb2b0689deb5731a932e3" \
		"${S}/src/external/corecrypto" || die
	mv "${WORKDIR}/darling-corefoundation-ef09be6e9a691129733464dbc0df4910410d0889" \
		"${S}/src/external/corefoundation" || die
	mv "${WORKDIR}/darling-coretls-b61a4f075726e7d5ef4652033f8d7b829c008d06" \
		"${S}/src/external/coretls" || die
	mv "${WORKDIR}/darling-crontabs-b5bc00d2a75f6c622976e2ebbe244fb2d7d602ea" \
		"${S}/src/external/crontabs" || die
	mv "${WORKDIR}/darling-Csu-93b25cf0930a727b44fa50893bffd71056ad032f" \
		"${S}/src/external/csu" || die
	mv "${WORKDIR}/darling-cups-51b7c251ef5ff81adc20284544394de8cc2e1315" \
		"${S}/src/external/cups" || die
	mv "${WORKDIR}/darling-curl-92f54fd7eceabed2c2382a4acc0f7293dedd92ff" \
		"${S}/src/external/curl" || die
	mv "${WORKDIR}/darling-dbuskit-890e51fda949e4dd2c46765e39074f790c10ca18" \
		"${S}/src/external/dbuskit" || die
	mv "${WORKDIR}/darling-DirectoryService-feb9742f574ab812a210634fd3997f19b645095f" \
		"${S}/src/external/DirectoryService" || die
	mv "${WORKDIR}/darling-dmg-1a6de10c5886c40a414090701b2520bd0417ce29" \
		"${S}/src/external/darling-dmg" || die
	mv "${WORKDIR}/darling-doc_cmds-60c6a2b858abe1f27b441f479aad2b0a9d0f9ba2" \
		"${S}/src/external/doc_cmds" || die
	mv "${WORKDIR}/darling-DSTools-e015256b16965ac032412f2277c608c7213c03b3" \
		"${S}/src/external/DSTools" || die
	mv "${WORKDIR}/darling-dtrace-4f52343b36756e32a81eb302242ac6472e9075fa" \
		"${S}/src/external/dtrace" || die
	mv "${WORKDIR}/darling-dyld-63f667cf06d7ed59553adebb0c8d70a117135ac9" \
		"${S}/src/external/dyld" || die
	mv "${WORKDIR}/darling-energytrace-e277fcfd430ddab2d8b52187cf480f2857629104" \
		"${S}/src/external/energytrace" || die
	mv "${WORKDIR}/darling-expat-70006a0c32d7c8653c11e53fc0c905f1bb498218" \
		"${S}/src/external/expat" || die
	mv "${WORKDIR}/darling-file_cmds-c0d72b5c98888a9d8e0b73cf8aac0df908e615f2" \
		"${S}/src/external/file_cmds" || die
	mv "${WORKDIR}/darling-file-c6ee65265d253d24b1a496f8ca54b5e449fe108c" \
		"${S}/src/external/file" || die
	mv "${WORKDIR}/darling-files-1c45a50ae0d6ca5bbb8b01d2b588f52bc0e39263" \
		"${S}/src/external/files" || die
	mv "${WORKDIR}/darling-foundation-75cbb13e17b2b63087b9a03fc780aa482832be5a" \
		"${S}/src/external/foundation" || die
	mv "${WORKDIR}/darling-glut-b53a2d8f0c6dc0c2052aef410a120d14ee553056" \
		"${S}/src/external/glut" || die
	mv "${WORKDIR}/darling-gnudiff-ae0ab716658296164a032be7406f082cdc31c954" \
		"${S}/src/external/gnudiff" || die
	mv "${WORKDIR}/darling-gnutar-1414bc8a8bd2e9dae701831e749febe2e2e84d68" \
		"${S}/src/external/gnutar" || die
	mv "${WORKDIR}/darling-gpatch-49acc897e8cb832a26b7ac4d2f7db51d3c6ba037" \
		"${S}/src/external/gpatch" || die
	mv "${WORKDIR}/darling-grep-62d70fada3a01de87aff927a86b8df0f7f2a837a" \
		"${S}/src/external/grep" || die
	mv "${WORKDIR}/darling-groff-10dd5a6be4915a99065bc15dfc6b6b1e9e1a2714" \
		"${S}/src/external/groff" || die
	mv "${WORKDIR}/darling-Heimdal-94a5c2feff43fb6661e10721d52a9c350c84bbb0" \
		"${S}/src/external/Heimdal" || die
	mv "${WORKDIR}/darling-icu-6b609b2b0ce9a620543f357de4e549f09afec4ea" \
		"${S}/src/external/icu" || die
	mv "${WORKDIR}/darling-installer-88764e6149f92f1747442c27ab00231f40de278c" \
		"${S}/src/external/installer" || die
	mv "${WORKDIR}/darling-IONetworkingFamily-28afb431947b8e8dbbb120db7632ba6de229bf23" \
		"${S}/src/external/IONetworkingFamily" || die
	mv "${WORKDIR}/darling-iokitd-5549ac4cd2db923c256f016a1381b3bfb716730a" \
		"${S}/src/external/iokitd" || die
	mv "${WORKDIR}/darling-IOKitTools-df58be2f134f7adbdd3c760a165ad3501ee82fb5" \
		"${S}/src/external/IOKitTools" || die
	mv "${WORKDIR}/darling-iokituser-9843fd575a87926ab3cd3ee011215b97e90c1006" \
		"${S}/src/external/IOKitUser" || die
	mv "${WORKDIR}/darling-iostoragefamily-33178aef923d9c99f1819db2ada253054f4dd812" \
		"${S}/src/external/IOStorageFamily" || die
	mv "${WORKDIR}/darling-JavaScriptCore-93410cc0dbc7a961d58d048c151117acdb18a566" \
		"${S}/src/external/JavaScriptCore" || die
	mv "${WORKDIR}/darling-keymgr-43b4230aec2e9018b0ffd3069b8b23a34ba257fb" \
		"${S}/src/external/keymgr" || die
	mv "${WORKDIR}/darling-less-a6bc77c8e72aaa35da92b903172a70eaa4ef78fa" \
		"${S}/src/external/less" || die
	mv "${WORKDIR}/darling-libarchive-998d739c602a1b35e2377ec9161e9c13d1d8604d" \
		"${S}/src/external/libarchive" || die
	mv "${WORKDIR}/darling-libauto-2be7312b25736a8e9fc12058d63cbb79eb5f4e25" \
		"${S}/src/external/libauto" || die
	mv "${WORKDIR}/darling-Libc-5a38c8dabf9e76b39407c24bc13134e33e5594e6" \
		"${S}/src/external/libc" || die
	mv "${WORKDIR}/darling-libclosure-b4122f19c89512d9e930259a85c5f2674eff2b2b" \
		"${S}/src/external/libclosure" || die
	mv "${WORKDIR}/darling-libcxx-c47677d3ba33bdabbfb07e75f531831579355a2d" \
		"${S}/src/external/libcxx" || die
	mv "${WORKDIR}/darling-libcxxabi-c9c851718eb304a9aefa097aeaaf8c3bd1dff1bc" \
		"${S}/src/external/libcxxabi" || die
	mv "${WORKDIR}/darling-libdispatch-380f03c180b80d940134fb35783ddc714784a53a" \
		"${S}/src/external/libdispatch" || die
	mv "${WORKDIR}/darling-libedit-f9b44b8541614e33b09451fc2847f7e30bfb9b70" \
		"${S}/src/external/libedit" || die
	mv "${WORKDIR}/darling-libffi-c796ec121cfd950aa5cc901ea47854a8431948ac" \
		"${S}/src/external/libffi" || die
	mv "${WORKDIR}/darling-libiconv-0d6f47d33a7cc97e468e864099fff74875b41937" \
		"${S}/src/external/libiconv" || die
	mv "${WORKDIR}/darling-Libinfo-30f771b21a0b6bcd937288b5fc25e5d29b75321d" \
		"${S}/src/external/Libinfo" || die
	mv "${WORKDIR}/darling-libkqueue-f673c801cbc4011d3ae35301bb8b5073eb41c103" \
		"${S}/src/external/libkqueue" || die
	mv "${WORKDIR}/darling-liblzma-855ebc93f8208ae4b6e77a018d4ba4a4be4d2ab7" \
		"${S}/src/external/liblzma" || die
	mv "${WORKDIR}/darling-libmalloc-a57991e2651226a675654bd96e5d9ab6bec288c5" \
		"${S}/src/external/libmalloc" || die
	mv "${WORKDIR}/darling-libnetwork-56c5fad43f24a40d8ca7f8a1d0badedfeaf7e64e" \
		"${S}/src/external/libnetwork" || die
	mv "${WORKDIR}/darling-Libnotify-98156d3f847a3ced6c5f52c12a889047bc4f9b20" \
		"${S}/src/external/libnotify" || die
	mv "${WORKDIR}/darling-libplatform-5a3e5b529d25c70257dcfa97e94f1826e71e9f40" \
		"${S}/src/external/libplatform" || die
	mv "${WORKDIR}/darling-libpthread-f07f265bfbcf071c1adfc808de971e053ea5edc5" \
		"${S}/src/external/libpthread" || die
	mv "${WORKDIR}/darling-libresolv-af5c8ad53d5ff8ec65276b8432641067d9c30a24" \
		"${S}/src/external/libresolv" || die
	mv "${WORKDIR}/darling-librpcsvc-0cc1d42e53c61446616719597e96b29aeda51eb3" \
		"${S}/src/external/librpcsvc" || die
	mv "${WORKDIR}/darling-libstdcxx-73eb757fe23170c372bef17d6de41787c1271c80" \
		"${S}/src/external/libstdcxx" || die
	mv "${WORKDIR}/darling-Libsystem-08df454b6eb0df9400aa4c39839a7efd6efd2c3c" \
		"${S}/src/external/libsystem" || die
	mv "${WORKDIR}/darling-libtelnet-1ebd4eef48d06e6411ed2a0f60ba5d3fce5ab455" \
		"${S}/src/external/libtelnet" || die
	mv "${WORKDIR}/darling-libtrace-8cf07f02b15f7dca6436882a03678fff0392eaf6" \
		"${S}/src/external/libtrace" || die
	mv "${WORKDIR}/darling-libunwind-a91da1a0e262e04eb601152a84228ff733e48422" \
		"${S}/src/external/libunwind" || die
	mv "${WORKDIR}/darling-libutil-e3782a467c248c8d181aba1200ee0642abb65baf" \
		"${S}/src/external/libutil" || die
	mv "${WORKDIR}/darling-libxml2-d4f2967c8ca84a23a886978098c0520fe2963b92" \
		"${S}/src/external/libxml2" || die
	mv "${WORKDIR}/darling-libxpc-394e033333d3c253a12f08a99090c113b0917d00" \
		"${S}/src/external/libxpc" || die
	mv "${WORKDIR}/darling-libxslt-50d22bd5b761a1885009b690e48d858ff73e768b" \
		"${S}/src/external/libxslt" || die
	mv "${WORKDIR}/darling-mail_cmds-4afbcf4b9b8a6c33acaf7e9025e51ce72b3725a7" \
		"${S}/src/external/mail_cmds" || die
	mv "${WORKDIR}/darling-man-9af6690f3c7c3c713bb0a20ba1163d3c4278257d" \
		"${S}/src/external/man" || die
	mv "${WORKDIR}/darling-mDNSResponder-7e38ef562b4f3d41bffabb3e30d844d8042d3bbd" \
		"${S}/src/external/mDNSResponder" || die
	mv "${WORKDIR}/darling-metal-f815654533fe0515f709bf4def29ae523b09414c" \
		"${S}/src/external/metal" || die
	mv "${WORKDIR}/darling-misc_cmds-85b24ec0e2625d75e7ee75b597b9134a49d18b1f" \
		"${S}/src/external/misc_cmds" || die
	mv "${WORKDIR}/darling-MITKerberosShim-39c014d0c54f9ae922be0d697aa6cc1b19c117b6" \
		"${S}/src/external/MITKerberosShim" || die
	mv "${WORKDIR}/darling-nano-7514f5f1115fffedd8fc2095107ca86ff82c54d6" \
		"${S}/src/external/nano" || die
	mv "${WORKDIR}/darling-ncurses-4cc72a9a1bce214593c10811b0154a8d51db0239" \
		"${S}/src/external/ncurses" || die
	mv "${WORKDIR}/darling-netcat-fd29177d56d84f88406e33784c327ebabfe7be58" \
		"${S}/src/external/netcat" || die
	mv "${WORKDIR}/darling-network_cmds-9a0a90e2021ecdde91986b91f65a236eda158023" \
		"${S}/src/external/network_cmds" || die
	mv "${WORKDIR}/darling-nghttp2-1a1853837b4350d4393bd25e1e4cb6018ab2d918" \
		"${S}/src/external/nghttp2" || die
	mv "${WORKDIR}/darling-objc4-1a12df76d12bfc9fdfffadb290f7742763568765" \
		"${S}/src/external/objc4" || die
	mv "${WORKDIR}/darling-openal-7c60cf7109b7a3a8f5d41ed8b84d340a8d768525" \
		"${S}/src/external/openal" || die
	mv "${WORKDIR}/darling-opendirectory-750636a898284fb392a10603ac7894658b632678" \
		"${S}/src/external/OpenDirectory" || die
	mv "${WORKDIR}/darling-openjdk-5a541c1844a9508e48b3addaf2d38775683abb38" \
		"${S}/src/external/openjdk" || die
	mv "${WORKDIR}/darling-OpenLDAP-3b15390bbcad8234aabb3246b0552105b17118d0" \
		"${S}/src/external/OpenLDAP" || die
	mv "${WORKDIR}/darling-openpam-8362545bac04032fcf59287cd66e6f4662a3692b" \
		"${S}/src/external/openpam" || die
	mv "${WORKDIR}/darling-openssh-9137305e5793d31124bcf2fdf0c6fa28c2e3e812" \
		"${S}/src/external/openssh" || die
	mv "${WORKDIR}/darling-openssl_certificates-cca4f47e3ca18b58961157ef0ec6a6fc135b8cd2" \
		"${S}/src/external/openssl_certificates" || die
	mv "${WORKDIR}/darling-openssl-dc7bf84efa5a0befa0d970d4d5177853ac448d6f" \
		"${S}/src/external/openssl" || die
	mv "${WORKDIR}/darling-passwordserver_sasl-794093ece0203718ce5da5645a689b5c6e766208" \
		"${S}/src/external/passwordserver_sasl" || die
	mv "${WORKDIR}/darling-patch_cmds-0670c7fbadfd715ac78d5476552788416cad0020" \
		"${S}/src/external/patch_cmds" || die
	mv "${WORKDIR}/darling-pcre-6f67e33869a2b08da9465034c41e64e16fc7faf9" \
		"${S}/src/external/pcre" || die
	mv "${WORKDIR}/darling-perl-a65d68be2146d85928e511aabc8f3a2b05e564ba" \
		"${S}/src/external/perl" || die
	mv "${WORKDIR}/darling-pyobjc-c0912a6c46c25e958eeb70f47f046b5a55ebb387" \
		"${S}/src/external/pyobjc" || die
	mv "${WORKDIR}/darling-python_modules-24d01b41cb38fafc810cdd27562224c4014a4761" \
		"${S}/src/external/python_modules" || die
	mv "${WORKDIR}/darling-python-4856509729cc320006a1235291e47408cd7b13ce" \
		"${S}/src/external/python" || die
	mv "${WORKDIR}/darling-remote_cmds-3bb9f88724726d0d3073c04dfdc4785564113341" \
		"${S}/src/external/remote_cmds" || die
	mv "${WORKDIR}/darling-removefile-24b6d73021fe355811986b21f9adfeb1f23df044" \
		"${S}/src/external/removefile" || die
	mv "${WORKDIR}/darling-rsync-316c5b6b2780a28179f692f3fc0d63ebc2985705" \
		"${S}/src/external/rsync" || die
	mv "${WORKDIR}/darling-ruby-423f2439478d2e24d7c19b2e0ea4a67ee3e80c3d" \
		"${S}/src/external/ruby" || die
	mv "${WORKDIR}/darling-screen-4bed52587563ede850bf9ff834567478ac1e616b" \
		"${S}/src/external/screen" || die
	mv "${WORKDIR}/darling-security-3cfffcf2c5b5900169c964facdf42cc05c23005c" \
		"${S}/src/external/security" || die
	mv "${WORKDIR}/darling-SecurityTokend-c826860db4061667af6f0c3aa55282aab0924e1a" \
		"${S}/src/external/SecurityTokend" || die
	mv "${WORKDIR}/darling-shell_cmds-5191dabbeff0aec230fc1275bae1653281ba52b2" \
		"${S}/src/external/shell_cmds" || die
	mv "${WORKDIR}/darling-SmartCardServices-ec53ce56972565047a716ab166176f203f520393" \
		"${S}/src/external/SmartCardServices" || die
	mv "${WORKDIR}/darling-sqlite-3472e2568cb7fcc25fe91af80da8d2fe884d9ac0" \
		"${S}/src/external/sqlite" || die
	mv "${WORKDIR}/darling-swift-471514f4b4985a604b192e1facac9bbc53dedad3" \
		"${S}/src/external/swift" || die
	mv "${WORKDIR}/darling-syslog-36ab27964cac4affe3907a598047bd21b8958919" \
		"${S}/src/external/syslog" || die
	mv "${WORKDIR}/darling-system_cmds-b01129f3dc0ecab524dbd0fd08e29ec9f0e18196" \
		"${S}/src/external/system_cmds" || die
	mv "${WORKDIR}/darling-tcsh-7737644ec31303be19c533aab093209f3458e060" \
		"${S}/src/external/tcsh" || die
	mv "${WORKDIR}/darling-text_cmds-3edd740c82b8b87c17ec9cfaae7606f6176626df" \
		"${S}/src/external/text_cmds" || die
	mv "${WORKDIR}/darling-TextEdit-99ec72a94dab166eefa264e9802ebd0d80aca845" \
		"${S}/src/external/TextEdit" || die
	mv "${WORKDIR}/darling-top-4e27f81b5cfeef9d31d8fe5d938a80d26cca9ab5" \
		"${S}/src/external/top" || die
	mv "${WORKDIR}/darling-usertemplate-5f8cca97aa03ff9290d6ccc0a4d185aa1a913875" \
		"${S}/src/external/usertemplate" || die
	mv "${WORKDIR}/darling-vim-7f8da1dd66fc8f0654ebfa597b6013c8cf15185a" \
		"${S}/src/external/vim" || die
	mv "${WORKDIR}/darling-WebCore-47fac4c8130ea9afc9b9df68c81ade56ca7ea57e" \
		"${S}/src/external/WebCore" || die
	mv "${WORKDIR}/darling-WTF-88a36e496a6f285a9e15140c2c431b817bae353b" \
		"${S}/src/external/WTF" || die
	mv "${WORKDIR}/darling-xar-887bd4f42eb4ac9139a7f621b5811065aa86f3e3" \
		"${S}/src/external/xar" || die
	mv "${WORKDIR}/darling-xnu-5f26a4c2365d9774b5a1e66ae7da20b61ab6d2db" \
		"${S}/src/external/xnu" || die
	mv "${WORKDIR}/darling-zip-caf41ebbc3ebab0250e4d13aa42221ef91a9802c" \
		"${S}/src/external/zip" || die
	mv "${WORKDIR}/darling-zlib-677de9b1c2bea1e428f56d8fc63300aa471eaf99" \
		"${S}/src/external/zlib" || die
	mv "${WORKDIR}/darling-zsh-4a7a6ebf6216395c7db698a4993db16e484aa54d" \
		"${S}/src/external/zsh" || die
	mv "${WORKDIR}/darlingserver-89751e64bc6c2082f7725061824ee0e33395b0de" \
		"${S}/src/external/darlingserver" || die
	mv "${WORKDIR}/fmdb-ad2fdd660d02c24b262d64d7d23d3d4645768f44" \
		"${S}/src/external/fmdb" || die
	mv "${WORKDIR}/lzfse-451f291743bb919cb1b78ced4110402fca52cf97" \
		"${S}/src/external/lzfse" || die
	mv "${WORKDIR}/xcbuild-a903c6952fc5617816113cbb7b551ac701dba2ff" \
		"${S}/src/external/xcbuild" || die

	# Handle nested submodules for IOKitUser (IOGraphics and IOHIDFamily)
	rm -rf "${S}/src/external/IOKitUser/darling/submodules/IOGraphics"
	mv "${WORKDIR}/darling-IOGraphics-905186151d713259296f3ae9458195a7097ea323" \
		"${S}/src/external/IOKitUser/darling/submodules/IOGraphics" || die
	rm -rf "${S}/src/external/IOKitUser/darling/submodules/IOHIDFamily"
	mv "${WORKDIR}/darling-IOHIDFamily-189e98e32092d5f5a2c365cc85fd36ac7da2d371" \
		"${S}/src/external/IOKitUser/darling/submodules/IOHIDFamily" || die

	rm -rf "${S}/src/external/openpam/darling/submodules/pam_modules"
	mv "${WORKDIR}/darling-pam_modules-241bbee0da845d1dfebc747b16a62aaed22f165b" \
		"${S}/src/external/openpam/darling/submodules/pam_modules" || die

	rm -rf "${S}/src/external/metal/deps/indium"
	mv "${WORKDIR}/indium-8423a7d2f053167030d2bc4a227f96243c740667" \
		"${S}/src/external/metal/deps/indium" || die

	rm -rf "${S}/src/external/corefoundation/submodules/swift-corelibs-foundation"
	mv "${WORKDIR}/darling-swift-corelibs-foundation-ea1ea0bb416025a8cc5a282df03c2e8f12788e2d" \
		"${S}/src/external/corefoundation/submodules/swift-corelibs-foundation" || die

	cd "${S}"

	# We need clang as we're building a Darwin system
	export CC=clang
	export CXX=clang++

	unset LDFLAGS
	export LDFLAGS=""

	filter-flags '-march=*'
	filter-flags '-O*'

	cmake_src_prepare

}

src_configure() {
	export CC=clang
	export CXX=clang++

	unset LDFLAGS
	export LDFLAGS=""

	# O2 and march coming when these PRs are resolved (hopefully)
	# https://github.com/darlinghq/darling-libresolv/pull/4
	# https://github.com/darlinghq/darling-removefile/pull/3
	filter-flags '-march=*,-O*'

	local mycmakeargs=(
		"-DCMAKE_INSTALL_PREFIX=/usr"
		"-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
		"-DDEBIAN_PACKAGING=ON"
		"-DJSC_UNIFIED_BUILD=ON"
		"-DENABLE_METAL=ON"
		"-DTARGET_i386=OFF" # haven't tested multilib support yet, will be added in a future USE flag
	)

	cmake_src_configure
}

src_compile() {
	cmake_src_compile
}

src_install() {
	cmake_src_install

	# Darlingserver requires these empty dirs to exist at runtime
	# to set up its container (procfs mount, tmp, var, etc.)
	keepdir /usr/libexec/darling/private/tmp
	keepdir /usr/libexec/darling/private/var
	keepdir /usr/libexec/darling/private/etc
	keepdir /usr/libexec/darling/dev
	keepdir /usr/libexec/darling/proc
	keepdir /usr/libexec/darling/run
}
