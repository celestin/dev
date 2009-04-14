/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2009 SourceCodeMetrics.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * JavaScript parser lexemes
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  14-Apr-2009  10400 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#define KEY_ABSTRACT            256
#define KEY_BOOLEAN             257
#define KEY_BREAK               258
#define KEY_BYTE                259
#define KEY_CASE                260
#define KEY_CATCH               261
#define KEY_CHAR                262
#define KEY_CLASS               263
#define KEY_CONST               264
#define KEY_CONTINUE            265
#define KEY_DEFAULT             266
#define KEY_DELETE              267
#define KEY_DO                  268
#define KEY_DOUBLE              269
#define KEY_ELSE                270
#define KEY_EXTENDS             271
#define KEY_FINAL               272
#define KEY_FINALLY             273
#define KEY_FLOAT               274
#define KEY_FOR                 275
#define KEY_FUNCTION            276
#define KEY_GOTO                277
#define KEY_IF                  278
#define KEY_IMPLEMENTS          279
#define KEY_IMPORT              280
#define KEY_IN                  281
#define KEY_INSTANCEOF          282
#define KEY_INT                 283
#define KEY_INTERFACE           284
#define KEY_LONG                285
#define KEY_NATIVE              286
#define KEY_NEW                 287
#define KEY_PACKAGE             288
#define KEY_PRIVATE             289
#define KEY_PROTECTED           290
#define KEY_PUBLIC              291
#define KEY_RETURN              292
#define KEY_SHORT               293
#define KEY_STATIC              294
#define KEY_SUPER               295
#define KEY_SWITCH              296
#define KEY_SYNCHRONIZED        297
#define KEY_THIS                298
#define KEY_THROW               299
#define KEY_THROWS              300
#define KEY_TRANSIENT           301
#define KEY_TRY                 302
#define KEY_TYPEOF              303
#define KEY_VAR                 304
#define KEY_VOID                305
#define KEY_VOLATILE            306
#define KEY_WHILE               307
#define KEY_WITH                308
#define SYM_ASSIGN              309
#define SYM_GT                  310
#define SYM_LT                  311
#define SYM_NOT                 312
#define SYM_TILDE               313
#define SYM_QUESTION            314
#define SYM_COLON               315
#define SYM_PLUS                316
#define SYM_MINUS               317
#define SYM_ASTERISK            318
#define SYM_SLASH               319
#define SYM_BITAND              320
#define SYM_BITOR               321
#define SYM_EXPONENT            322
#define SYM_PERCENT             323
#define SYM_PARENO              324
#define SYM_PARENC              325
#define SYM_BRACEO              326
#define SYM_BRACEC              327
#define SYM_BRACKETO            328
#define SYM_BRACKETC            329
#define SYM_SEMICOLON           330
#define SYM_COMMA               331
#define SYM_PERIOD              332
#define SYM_EQUALS              333
#define SYM_LTEQUAL             334
#define SYM_GTEQUAL             335
#define SYM_NOTEQUAL            336
#define SYM_LOGAND              337
#define SYM_LOGOR               338
#define SYM_INCREMENT           339
#define SYM_DECREMENT           340
#define SYM_SHIFTLT             341
#define SYM_SHIFTRT             342
#define SYM_SHIFTRTUNS          343
#define SYM_ASSIGNPLUS          344
#define SYM_ASSIGNMINUS         345
#define SYM_ASSIGNMULTIPLY      346
#define SYM_ASSIGNDIVIDE        347
#define SYM_ASSIGNBITAND        348
#define SYM_ASSIGNBITOR         349
#define SYM_ASSIGNEXPONENT      350
#define SYM_ASSIGNMOD           351
#define SYM_ASSIGNSHIFTLT       352
#define SYM_ASSIGNSHIFTRT       353
#define SYM_ASSIGNSHIFTRTUNS    354
