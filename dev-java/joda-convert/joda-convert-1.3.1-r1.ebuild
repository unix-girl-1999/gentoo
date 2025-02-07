# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Java library for conversion between Object and String"
HOMEPAGE="https://www.joda.org/joda-convert/"
SRC_URI="mirror://sourceforge/${PN}/${P}-dist.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 ppc64 x86"

DEPEND="virtual/jdk:1.8
	test? (
		dev-java/junit:4
		dev-java/ant-junit:0
	)"
RDEPEND=">=virtual/jre-1.8"

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_TEST_GENTOO_CLASSPATH="junit-4"
EANT_EXTRA_ARGS="-Dmaven.build.finalName=${PN}"

src_prepare() {
	default
	cp "${FILESDIR}"/${P}-build.xml build.xml || die
}

src_test() {
	java-pkg-2_src_test
}

src_install() {
	java-pkg_dojar target/${PN}.jar
	dodoc NOTICE.txt RELEASE-NOTES.txt

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
