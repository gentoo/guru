#! /usr/bin/env bash
# Maintainer: Andrew Ammerlaan <andrewammerlaan@gentoo.org>
# Maintainer: James Beddek <telans@posteo.de>
#
# This checks for potential and exact package matches within an overlay & ::gentoo
# Note that this is not going to be 100% accurate

EXCLUDE='^(.git|.github|metadata|profiles|scripts)/|^eclass/tests$|metadata.xml'

GENTOO_DIR="/var/db/repos/gentoo"
GENTOO_PACKAGES=(
	$(find ${GENTOO_DIR} -mindepth 2 -maxdepth 2 -printf "%P\n" \
		| sort | grep -Ev "${EXCLUDE}"
	)
)
REPO_PACKAGES=(
	$(find . -mindepth 2 -maxdepth 2 -printf "%P\n" \
		| sort | grep -Ev "${EXCLUDE}"
	)
)

REPO_NAME="$(cat profiles/repo_name)"

printf "\nChecking for duplicates...\n"

for GENTOO_PKG in ${GENTOO_PACKAGES[@]}; do
	GENTOO_CATEGORIES+=( ${GENTOO_PKG%%/*} )	# Separate category
	GENTOO_PKG_NAME=${GENTOO_PKG##*/}			# Separate name
	GENTOO_PKG_NAME=${GENTOO_PKG_NAME,,}		# Force lower case, e.g. to match foobar and FooBar
	GENTOO_PKG_NAME=${GENTOO_PKG_NAME/[-_]}		# Remove underscores and dashes, e.g. to match foo-bar and foo_bar
	GENTOO_PKG_NAMES+=( ${GENTOO_PKG_NAME} )
done

printf "Testing ${#REPO_PACKAGES[@]} ${REPO_NAME^} packages against ${#GENTOO_PKG_NAMES[@]} Gentoo packages\n"

for REPO_PKG in ${REPO_PACKAGES[@]}; do
	REPO_PKG_CATEGORY=${REPO_PKG%%/*}
	REPO_PKG_NAME=${REPO_PKG##*/}
	REPO_PKG_NAME=${REPO_PKG_NAME,,}
	REPO_PKG_NAME=${REPO_PKG_NAME/[-_]}

	if [[ ${GENTOO_PKG_NAMES[@]} =~ " ${REPO_PKG_NAME} " ]]; then	# Check for a matcing name in the Gentoo tree,
		for (( i=0; i<${#GENTOO_PKG_NAMES[@]}; i++ )); do			# otherwise there is no need to continue
			[[ ${GENTOO_PKG_NAMES[$i]} == ${REPO_PKG_NAME} ]] && index+=( $i ) # Find the category/index for multiple matching names
		done

		for i in ${index[@]}; do	# For each possible match
			if [[ ${GENTOO_PACKAGES[$i]} == ${REPO_PKG} ]]; then
				PKG_EXACT_MATCH+="\t${REPO_PKG}::${REPO_NAME} exact match of ${GENTOO_PACKAGES[$i]}::gentoo\n"
				break	# An exact match is fatal, no need to continue
			elif [[ ${GENTOO_CATEGORIES[$i]} == ${REPO_PKG_CATEGORY} ]]; then # Possible match within the same category
				PKG_CATEGORY_MATCH+="\t${REPO_PKG}::${REPO_NAME} possible duplicate of ${GENTOO_PACKAGES[$i]}::gentoo\n"
			else # Possible match in a different category
				PKG_SPECULATIVE_MATCH+="\t${REPO_PKG}::${REPO_NAME} possible duplicate of ${GENTOO_PACKAGES[$i]}::gentoo\n"
			fi
		done
		unset index
	fi
done

if [[ -n ${PKG_SPECULATIVE_MATCH} ]]; then
	printf "\nWARNING: The following packages closely match packages in the main Gentoo repository:\n"
	printf "${PKG_SPECULATIVE_MATCH}"
	printf "Please check these manually.\n"
fi

if [[ -n ${PKG_CATEGORY_MATCH} ]]; then
	printf "\nWARNING: The following packages closely match packages in the main Gentoo repository, in the same category:\n"
	printf "${PKG_CATEGORY_MATCH}"
	printf "Please check these manually.\n"
fi

if [[ -n ${PKG_EXACT_MATCH} ]]; then
	printf "\nERROR: The following packages override packages in the main Gentoo repository:\n"
	printf "${PKG_EXACT_MATCH}"
	printf "Please remove these packages.\n"
	exit 1
fi
