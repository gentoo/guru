# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit cmake python-single-r1

DESCRIPTION="AWS SDK for C++"
HOMEPAGE="https://aws.amazon.com/sdk-for-cpp/"
SRC_URI="https://github.com/aws/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# BUILD_ONLY lists
AWS_GROUP_storage="backup;backup-gateway;datasync;ebs;fsx;glacier;mediapackage;mediapackage-vod;mediapackagev2;mediastore;mediastore-data;s3;s3-crt;snow-device-management;snowball;storagegateway;workdocs;awstransfer;importexport;rbin;s3tables;backupsearch;s3control"
AWS_GROUP_compute="application-autoscaling;autoscaling;autoscaling-plans;batch;compute-optimizer;ec2;ec2-instance-connect;ecr;ecr-public;ecs;eks;elasticbeanstalk;elasticmapreduce;emr-containers;emr-serverless;lambda;lightsail;outposts;simspaceweaver;elasticfilesystem;elasticloadbalancing;elasticloadbalancingv2;m2;s3outposts;imagebuilder;swf;apigateway;apigatewaymanagementapi;apigatewayv2;apprunner;appstream;appsync;eks-auth;states;workspaces-instances"
AWS_GROUP_networking="appmesh;cloudfront;cloudfront-keyvaluestore;directconnect;globalaccelerator;location;network-firewall;networkflowmonitor;networkmanager;networkmonitor;route53;route53-recovery-cluster;route53-recovery-control-config;route53-recovery-readiness;route53domains;route53profiles;route53resolver;vpc-lattice;geo-maps;geo-places;geo-routes;tnb;arc-zonal-shift;servicediscovery"
AWS_GROUP_database="docdb;docdb-elastic;dynamodb;dynamodbstreams;keyspaces;memorydb;neptune;neptune-graph;neptunedata;opensearch;opensearchserverless;qldb;qldb-session;rds;rds-data;redshift;redshift-data;redshift-serverless;sdb;timestream-influxdb;timestream-query;timestream-write;osis;clouddirectory;dax;elasticache;es;odb"
AWS_GROUP_analytics="athena;cleanrooms;cleanroomsml;datazone;entityresolution;finspace;finspace-data;firehose;forecast;forecastquery;glue;lakeformation;lookoutequipment;lookoutmetrics;lookoutvision;machinelearning;quicksight;repostspace;timestream-influxdb;amp;amplify;amplifybackend;amplifyuibuilder;omics;kafka;kafkaconnect;dsql;appflow;appintegrations;cloudsearch;cloudsearchdomain;databrew;dataexchange;datapipeline;kinesisanalytics;kinesisanalyticsv2;mwaa;pi"
AWS_GROUP_messaging="chatbot;chime;chime-sdk-identity;chime-sdk-media-pipelines;chime-sdk-meetings;chime-sdk-messaging;chime-sdk-voice;connect;connect-contact-lens;connectcampaigns;connectcampaignsv2;connectcases;connectparticipant;customer-profiles;eventbridge;notifications;notificationscontacts;pinpoint;pinpoint-email;pinpoint-sms-voice-v2;pipes;rum;scheduler;sns;sqs;mailmanager;sms;sms-voice;socialmessaging;wisdom;workmail;workmailmessageflow;mq;sesv2;email"
AWS_GROUP_monitor="config;devops-guru;health;inspector;inspector-scan;inspector2;internetmonitor;logs;monitoring;observabilityadmin;resiliencehub;security-ir;synthetics;trustedadvisor;wellarchitected;xray;fis;grafana;healthlake;oam;aiops;appfabric;evidently"
AWS_GROUP_security="accessanalyzer;acm;acm-pca;codeguru-security;guardduty;iam;kms;macie2;payment-cryptography;payment-cryptography-data;rolesanywhere;secretsmanager;securityhub;securitylake;shield;signer;verifiedpermissions;waf;waf-regional;wafv2;auditmanager;cloudhsm;cloudhsmv2;detective;directory-service-data;pca-connector-ad;pca-connector-scep;pcs;sso;sso-admin"
AWS_GROUP_ml="bedrock;bedrock-agent;bedrock-agent-runtime;bedrock-data-automation;bedrock-data-automation-runtime;bedrock-runtime;comprehend;comprehendmedical;frauddetector;personalize;personalize-events;personalize-runtime;rekognition;sagemaker;sagemaker-a2i-runtime;sagemaker-edge;sagemaker-featurestore-runtime;sagemaker-geospatial;sagemaker-metrics;sagemaker-runtime;textract;transcribe;transcribestreaming;translate;lex;lex-models;lexv2-models;lexv2-runtime;qapps;qbusiness;medical-imaging;kendra;kendra-ranking;polly;qconnect"
AWS_GROUP_iot="greengrass;greengrassv2;groundstation;iot;iot-data;iot-jobs-data;iot-managed-integrations;iot1click-devices;iot1click-projects;iotanalytics;iotdeviceadvisor;iotevents;iotevents-data;iotfleetwise;iotfleethub;iotsitewise;iotthingsgraph;iottwinmaker;iotwireless;iotsecuretunneling;panorama;robomaker"
AWS_GROUP_media="elastictranscoder;ivs;ivs-realtime;kinesis;kinesis-video-archived-media;kinesis-video-media;kinesis-video-signaling;kinesis-video-webrtc-storage;mediaconvert;mediatailor;voice-id;deadline;evs;ivschat;kinesisvideo;mediaconnect;medialive"
AWS_GROUP_devops="codeartifact;codebuild;codecatalyst;codecommit;codeconnections;codedeploy;codeguru-reviewer;codeguru-security;codepipeline;codestar-connections;codestar-notifications;devicefarm;gamelift;gameliftstreams;proton;artifact;b2bi;serverlessrepo;schemas;mturk-requester;apptest;cloud9;codeguruprofiler;keyspacesstreams"
AWS_GROUP_mgmt="account;appconfig;appconfigdata;applicationcostprofiler;application-insights;application-signals;budgets;billing;billingconductor;ce;cloudcontrol;cloudformation;cloudtrail;cloudtrail-data;controltower;cur;fms;license-manager;license-manager-linux-subscriptions;license-manager-user-subscriptions;marketplace-agreement;marketplace-catalog;marketplace-deployment;marketplace-entitlement;marketplace-reporting;marketplacecommerceanalytics;organizations;ram;resource-explorer-2;resource-groups;resourcegroupstaggingapi;savingsplans;service-quotas;servicecatalog;servicecatalog-appregistry;support;support-app;taxsettings;AWSMigrationHub;cost-optimization-hub;dlm;dms;drs;mgn;migration-hub-refactor-spaces;migrationhub-config;migrationhuborchestrator;migrationhubstrategy;launch-wizard;meteringmarketplace;supplychain;workspaces;workspaces-thin-client;workspaces-web;worklink;bcm-data-exports;bcm-pricing-calculator;controlcatalog;discovery;invoicing;opsworks;opsworkscm;partnercentral-selling;ssm;ssm-contacts;ssm-guiconnect;ssm-incidents;ssm-quicksetup;ssm-sap;mpa"
AWS_GROUP_other="ds;evs;braket;freetier;managedblockchain;managedblockchain-query"

AWS_GROUP_LIST=( storage compute networking database analytics messaging monitor security ml iot media devops mgmt other )

IUSE="+http speech +ssl test full ${AWS_GROUP_LIST[*]}"
REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	full? ( $(printf ' !%s' "${AWS_GROUP_LIST[@]}") )
"
RESTRICT="!test? ( test )"

DEPEND="
	http? ( net-misc/curl:= )
	speech? ( media-libs/libpulse )
	ssl? (
		dev-libs/openssl:=
	)
	dev-libs/aws-crt-cpp:=
	sys-libs/zlib
"
RDEPEND="
	${DEPEND}
	${PYTHON_DEPS}
"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${PN}-1.11.586-uint64_t-does-not-name-a-type.diff
)

_aws_expand_group() {
	local _var="AWS_GROUP_${1}"
	printf "%s" "${!_var}"
}
src_configure() {
	local mybuildtargets="core;identity-management;sts;cognito-identity;cognito-idp;cognito-sync;identitystore;sso-oidc;events;pricing"

	local g
	for g in "${AWS_GROUP_LIST[@]}" ; do
		if use "${g}" || use full ; then
			mybuildtargets+=";$( _aws_expand_group "${g}" )"
		fi
	done

	local mycmakeargs=(
		-DAUTORUN_UNIT_TESTS=$(usex test)
		-DAWS_SDK_WARNINGS_ARE_ERRORS=OFF
		-DBUILD_DEPS=NO
		-DBUILD_ONLY="${mybuildtargets}"
		-DCPP_STANDARD=17
		-DENABLE_TESTING=$(usex test)
		-DNO_ENCRYPTION=$(usex !ssl)
		-DNO_HTTP_CLIENT=$(usex !http)
	)

	if use test; then
		# (#759802) Due to network sandboxing of portage, internet connectivity
		# tests will always fail. If you need a USE flag, because you want/need
		# to perform these tests manually, please open a bug report for it.
		mycmakeargs+=(
			-DENABLE_HTTP_CLIENT_TESTING=OFF
		)
	fi

	cmake_src_configure
}
