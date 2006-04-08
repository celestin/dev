
//#define CPP_LITE
//#define JAVA_LITE
//#define CPP_PRO
//#define JAVA_PRO
//#define CPP_PM
//#define JAVA_PM
#define CS_PM

//#define NT_SERVICE

#define LICENSE_VERSION "1.0"
#define EVAL_LICENSE "krakatau"
#define EVAL_OPTION "-eval"

#ifdef CPP_LITE
#ifdef BATCH_CONSOLE
	#define APPLICATION "com.powersoftware.apps.krakatau.KrakaBatch"
#else
	#define APPLICATION "com.powersoftware.apps.krakatau.KrakatauApplication"
#endif
	#define LICENSE_TYPE "cpplite"
	#define LANG "-cpp"
	#define FLAVOUR "-lite"
#endif
#ifdef JAVA_LITE
#ifdef BATCH_CONSOLE
	#define APPLICATION "com.powersoftware.apps.krakatau.KrakaBatch"
#else
	#define APPLICATION "com.powersoftware.apps.krakatau.KrakatauApplication"
#endif
	#define LICENSE_TYPE "javalite"
	#define LANG "-java"
	#define FLAVOUR "-lite"
#endif
#ifdef CPP_PRO
#ifdef BATCH_CONSOLE
	#define APPLICATION "com.powersoftware.apps.krakatau.KrakaBatch"
#else
	#define APPLICATION "com.powersoftware.apps.krakatau.KrakatauApplication"
#endif
	#define LICENSE_TYPE "cpppro"
	#define LANG "-cpp"	
	#define FLAVOUR "-pro"
#endif
#ifdef JAVA_PRO
#ifdef BATCH_CONSOLE
	#define APPLICATION "com.powersoftware.apps.krakatau.KrakaBatch"
#else
	#define APPLICATION "com.powersoftware.apps.krakatau.KrakatauApplication"
#endif
	#define LICENSE_TYPE "javapro"
	#define LANG "-java"	
	#define FLAVOUR "-pro"
#endif
#ifdef CPP_PM
#ifdef BATCH_CONSOLE
	#define APPLICATION "com.powersoftware.apps.pm.PMBatch"
#else
	#define APPLICATION "com.powersoftware.apps.pm.PMApplication"
#endif
	#define LICENSE_TYPE "cpppm"
	#define LANG "-cpp"	
	#define FLAVOUR "-pu"
#endif
#ifdef JAVA_PM
#ifdef BATCH_CONSOLE
	#define APPLICATION "com.powersoftware.apps.pm.PMBatch"
#else
	#define APPLICATION "com.powersoftware.apps.pm.PMApplication"
#endif
	#define LICENSE_TYPE "javapm"
	#define LANG "-java"	
	#define FLAVOUR "-pu"
#endif
#ifdef CS_PM
	#define LICENSE_TYPE "cspm"
#endif

#define TIME_TO_WAIT 25000
#define OPTIONS "-Xms16m -Xmx256m"
//#define CLASSPATH "etc;lib\\com.jar;lib\\jhall.jar;lib\\kHelp.jar;lib\\mm.mysql-2.0.2-bin.jar"
#define CLASSPATH "etc;lib\\com.jar;lib\\jhall.jar;lib\\kHelp.jar;lib\\mm.mysql.jar"

