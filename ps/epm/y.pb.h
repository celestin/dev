/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2009 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * PowerBuilder parser lexemes
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  10-Dec-2009  10508 : File created.
 * CAM  12-Dec-2009  10508 : Added correct symbols and keywords.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#define KEY_UNDERDEBUG             256
#define KEY_ALIAS                  257
#define KEY_AND                    258
#define KEY_AUTOINSTANTIATE        259
#define KEY_BLOB                   260
#define KEY_BOOLEAN                261
#define KEY_CALL                   262
#define KEY_CASE                   263
#define KEY_CHAR                   264
#define KEY_CHARACTER              265
#define KEY_CHOOSE                 266
#define KEY_CLOSE                  267
#define KEY_COMMIT                 268
#define KEY_CONNECT                269
#define KEY_CONSTANT               270
#define KEY_CONTINUE               271
#define KEY_CREATE                 272
#define KEY_CURSOR                 273
#define KEY_DATE                   274
#define KEY_DATETIME               275
#define KEY_DEC                    276
#define KEY_DECIMAL                277
#define KEY_DECLARE                278
#define KEY_DELETE                 279
#define KEY_DESCRIBE               280
#define KEY_DESCRIPTOR             281
#define KEY_DESTROY                282
#define KEY_DISCONNECT             283
#define KEY_DO                     284
#define KEY_DOUBLE                 285
#define KEY_DYNAMIC                286
#define KEY_ELSE                   287
#define KEY_ELSEIF                 288
#define KEY_END                    289
#define KEY_ENUMERATED             290
#define KEY_EVENT                  291
#define KEY_EXECUTE                292
#define KEY_EXIT                   293
#define KEY_EXTERNAL               294
#define KEY_FETCH                  295
#define KEY_FIRST                  296
#define KEY_FOR                    297
#define KEY_FORWARD                298
#define KEY_FROM                   299
#define KEY_FUNCTION               300
#define KEY_GLOBAL                 301
#define KEY_GOTO                   302
#define KEY_HALT                   303
#define KEY_IF                     304
#define KEY_IMMEDIATE              305
#define KEY_INDIRECT               306
#define KEY_INSERT                 307
#define KEY_INT                    308
#define KEY_INTEGER                309
#define KEY_INTO                   310
#define KEY_INTRINSIC              311
#define KEY_IS                     312
#define KEY_LAST                   313
#define KEY_LIBRARY                314
#define KEY_LONG                   315
#define KEY_LOOP                   316
#define KEY_NEXT                   317
#define KEY_NOT                    318
#define KEY_OF                     319
#define KEY_ON                     320
#define KEY_OPEN                   321
#define KEY_OR                     322
#define KEY_PARENT                 323
#define KEY_POST                   324
#define KEY_PREPARE                325
#define KEY_PRIOR                  326
#define KEY_PRIVATE                327
#define KEY_PRIVATEREAD            328
#define KEY_PRIVATEWRITE           329
#define KEY_PROCEDURE              330
#define KEY_PROTECTED              331
#define KEY_PROTECTEDREAD          332
#define KEY_PROTECTEDWRITE         333
#define KEY_PROTOTYPES             334
#define KEY_PUBLIC                 335
#define KEY_READONLY               336
#define KEY_REAL                   337
#define KEY_REF                    338
#define KEY_RETURN                 339
#define KEY_ROLLBACK               340
#define KEY_RPCFUNC                341
#define KEY_SELECT                 342
#define KEY_SELECTBLOB             343
#define KEY_SHARED                 344
#define KEY_STATIC                 345
#define KEY_STEP                   346
#define KEY_STRING                 347
#define KEY_SUBROUTINE             348
#define KEY_SUPER                  349
#define KEY_SYSTEM                 350
#define KEY_SYSTEMREAD             351
#define KEY_SYSTEMWRITE            352
#define KEY_THEN                   353
#define KEY_THIS                   354
#define KEY_TIME                   355
#define KEY_TO                     356
#define KEY_TRIGGER                357
#define KEY_TYPE                   358
#define KEY_UINT                   359
#define KEY_ULONG                  360
#define KEY_UNSIGNEDINT            361
#define KEY_UNSIGNEDINTEGER        362
#define KEY_UNSIGNEDLONG           363
#define KEY_UNTIL                  364
#define KEY_UPDATE                 365
#define KEY_UPDATEBLOB             366
#define KEY_USING                  367
#define KEY_VARIABLES              368
#define KEY_WHILE                  369
#define KEY_WITH                   370
#define KEY_WITHIN                 371
#define KEY_FALSE                  372
#define KEY_TRUE                   373
#define SYM_MINUS                  374
#define SYM_PCT                    375
#define SYM_AND                    376
#define SYM_CARAT                  377
#define SYM_TILDE                  378
#define SYM_PLUS                   379
#define SYM_EQ                     380
#define SYM_NOT                    381
#define SYM_AST                    382
#define SYM_DIV                    384
#define SYM_OR                     385
#define SYM_LT                     386
#define SYM_GT                     387
#define SYM_NOT                    388
