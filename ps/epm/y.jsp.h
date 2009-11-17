/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Essential Project Manager (EPM)
 * Copyright (c) 2004,2008 PowerSoftware.com
 * Author Craig McKay <craig@frontburner.co.uk>
 *
 * JSP Parser lexemes
 *
 * $Id$
 *
 * Who  When       Why
 * CAM  04-Dec-07   324 : File created.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#define HTM_ALIGN              256
#define HTM_ALT                257
#define HTM_APPLET             258
#define HTM_AREA               259
#define HTM_A                  260
#define HTM_BACKGROUND         261
#define HTM_BGCOLOR            262
#define HTM_BLOCKQUOTE         263
#define HTM_BODY               264
#define HTM_BORDERCOLOR        265
#define HTM_BORDER             266
#define HTM_BR                 267
#define HTM_BUTTON             268
#define HTM_B                  269
#define HTM_CENTER             270
#define HTM_CHECKED            271
#define HTM_CLASS              272
#define HTM_CODE               273
#define HTM_COLOR              274
#define HTM_COLS               275
#define HTM_COLSPAN            276
#define HTM_DIV                277
#define HTM_EMBED              278
#define HTM_FACE               279
#define HTM_FONT               280
#define HTM_FORM               281
#define HTM_FRAMEBORDER        282
#define HTM_FRAMESET           283
#define HTM_FRAMESPACING       284
#define HTM_FRAME              285
#define HTM_H1                 286
#define HTM_H2                 287
#define HTM_H3                 288
#define HTM_H4                 289
#define HTM_H5                 290
#define HTM_H6                 291
#define HTM_HEAD               292
#define HTM_HEIGHT             293
#define HTM_HIDDEN             294
#define HTM_HR                 295
#define HTM_HREF               296
#define HTM_HTML               297
#define HTM_HTTPEQUIV          298
#define HTM_ID                 299
#define HTM_IFRAME             300
#define HTM_ILAYER             301
#define HTM_IMG                302
#define HTM_INPUT              303
#define HTM_LABEL              304
#define HTM_LANGUAGE           305
#define HTM_LANG               306
#define HTM_LAYER              307
#define HTM_LEFTMARGIN         308
#define HTM_LI                 309
#define HTM_LINK               310
#define HTM_MAP                311
#define HTM_MARGINHEIGHT       312
#define HTM_MARGINWIDTH        313
#define HTM_META               314
#define HTM_METHOD             315
#define HTM_MULTIPLE           316
#define HTM_NAME               317
#define HTM_OBJECT             318
#define HTM_OL                 319
#define HTM_OPTGROUP           320
#define HTM_OPTION             321
#define HTM_PARAM              322
#define HTM_PRE                323
#define HTM_PUBLIC             324
#define HTM_P                  325
#define HTM_READONLY           326
#define HTM_ROWSPAN            327
#define HTM_SCROLLING          328
#define HTM_SCROLL             329
#define HTM_SELECTED           330
#define HTM_SELECT             331
#define HTM_SIZE               332
#define HTM_SMALL              333
#define HTM_SPAN               334
#define HTM_SRC                335
#define HTM_STYLE              336
#define HTM_SUB                337
#define HTM_SUP                338
#define HTM_TABLE              339
#define HTM_TD                 340
#define HTM_TEXTAREA           341
#define HTM_TEXT               342
#define HTM_TH                 343
#define HTM_TITLE              344
#define HTM_TR                 345
#define HTM_UL                 346
#define HTM_URL                347
#define HTM_URN                348
#define HTM_USEMAP             349
#define HTM_VALIGN             350
#define HTM_VALUE              351
#define HTM_WIDTH              352
#define JSP_ABSTRACT           353
#define JSP_DEFAULT            354
#define JSP_IF                 355
#define JSP_PRIVATE            356
#define JSP_THROW              357
#define JSP_BOOLEAN            358
#define JSP_DO                 359
#define JSP_IMPLEMENTS         360
#define JSP_PROTECTED          361
#define JSP_THROWS             362
#define JSP_BREAK              363
#define JSP_DOUBLE             364
#define JSP_IMPORT             365
#define JSP_PUBLIC             366
#define JSP_TRANSIENT          367
#define JSP_BYTE               368
#define JSP_ELSE               369
#define JSP_INSTANCEOF         370
#define JSP_RETURN             371
#define JSP_TRY                372
#define JSP_CASE               373
#define JSP_EXTENDS            374
#define JSP_INT                375
#define JSP_SHORT              376
#define JSP_VOID               377
#define JSP_CATCH              378
#define JSP_FINAL              379
#define JSP_INTERFACE          380
#define JSP_STATIC             381
#define JSP_VOLATILE           382
#define JSP_CHAR               383
#define JSP_FINALLY            384
#define JSP_LONG               385
#define JSP_SUPER              386
#define JSP_WHILE              387
#define JSP_CLASS              388
#define JSP_NATIVE             389
#define JSP_FLOAT              390
#define JSP_SWITCH             391
#define JSP_CONST              392
#define JSP_FOR                393
#define JSP_NEW                394
#define JSP_SYNCHRONIZED       395
#define JSP_CONTINUE           396
#define JSP_GOTO               397
#define JSP_PACKAGE            398
#define JSP_THIS               399
#define JSP_EQUALS             400
#define JSP_GT                 401
#define JSP_LT                 402
#define JSP_NOT                403
#define JSP_TILDE              404
#define JSP_QUERY              405
#define JSP_COLON              406
#define JSP_EQUALITY           407
#define JSP_LTEQUAL            408
#define JSP_GTEQUAL            409
#define JSP_NOTEQUAL           410
#define JSP_AND                411
#define JSP_OR                 412
#define JSP_INCREMENT          413
#define JSP_DECREMENT          414
#define JSP_ADD                415
#define JSP_SUBTRACT           416
#define JSP_MULTIPLY           417
#define JSP_DIVIDE             418
#define JSP_BINAND             419
#define JSP_BINOR              420
#define JSP_CARET              421
#define JSP_PCT                422
#define JSP_LEFTSHIFT          423
#define JSP_RIGHTSHIFT         424
#define JSP_DBLRGHTSHIFT       425
#define JSP_PLUSEQUALS         426
#define JSP_MINUSEQUALS        427
#define JSP_MULTIPLYEQUALS     428
#define JSP_DIVIDEEQUALS       429
#define JSP_ANDEQUALS          430
#define JSP_OREQUALS           431
#define JSP_CARETEQUALS        432
#define JSP_PCTEQUALS          433
#define JSP_LEFTEQUALS         434
#define JSP_RIGHTEQUALS        435
#define JSP_DBLRGHTEQUALS      436
#define JSP_OPENPARENTH        437
#define JSP_CLOSEPARENTH       438
#define JSP_OPENBRACE          439
#define JSP_CLOSEBRACE         440
#define JSP_OPENBRACKET        441
#define JSP_CLOSEBRACKET       442
#define JSP_SEMICOLON          443
#define JSP_COMMA              444
#define JSP_PERIOD             445


































































































































































































































































































































































