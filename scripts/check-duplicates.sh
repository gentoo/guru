#!/usr/bin/env bash
# Maintainer: Andrew Ammerlaan <andrewammerlaan@riseup.net>
#
# This checks if packages in ::guru are also in ::gentoo
#
# Note that this is not going to be 100% accurate
#
#

printf "\nChecking for duplicates....\n"

gentoo_location="/var/db/repos/gentoo"
guru_location="."

gentoo_packs=$(find ${gentoo_location} -mindepth 2 -maxdepth 2 -printf "%P\n" | sort | grep -Ev "^(.git|.github|metadata|profiles|scripts)/")
guru_packs=$(find ${guru_location} -mindepth 2 -maxdepth 2 -printf "%P\n" | sort | grep -Ev "^(.git|.github|metadata|profiles|scripts)/")

pack_overrides="" pack_close_match_in_cat="" pack_close_match=""
for guru_pack in ${guru_packs}; do
	# separate category and packages
	guru_pack_cat="${guru_pack%%/*}"
	guru_pack_name="${guru_pack##*/}"

	# convert all to lowercase
	guru_pack_name="${guru_pack_name,,}"

	# stip all numbers, dashes, underscores and pluses
	guru_pack_name="${guru_pack_name/[0-9-_+]}"

	for gentoo_pack in ${gentoo_packs}; do
		# separate category and packages
		gentoo_pack_cat="${gentoo_pack%%/*}"
		gentoo_pack_name="${gentoo_pack##*/}"

		# convert all to lowercase
		gentoo_pack_name="${gentoo_pack_name,,}"

		# stip all numbers, dashes, underscores and pluses
		gentoo_pack_name="${gentoo_pack_name/[0-9-_+]}"

		#TODO: check DESCRIPTION, HOMEPAGE and SRC_URI for close matches

		if [[ "${gentoo_pack_name}" == "${guru_pack_name}" ]]; then
			if [[ "${gentoo_pack_cat}" == "${guru_pack_cat}" ]]; then
				if [[ "${gentoo_pack}" == "${guru_pack}" ]]; then
					pack_overrides+="\t${guru_pack}::guru exact match of ${gentoo_pack}::gentoo\n"
				else
					pack_close_match_in_cat+="\t${guru_pack}::guru possible duplicate of ${gentoo_pack}::gentoo\n"
				fi
			else
				pack_close_match+="\t${guru_pack}::guru possible duplicate of ${gentoo_pack}::gentoo\n"
			fi
		fi
	done
done

if [ -n "${pack_close_match}" ]; then
	printf "\nWARNING: The following packages closely match packages in the main Gentoo repository\n"
	printf "${pack_close_match}"
	printf "Please check these manually\n"
fi

if [ -n "${pack_close_match_in_cat}" ]; then
	printf "\nWARNING: The following packages closely match packages in the main Gentoo repository in the same category\n"
	printf "${pack_close_match_in_cat}"
	printf "Please check these manually\n"
fi

if [ -n "${pack_overrides}" ]; then
	printf "\nERROR: The following packages override packages in the main Gentoo repository\n"
	printf "${pack_overrides}"
	printf "Please remove these packages\n"
	exit 1
fi
exit 0
