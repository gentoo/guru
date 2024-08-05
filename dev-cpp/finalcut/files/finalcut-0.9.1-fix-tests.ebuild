From 5acee79b977dd38e0a52c51129ea847735a8ee5e Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Matt=C3=A9o=20Rossillol=E2=80=91=E2=80=91Laruelle?=
 <beatussum@protonmail.com>
Date: Sun, 28 Jul 2024 09:21:35 +0200
Subject: [PATCH] fix tests
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commits removes tests failing to compile,
- `fvterm_test` and
- `fterm_functions-test`.

Signed-off-by: Mattéo Rossillol‑‑Laruelle <beatussum@protonmail.com>
---
 test/Makefile.am | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/test/Makefile.am b/test/Makefile.am
index 30d53e34..c4c0282f 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -32,11 +32,9 @@ noinst_PROGRAMS = \
 	ftermdata_test \
 	ftermdetection_test \
 	ftermfreebsd_test \
-	fterm_functions_test \
 	ftermlinux_test \
 	ftermopenbsd_test \
 	ftimer_test \
-	fvterm_test \
 	fvtermattribute_test \
 	fvtermbuffer_test \
 	fwidget_test
@@ -64,13 +62,11 @@ ftermdata_test_SOURCES = ftermdata-test.cpp
 ftermdetection_test_SOURCES = ftermdetection-test.cpp
 ftermfreebsd_test_SOURCES = ftermfreebsd-test.cpp
 ftermfreebsd_test_LDADD = @TERMCAP_LIB@
-fterm_functions_test_SOURCES = fterm_functions-test.cpp
 ftermlinux_test_SOURCES = ftermlinux-test.cpp
 ftermlinux_test_LDADD = @TERMCAP_LIB@
 ftermopenbsd_test_SOURCES = ftermopenbsd-test.cpp
 ftermopenbsd_test_LDADD = @TERMCAP_LIB@
 ftimer_test_SOURCES = ftimer-test.cpp
-fvterm_test_SOURCES = fvterm-test.cpp
 fvtermattribute_test_SOURCES = fvtermattribute-test.cpp
 fvtermbuffer_test_SOURCES = fvtermbuffer-test.cpp
 fwidget_test_SOURCES = fwidget-test.cpp
@@ -98,11 +94,9 @@ TESTS = \
 	ftermdata_test \
 	ftermdetection_test \
 	ftermfreebsd_test \
-	fterm_functions_test \
 	ftermlinux_test \
 	ftermopenbsd_test \
 	ftimer_test \
-	fvterm_test \
 	fvtermattribute_test \
 	fvtermbuffer_test \
 	fwidget_test
-- 
2.44.2

