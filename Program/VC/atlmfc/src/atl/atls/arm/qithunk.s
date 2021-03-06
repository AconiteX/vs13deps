; This is a part of the Active Template Library.
; Copyright (C) Microsoft Corporation
; All rights reserved.
;
; This source code is only intended as a supplement to the
; Active Template Library Reference and related
; electronic documentation provided with the library.
; See these sources for detailed information regarding the	
; Active Template Library product.
;
; Author:
;
;   Ten Tzen (tentzen) 23-Aug-2010
;

#include "ksarm.h"

        MACRO
$name   IMPL_QITHUNK    $num, $addoffset
    LEAF_ENTRY ?f$num@_QIThunk@ATL@@UAAJXZ
    ldr     r12, [r0, #8]		; get the ref Count  
    cmp     r12, #0             ; compare to zero
    ble     badref$num          ; if refCnt is less than zero

    ldr     r0, [r0, #4]	        ; r0 = _QIThunk->pUnk, replace the 1st parameter (this) with _QIThunk->pUnk
    ldr     r12, [r0]               ; r12 = _QIThunk->pUnk->vTable
    ldr     pc, [r12, #$addoffset]  ; branch to actual call site, [r12 + $num*4]

badref$num
    und     #0xFE               ; debug break if call through deleted thunk
    LEAF_END ?f$num@_QIThunk@ATL@@UAAJXZ

    MEND


; the code below uses the IMPL_QITHUNK macro to generate functions ?f3@_QIThunk@ATL@@UAAJXZ 
;   to f1023@_QIThunk@ATL@@UAAJXZ

; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;  The following Macro does not work since it needs [r12, #0x$addoffset] that results in 
;       ?f00000003@_QIThunk@ATL@@UAAJXZ. 
;
;    GBLA   N
;N   SETA   3
;    WHILE N < 1024
;func$N   IMPL_QITHUNK $N, $N*4
;N        SETA  N+1
;         WEND
; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

func3   IMPL_QITHUNK 3, 12
func4   IMPL_QITHUNK 4, 16
func5   IMPL_QITHUNK 5, 20
func6   IMPL_QITHUNK 6, 24
func7   IMPL_QITHUNK 7, 28
func8   IMPL_QITHUNK 8, 32
func9   IMPL_QITHUNK 9, 36
func10  IMPL_QITHUNK 10, 40
func11  IMPL_QITHUNK 11, 44
func12  IMPL_QITHUNK 12, 48
func13  IMPL_QITHUNK 13, 52
func14  IMPL_QITHUNK 14, 56
func15  IMPL_QITHUNK 15, 60
func16  IMPL_QITHUNK 16, 64
func17  IMPL_QITHUNK 17, 68
func18  IMPL_QITHUNK 18, 72
func19  IMPL_QITHUNK 19, 76
func20  IMPL_QITHUNK 20, 80
func21  IMPL_QITHUNK 21, 84
func22  IMPL_QITHUNK 22, 88
func23  IMPL_QITHUNK 23, 92
func24  IMPL_QITHUNK 24, 96
func25  IMPL_QITHUNK 25, 100
func26  IMPL_QITHUNK 26, 104
func27  IMPL_QITHUNK 27, 108
func28  IMPL_QITHUNK 28, 112
func29  IMPL_QITHUNK 29, 116
func30  IMPL_QITHUNK 30, 120
func31  IMPL_QITHUNK 31, 124
func32  IMPL_QITHUNK 32, 128
func33  IMPL_QITHUNK 33, 132
func34  IMPL_QITHUNK 34, 136
func35  IMPL_QITHUNK 35, 140
func36  IMPL_QITHUNK 36, 144
func37  IMPL_QITHUNK 37, 148
func38  IMPL_QITHUNK 38, 152
func39  IMPL_QITHUNK 39, 156
func40  IMPL_QITHUNK 40, 160
func41  IMPL_QITHUNK 41, 164
func42  IMPL_QITHUNK 42, 168
func43  IMPL_QITHUNK 43, 172
func44  IMPL_QITHUNK 44, 176
func45  IMPL_QITHUNK 45, 180
func46  IMPL_QITHUNK 46, 184
func47  IMPL_QITHUNK 47, 188
func48  IMPL_QITHUNK 48, 192
func49  IMPL_QITHUNK 49, 196
func50  IMPL_QITHUNK 50, 200
func51  IMPL_QITHUNK 51, 204
func52  IMPL_QITHUNK 52, 208
func53  IMPL_QITHUNK 53, 212
func54  IMPL_QITHUNK 54, 216
func55  IMPL_QITHUNK 55, 220
func56  IMPL_QITHUNK 56, 224
func57  IMPL_QITHUNK 57, 228
func58  IMPL_QITHUNK 58, 232
func59  IMPL_QITHUNK 59, 236
func60  IMPL_QITHUNK 60, 240
func61  IMPL_QITHUNK 61, 244
func62  IMPL_QITHUNK 62, 248
func63  IMPL_QITHUNK 63, 252
func64  IMPL_QITHUNK 64, 256
func65  IMPL_QITHUNK 65, 260
func66  IMPL_QITHUNK 66, 264
func67  IMPL_QITHUNK 67, 268
func68  IMPL_QITHUNK 68, 272
func69  IMPL_QITHUNK 69, 276
func70  IMPL_QITHUNK 70, 280
func71  IMPL_QITHUNK 71, 284
func72  IMPL_QITHUNK 72, 288
func73  IMPL_QITHUNK 73, 292
func74  IMPL_QITHUNK 74, 296
func75  IMPL_QITHUNK 75, 300
func76  IMPL_QITHUNK 76, 304
func77  IMPL_QITHUNK 77, 308
func78  IMPL_QITHUNK 78, 312
func79  IMPL_QITHUNK 79, 316
func80  IMPL_QITHUNK 80, 320
func81  IMPL_QITHUNK 81, 324
func82  IMPL_QITHUNK 82, 328
func83  IMPL_QITHUNK 83, 332
func84  IMPL_QITHUNK 84, 336
func85  IMPL_QITHUNK 85, 340
func86  IMPL_QITHUNK 86, 344
func87  IMPL_QITHUNK 87, 348
func88  IMPL_QITHUNK 88, 352
func89  IMPL_QITHUNK 89, 356
func90  IMPL_QITHUNK 90, 360
func91  IMPL_QITHUNK 91, 364
func92  IMPL_QITHUNK 92, 368
func93  IMPL_QITHUNK 93, 372
func94  IMPL_QITHUNK 94, 376
func95  IMPL_QITHUNK 95, 380
func96  IMPL_QITHUNK 96, 384
func97  IMPL_QITHUNK 97, 388
func98  IMPL_QITHUNK 98, 392
func99  IMPL_QITHUNK 99, 396

func100  IMPL_QITHUNK 100, 400
func101  IMPL_QITHUNK 101, 404
func102  IMPL_QITHUNK 102, 408
func103  IMPL_QITHUNK 103, 412
func104  IMPL_QITHUNK 104, 416
func105  IMPL_QITHUNK 105, 420
func106  IMPL_QITHUNK 106, 424
func107  IMPL_QITHUNK 107, 428
func108  IMPL_QITHUNK 108, 432
func109  IMPL_QITHUNK 109, 436
func110  IMPL_QITHUNK 110, 440
func111  IMPL_QITHUNK 111, 444
func112  IMPL_QITHUNK 112, 448
func113  IMPL_QITHUNK 113, 452
func114  IMPL_QITHUNK 114, 456
func115  IMPL_QITHUNK 115, 460
func116  IMPL_QITHUNK 116, 464
func117  IMPL_QITHUNK 117, 468
func118  IMPL_QITHUNK 118, 472
func119  IMPL_QITHUNK 119, 476
func120  IMPL_QITHUNK 120, 480
func121  IMPL_QITHUNK 121, 484
func122  IMPL_QITHUNK 122, 488
func123  IMPL_QITHUNK 123, 492
func124  IMPL_QITHUNK 124, 496
func125  IMPL_QITHUNK 125, 500
func126  IMPL_QITHUNK 126, 504
func127  IMPL_QITHUNK 127, 508
func128  IMPL_QITHUNK 128, 512
func129  IMPL_QITHUNK 129, 516
func130  IMPL_QITHUNK 130, 520
func131  IMPL_QITHUNK 131, 524
func132  IMPL_QITHUNK 132, 528
func133  IMPL_QITHUNK 133, 532
func134  IMPL_QITHUNK 134, 536
func135  IMPL_QITHUNK 135, 540
func136  IMPL_QITHUNK 136, 544
func137  IMPL_QITHUNK 137, 548
func138  IMPL_QITHUNK 138, 552
func139  IMPL_QITHUNK 139, 556
func140  IMPL_QITHUNK 140, 560
func141  IMPL_QITHUNK 141, 564
func142  IMPL_QITHUNK 142, 568
func143  IMPL_QITHUNK 143, 572
func144  IMPL_QITHUNK 144, 576
func145  IMPL_QITHUNK 145, 580
func146  IMPL_QITHUNK 146, 584
func147  IMPL_QITHUNK 147, 588
func148  IMPL_QITHUNK 148, 592
func149  IMPL_QITHUNK 149, 596
func150  IMPL_QITHUNK 150, 600
func151  IMPL_QITHUNK 151, 604
func152  IMPL_QITHUNK 152, 608
func153  IMPL_QITHUNK 153, 612
func154  IMPL_QITHUNK 154, 616
func155  IMPL_QITHUNK 155, 620
func156  IMPL_QITHUNK 156, 624
func157  IMPL_QITHUNK 157, 628
func158  IMPL_QITHUNK 158, 632
func159  IMPL_QITHUNK 159, 636
func160  IMPL_QITHUNK 160, 640
func161  IMPL_QITHUNK 161, 644
func162  IMPL_QITHUNK 162, 648
func163  IMPL_QITHUNK 163, 652
func164  IMPL_QITHUNK 164, 656
func165  IMPL_QITHUNK 165, 660
func166  IMPL_QITHUNK 166, 664
func167  IMPL_QITHUNK 167, 668
func168  IMPL_QITHUNK 168, 672
func169  IMPL_QITHUNK 169, 676
func170  IMPL_QITHUNK 170, 680
func171  IMPL_QITHUNK 171, 684
func172  IMPL_QITHUNK 172, 688
func173  IMPL_QITHUNK 173, 692
func174  IMPL_QITHUNK 174, 696
func175  IMPL_QITHUNK 175, 700
func176  IMPL_QITHUNK 176, 704
func177  IMPL_QITHUNK 177, 708
func178  IMPL_QITHUNK 178, 712
func179  IMPL_QITHUNK 179, 716
func180  IMPL_QITHUNK 180, 720
func181  IMPL_QITHUNK 181, 724
func182  IMPL_QITHUNK 182, 728
func183  IMPL_QITHUNK 183, 732
func184  IMPL_QITHUNK 184, 736
func185  IMPL_QITHUNK 185, 740
func186  IMPL_QITHUNK 186, 744
func187  IMPL_QITHUNK 187, 748
func188  IMPL_QITHUNK 188, 752
func189  IMPL_QITHUNK 189, 756
func190  IMPL_QITHUNK 190, 760
func191  IMPL_QITHUNK 191, 764
func192  IMPL_QITHUNK 192, 768
func193  IMPL_QITHUNK 193, 772
func194  IMPL_QITHUNK 194, 776
func195  IMPL_QITHUNK 195, 780
func196  IMPL_QITHUNK 196, 784
func197  IMPL_QITHUNK 197, 788
func198  IMPL_QITHUNK 198, 792
func199  IMPL_QITHUNK 199, 796

func200  IMPL_QITHUNK 200, 800
func201  IMPL_QITHUNK 201, 804
func202  IMPL_QITHUNK 202, 808
func203  IMPL_QITHUNK 203, 812
func204  IMPL_QITHUNK 204, 816
func205  IMPL_QITHUNK 205, 820
func206  IMPL_QITHUNK 206, 824
func207  IMPL_QITHUNK 207, 828
func208  IMPL_QITHUNK 208, 832
func209  IMPL_QITHUNK 209, 836
func210  IMPL_QITHUNK 210, 840
func211  IMPL_QITHUNK 211, 844
func212  IMPL_QITHUNK 212, 848
func213  IMPL_QITHUNK 213, 852
func214  IMPL_QITHUNK 214, 856
func215  IMPL_QITHUNK 215, 860
func216  IMPL_QITHUNK 216, 864
func217  IMPL_QITHUNK 217, 868
func218  IMPL_QITHUNK 218, 872
func219  IMPL_QITHUNK 219, 876
func220  IMPL_QITHUNK 220, 880
func221  IMPL_QITHUNK 221, 884
func222  IMPL_QITHUNK 222, 888
func223  IMPL_QITHUNK 223, 892
func224  IMPL_QITHUNK 224, 896
func225  IMPL_QITHUNK 225, 900
func226  IMPL_QITHUNK 226, 904
func227  IMPL_QITHUNK 227, 908
func228  IMPL_QITHUNK 228, 912
func229  IMPL_QITHUNK 229, 916
func230  IMPL_QITHUNK 230, 920
func231  IMPL_QITHUNK 231, 924
func232  IMPL_QITHUNK 232, 928
func233  IMPL_QITHUNK 233, 932
func234  IMPL_QITHUNK 234, 936
func235  IMPL_QITHUNK 235, 940
func236  IMPL_QITHUNK 236, 944
func237  IMPL_QITHUNK 237, 948
func238  IMPL_QITHUNK 238, 952
func239  IMPL_QITHUNK 239, 956
func240  IMPL_QITHUNK 240, 960
func241  IMPL_QITHUNK 241, 964
func242  IMPL_QITHUNK 242, 968
func243  IMPL_QITHUNK 243, 972
func244  IMPL_QITHUNK 244, 976
func245  IMPL_QITHUNK 245, 980
func246  IMPL_QITHUNK 246, 984
func247  IMPL_QITHUNK 247, 988
func248  IMPL_QITHUNK 248, 992
func249  IMPL_QITHUNK 249, 996
func250  IMPL_QITHUNK 250, 1000
func251  IMPL_QITHUNK 251, 1004
func252  IMPL_QITHUNK 252, 1008
func253  IMPL_QITHUNK 253, 1012
func254  IMPL_QITHUNK 254, 1016
func255  IMPL_QITHUNK 255, 1020
func256  IMPL_QITHUNK 256, 1024
func257  IMPL_QITHUNK 257, 1028
func258  IMPL_QITHUNK 258, 1032
func259  IMPL_QITHUNK 259, 1036
func260  IMPL_QITHUNK 260, 1040
func261  IMPL_QITHUNK 261, 1044
func262  IMPL_QITHUNK 262, 1048
func263  IMPL_QITHUNK 263, 1052
func264  IMPL_QITHUNK 264, 1056
func265  IMPL_QITHUNK 265, 1060
func266  IMPL_QITHUNK 266, 1064
func267  IMPL_QITHUNK 267, 1068
func268  IMPL_QITHUNK 268, 1072
func269  IMPL_QITHUNK 269, 1076
func270  IMPL_QITHUNK 270, 1080
func271  IMPL_QITHUNK 271, 1084
func272  IMPL_QITHUNK 272, 1088
func273  IMPL_QITHUNK 273, 1092
func274  IMPL_QITHUNK 274, 1096
func275  IMPL_QITHUNK 275, 1100
func276  IMPL_QITHUNK 276, 1104
func277  IMPL_QITHUNK 277, 1108
func278  IMPL_QITHUNK 278, 1112
func279  IMPL_QITHUNK 279, 1116
func280  IMPL_QITHUNK 280, 1120
func281  IMPL_QITHUNK 281, 1124
func282  IMPL_QITHUNK 282, 1128
func283  IMPL_QITHUNK 283, 1132
func284  IMPL_QITHUNK 284, 1136
func285  IMPL_QITHUNK 285, 1140
func286  IMPL_QITHUNK 286, 1144
func287  IMPL_QITHUNK 287, 1148
func288  IMPL_QITHUNK 288, 1152
func289  IMPL_QITHUNK 289, 1156
func290  IMPL_QITHUNK 290, 1160
func291  IMPL_QITHUNK 291, 1164
func292  IMPL_QITHUNK 292, 1168
func293  IMPL_QITHUNK 293, 1172
func294  IMPL_QITHUNK 294, 1176
func295  IMPL_QITHUNK 295, 1180
func296  IMPL_QITHUNK 296, 1184
func297  IMPL_QITHUNK 297, 1188
func298  IMPL_QITHUNK 298, 1192
func299  IMPL_QITHUNK 299, 1196

func300  IMPL_QITHUNK 300, 1200
func301  IMPL_QITHUNK 301, 1204
func302  IMPL_QITHUNK 302, 1208
func303  IMPL_QITHUNK 303, 1212
func304  IMPL_QITHUNK 304, 1216
func305  IMPL_QITHUNK 305, 1220
func306  IMPL_QITHUNK 306, 1224
func307  IMPL_QITHUNK 307, 1228
func308  IMPL_QITHUNK 308, 1232
func309  IMPL_QITHUNK 309, 1236
func310  IMPL_QITHUNK 310, 1240
func311  IMPL_QITHUNK 311, 1244
func312  IMPL_QITHUNK 312, 1248
func313  IMPL_QITHUNK 313, 1252
func314  IMPL_QITHUNK 314, 1256
func315  IMPL_QITHUNK 315, 1260
func316  IMPL_QITHUNK 316, 1264
func317  IMPL_QITHUNK 317, 1268
func318  IMPL_QITHUNK 318, 1272
func319  IMPL_QITHUNK 319, 1276
func320  IMPL_QITHUNK 320, 1280
func321  IMPL_QITHUNK 321, 1284
func322  IMPL_QITHUNK 322, 1288
func323  IMPL_QITHUNK 323, 1292
func324  IMPL_QITHUNK 324, 1296
func325  IMPL_QITHUNK 325, 1300
func326  IMPL_QITHUNK 326, 1304
func327  IMPL_QITHUNK 327, 1308
func328  IMPL_QITHUNK 328, 1312
func329  IMPL_QITHUNK 329, 1316
func330  IMPL_QITHUNK 330, 1320
func331  IMPL_QITHUNK 331, 1324
func332  IMPL_QITHUNK 332, 1328
func333  IMPL_QITHUNK 333, 1332
func334  IMPL_QITHUNK 334, 1336
func335  IMPL_QITHUNK 335, 1340
func336  IMPL_QITHUNK 336, 1344
func337  IMPL_QITHUNK 337, 1348
func338  IMPL_QITHUNK 338, 1352
func339  IMPL_QITHUNK 339, 1356
func340  IMPL_QITHUNK 340, 1360
func341  IMPL_QITHUNK 341, 1364
func342  IMPL_QITHUNK 342, 1368
func343  IMPL_QITHUNK 343, 1372
func344  IMPL_QITHUNK 344, 1376
func345  IMPL_QITHUNK 345, 1380
func346  IMPL_QITHUNK 346, 1384
func347  IMPL_QITHUNK 347, 1388
func348  IMPL_QITHUNK 348, 1392
func349  IMPL_QITHUNK 349, 1396
func350  IMPL_QITHUNK 350, 1400
func351  IMPL_QITHUNK 351, 1404
func352  IMPL_QITHUNK 352, 1408
func353  IMPL_QITHUNK 353, 1412
func354  IMPL_QITHUNK 354, 1416
func355  IMPL_QITHUNK 355, 1420
func356  IMPL_QITHUNK 356, 1424
func357  IMPL_QITHUNK 357, 1428
func358  IMPL_QITHUNK 358, 1432
func359  IMPL_QITHUNK 359, 1436
func360  IMPL_QITHUNK 360, 1440
func361  IMPL_QITHUNK 361, 1444
func362  IMPL_QITHUNK 362, 1448
func363  IMPL_QITHUNK 363, 1452
func364  IMPL_QITHUNK 364, 1456
func365  IMPL_QITHUNK 365, 1460
func366  IMPL_QITHUNK 366, 1464
func367  IMPL_QITHUNK 367, 1468
func368  IMPL_QITHUNK 368, 1472
func369  IMPL_QITHUNK 369, 1476
func370  IMPL_QITHUNK 370, 1480
func371  IMPL_QITHUNK 371, 1484
func372  IMPL_QITHUNK 372, 1488
func373  IMPL_QITHUNK 373, 1492
func374  IMPL_QITHUNK 374, 1496
func375  IMPL_QITHUNK 375, 1500
func376  IMPL_QITHUNK 376, 1504
func377  IMPL_QITHUNK 377, 1508
func378  IMPL_QITHUNK 378, 1512
func379  IMPL_QITHUNK 379, 1516
func380  IMPL_QITHUNK 380, 1520
func381  IMPL_QITHUNK 381, 1524
func382  IMPL_QITHUNK 382, 1528
func383  IMPL_QITHUNK 383, 1532
func384  IMPL_QITHUNK 384, 1536
func385  IMPL_QITHUNK 385, 1540
func386  IMPL_QITHUNK 386, 1544
func387  IMPL_QITHUNK 387, 1548
func388  IMPL_QITHUNK 388, 1552
func389  IMPL_QITHUNK 389, 1556
func390  IMPL_QITHUNK 390, 1560
func391  IMPL_QITHUNK 391, 1564
func392  IMPL_QITHUNK 392, 1568
func393  IMPL_QITHUNK 393, 1572
func394  IMPL_QITHUNK 394, 1576
func395  IMPL_QITHUNK 395, 1580
func396  IMPL_QITHUNK 396, 1584
func397  IMPL_QITHUNK 397, 1588
func398  IMPL_QITHUNK 398, 1592
func399  IMPL_QITHUNK 399, 1596

func400  IMPL_QITHUNK 400, 1600
func401  IMPL_QITHUNK 401, 1604
func402  IMPL_QITHUNK 402, 1608
func403  IMPL_QITHUNK 403, 1612
func404  IMPL_QITHUNK 404, 1616
func405  IMPL_QITHUNK 405, 1620
func406  IMPL_QITHUNK 406, 1624
func407  IMPL_QITHUNK 407, 1628
func408  IMPL_QITHUNK 408, 1632
func409  IMPL_QITHUNK 409, 1636
func410  IMPL_QITHUNK 410, 1640
func411  IMPL_QITHUNK 411, 1644
func412  IMPL_QITHUNK 412, 1648
func413  IMPL_QITHUNK 413, 1652
func414  IMPL_QITHUNK 414, 1656
func415  IMPL_QITHUNK 415, 1660
func416  IMPL_QITHUNK 416, 1664
func417  IMPL_QITHUNK 417, 1668
func418  IMPL_QITHUNK 418, 1672
func419  IMPL_QITHUNK 419, 1676
func420  IMPL_QITHUNK 420, 1680
func421  IMPL_QITHUNK 421, 1684
func422  IMPL_QITHUNK 422, 1688
func423  IMPL_QITHUNK 423, 1692
func424  IMPL_QITHUNK 424, 1696
func425  IMPL_QITHUNK 425, 1700
func426  IMPL_QITHUNK 426, 1704
func427  IMPL_QITHUNK 427, 1708
func428  IMPL_QITHUNK 428, 1712
func429  IMPL_QITHUNK 429, 1716
func430  IMPL_QITHUNK 430, 1720
func431  IMPL_QITHUNK 431, 1724
func432  IMPL_QITHUNK 432, 1728
func433  IMPL_QITHUNK 433, 1732
func434  IMPL_QITHUNK 434, 1736
func435  IMPL_QITHUNK 435, 1740
func436  IMPL_QITHUNK 436, 1744
func437  IMPL_QITHUNK 437, 1748
func438  IMPL_QITHUNK 438, 1752
func439  IMPL_QITHUNK 439, 1756
func440  IMPL_QITHUNK 440, 1760
func441  IMPL_QITHUNK 441, 1764
func442  IMPL_QITHUNK 442, 1768
func443  IMPL_QITHUNK 443, 1772
func444  IMPL_QITHUNK 444, 1776
func445  IMPL_QITHUNK 445, 1780
func446  IMPL_QITHUNK 446, 1784
func447  IMPL_QITHUNK 447, 1788
func448  IMPL_QITHUNK 448, 1792
func449  IMPL_QITHUNK 449, 1796
func450  IMPL_QITHUNK 450, 1800
func451  IMPL_QITHUNK 451, 1804
func452  IMPL_QITHUNK 452, 1808
func453  IMPL_QITHUNK 453, 1812
func454  IMPL_QITHUNK 454, 1816
func455  IMPL_QITHUNK 455, 1820
func456  IMPL_QITHUNK 456, 1824
func457  IMPL_QITHUNK 457, 1828
func458  IMPL_QITHUNK 458, 1832
func459  IMPL_QITHUNK 459, 1836
func460  IMPL_QITHUNK 460, 1840
func461  IMPL_QITHUNK 461, 1844
func462  IMPL_QITHUNK 462, 1848
func463  IMPL_QITHUNK 463, 1852
func464  IMPL_QITHUNK 464, 1856
func465  IMPL_QITHUNK 465, 1860
func466  IMPL_QITHUNK 466, 1864
func467  IMPL_QITHUNK 467, 1868
func468  IMPL_QITHUNK 468, 1872
func469  IMPL_QITHUNK 469, 1876
func470  IMPL_QITHUNK 470, 1880
func471  IMPL_QITHUNK 471, 1884
func472  IMPL_QITHUNK 472, 1888
func473  IMPL_QITHUNK 473, 1892
func474  IMPL_QITHUNK 474, 1896
func475  IMPL_QITHUNK 475, 1900
func476  IMPL_QITHUNK 476, 1904
func477  IMPL_QITHUNK 477, 1908
func478  IMPL_QITHUNK 478, 1912
func479  IMPL_QITHUNK 479, 1916
func480  IMPL_QITHUNK 480, 1920
func481  IMPL_QITHUNK 481, 1924
func482  IMPL_QITHUNK 482, 1928
func483  IMPL_QITHUNK 483, 1932
func484  IMPL_QITHUNK 484, 1936
func485  IMPL_QITHUNK 485, 1940
func486  IMPL_QITHUNK 486, 1944
func487  IMPL_QITHUNK 487, 1948
func488  IMPL_QITHUNK 488, 1952
func489  IMPL_QITHUNK 489, 1956
func490  IMPL_QITHUNK 490, 1960
func491  IMPL_QITHUNK 491, 1964
func492  IMPL_QITHUNK 492, 1968
func493  IMPL_QITHUNK 493, 1972
func494  IMPL_QITHUNK 494, 1976
func495  IMPL_QITHUNK 495, 1980
func496  IMPL_QITHUNK 496, 1984
func497  IMPL_QITHUNK 497, 1988
func498  IMPL_QITHUNK 498, 1992
func499  IMPL_QITHUNK 499, 1996

func500  IMPL_QITHUNK 500, 2000
func501  IMPL_QITHUNK 501, 2004
func502  IMPL_QITHUNK 502, 2008
func503  IMPL_QITHUNK 503, 2012
func504  IMPL_QITHUNK 504, 2016
func505  IMPL_QITHUNK 505, 2020
func506  IMPL_QITHUNK 506, 2024
func507  IMPL_QITHUNK 507, 2028
func508  IMPL_QITHUNK 508, 2032
func509  IMPL_QITHUNK 509, 2036
func510  IMPL_QITHUNK 510, 2040
func511  IMPL_QITHUNK 511, 2044
func512  IMPL_QITHUNK 512, 2048
func513  IMPL_QITHUNK 513, 2052
func514  IMPL_QITHUNK 514, 2056
func515  IMPL_QITHUNK 515, 2060
func516  IMPL_QITHUNK 516, 2064
func517  IMPL_QITHUNK 517, 2068
func518  IMPL_QITHUNK 518, 2072
func519  IMPL_QITHUNK 519, 2076
func520  IMPL_QITHUNK 520, 2080
func521  IMPL_QITHUNK 521, 2084
func522  IMPL_QITHUNK 522, 2088
func523  IMPL_QITHUNK 523, 2092
func524  IMPL_QITHUNK 524, 2096
func525  IMPL_QITHUNK 525, 2100
func526  IMPL_QITHUNK 526, 2104
func527  IMPL_QITHUNK 527, 2108
func528  IMPL_QITHUNK 528, 2112
func529  IMPL_QITHUNK 529, 2116
func530  IMPL_QITHUNK 530, 2120
func531  IMPL_QITHUNK 531, 2124
func532  IMPL_QITHUNK 532, 2128
func533  IMPL_QITHUNK 533, 2132
func534  IMPL_QITHUNK 534, 2136
func535  IMPL_QITHUNK 535, 2140
func536  IMPL_QITHUNK 536, 2144
func537  IMPL_QITHUNK 537, 2148
func538  IMPL_QITHUNK 538, 2152
func539  IMPL_QITHUNK 539, 2156
func540  IMPL_QITHUNK 540, 2160
func541  IMPL_QITHUNK 541, 2164
func542  IMPL_QITHUNK 542, 2168
func543  IMPL_QITHUNK 543, 2172
func544  IMPL_QITHUNK 544, 2176
func545  IMPL_QITHUNK 545, 2180
func546  IMPL_QITHUNK 546, 2184
func547  IMPL_QITHUNK 547, 2188
func548  IMPL_QITHUNK 548, 2192
func549  IMPL_QITHUNK 549, 2196
func550  IMPL_QITHUNK 550, 2200
func551  IMPL_QITHUNK 551, 2204
func552  IMPL_QITHUNK 552, 2208
func553  IMPL_QITHUNK 553, 2212
func554  IMPL_QITHUNK 554, 2216
func555  IMPL_QITHUNK 555, 2220
func556  IMPL_QITHUNK 556, 2224
func557  IMPL_QITHUNK 557, 2228
func558  IMPL_QITHUNK 558, 2232
func559  IMPL_QITHUNK 559, 2236
func560  IMPL_QITHUNK 560, 2240
func561  IMPL_QITHUNK 561, 2244
func562  IMPL_QITHUNK 562, 2248
func563  IMPL_QITHUNK 563, 2252
func564  IMPL_QITHUNK 564, 2256
func565  IMPL_QITHUNK 565, 2260
func566  IMPL_QITHUNK 566, 2264
func567  IMPL_QITHUNK 567, 2268
func568  IMPL_QITHUNK 568, 2272
func569  IMPL_QITHUNK 569, 2276
func570  IMPL_QITHUNK 570, 2280
func571  IMPL_QITHUNK 571, 2284
func572  IMPL_QITHUNK 572, 2288
func573  IMPL_QITHUNK 573, 2292
func574  IMPL_QITHUNK 574, 2296
func575  IMPL_QITHUNK 575, 2300
func576  IMPL_QITHUNK 576, 2304
func577  IMPL_QITHUNK 577, 2308
func578  IMPL_QITHUNK 578, 2312
func579  IMPL_QITHUNK 579, 2316
func580  IMPL_QITHUNK 580, 2320
func581  IMPL_QITHUNK 581, 2324
func582  IMPL_QITHUNK 582, 2328
func583  IMPL_QITHUNK 583, 2332
func584  IMPL_QITHUNK 584, 2336
func585  IMPL_QITHUNK 585, 2340
func586  IMPL_QITHUNK 586, 2344
func587  IMPL_QITHUNK 587, 2348
func588  IMPL_QITHUNK 588, 2352
func589  IMPL_QITHUNK 589, 2356
func590  IMPL_QITHUNK 590, 2360
func591  IMPL_QITHUNK 591, 2364
func592  IMPL_QITHUNK 592, 2368
func593  IMPL_QITHUNK 593, 2372
func594  IMPL_QITHUNK 594, 2376
func595  IMPL_QITHUNK 595, 2380
func596  IMPL_QITHUNK 596, 2384
func597  IMPL_QITHUNK 597, 2388
func598  IMPL_QITHUNK 598, 2392
func599  IMPL_QITHUNK 599, 2396

func600  IMPL_QITHUNK 600, 2400
func601  IMPL_QITHUNK 601, 2404
func602  IMPL_QITHUNK 602, 2408
func603  IMPL_QITHUNK 603, 2412
func604  IMPL_QITHUNK 604, 2416
func605  IMPL_QITHUNK 605, 2420
func606  IMPL_QITHUNK 606, 2424
func607  IMPL_QITHUNK 607, 2428
func608  IMPL_QITHUNK 608, 2432
func609  IMPL_QITHUNK 609, 2436
func610  IMPL_QITHUNK 610, 2440
func611  IMPL_QITHUNK 611, 2444
func612  IMPL_QITHUNK 612, 2448
func613  IMPL_QITHUNK 613, 2452
func614  IMPL_QITHUNK 614, 2456
func615  IMPL_QITHUNK 615, 2460
func616  IMPL_QITHUNK 616, 2464
func617  IMPL_QITHUNK 617, 2468
func618  IMPL_QITHUNK 618, 2472
func619  IMPL_QITHUNK 619, 2476
func620  IMPL_QITHUNK 620, 2480
func621  IMPL_QITHUNK 621, 2484
func622  IMPL_QITHUNK 622, 2488
func623  IMPL_QITHUNK 623, 2492
func624  IMPL_QITHUNK 624, 2496
func625  IMPL_QITHUNK 625, 2500
func626  IMPL_QITHUNK 626, 2504
func627  IMPL_QITHUNK 627, 2508
func628  IMPL_QITHUNK 628, 2512
func629  IMPL_QITHUNK 629, 2516
func630  IMPL_QITHUNK 630, 2520
func631  IMPL_QITHUNK 631, 2524
func632  IMPL_QITHUNK 632, 2528
func633  IMPL_QITHUNK 633, 2532
func634  IMPL_QITHUNK 634, 2536
func635  IMPL_QITHUNK 635, 2540
func636  IMPL_QITHUNK 636, 2544
func637  IMPL_QITHUNK 637, 2548
func638  IMPL_QITHUNK 638, 2552
func639  IMPL_QITHUNK 639, 2556
func640  IMPL_QITHUNK 640, 2560
func641  IMPL_QITHUNK 641, 2564
func642  IMPL_QITHUNK 642, 2568
func643  IMPL_QITHUNK 643, 2572
func644  IMPL_QITHUNK 644, 2576
func645  IMPL_QITHUNK 645, 2580
func646  IMPL_QITHUNK 646, 2584
func647  IMPL_QITHUNK 647, 2588
func648  IMPL_QITHUNK 648, 2592
func649  IMPL_QITHUNK 649, 2596
func650  IMPL_QITHUNK 650, 2600
func651  IMPL_QITHUNK 651, 2604
func652  IMPL_QITHUNK 652, 2608
func653  IMPL_QITHUNK 653, 2612
func654  IMPL_QITHUNK 654, 2616
func655  IMPL_QITHUNK 655, 2620
func656  IMPL_QITHUNK 656, 2624
func657  IMPL_QITHUNK 657, 2628
func658  IMPL_QITHUNK 658, 2632
func659  IMPL_QITHUNK 659, 2636
func660  IMPL_QITHUNK 660, 2640
func661  IMPL_QITHUNK 661, 2644
func662  IMPL_QITHUNK 662, 2648
func663  IMPL_QITHUNK 663, 2652
func664  IMPL_QITHUNK 664, 2656
func665  IMPL_QITHUNK 665, 2660
func666  IMPL_QITHUNK 666, 2664
func667  IMPL_QITHUNK 667, 2668
func668  IMPL_QITHUNK 668, 2672
func669  IMPL_QITHUNK 669, 2676
func670  IMPL_QITHUNK 670, 2680
func671  IMPL_QITHUNK 671, 2684
func672  IMPL_QITHUNK 672, 2688
func673  IMPL_QITHUNK 673, 2692
func674  IMPL_QITHUNK 674, 2696
func675  IMPL_QITHUNK 675, 2700
func676  IMPL_QITHUNK 676, 2704
func677  IMPL_QITHUNK 677, 2708
func678  IMPL_QITHUNK 678, 2712
func679  IMPL_QITHUNK 679, 2716
func680  IMPL_QITHUNK 680, 2720
func681  IMPL_QITHUNK 681, 2724
func682  IMPL_QITHUNK 682, 2728
func683  IMPL_QITHUNK 683, 2732
func684  IMPL_QITHUNK 684, 2736
func685  IMPL_QITHUNK 685, 2740
func686  IMPL_QITHUNK 686, 2744
func687  IMPL_QITHUNK 687, 2748
func688  IMPL_QITHUNK 688, 2752
func689  IMPL_QITHUNK 689, 2756
func690  IMPL_QITHUNK 690, 2760
func691  IMPL_QITHUNK 691, 2764
func692  IMPL_QITHUNK 692, 2768
func693  IMPL_QITHUNK 693, 2772
func694  IMPL_QITHUNK 694, 2776
func695  IMPL_QITHUNK 695, 2780
func696  IMPL_QITHUNK 696, 2784
func697  IMPL_QITHUNK 697, 2788
func698  IMPL_QITHUNK 698, 2792
func699  IMPL_QITHUNK 699, 2796

func700  IMPL_QITHUNK 700, 2800
func701  IMPL_QITHUNK 701, 2804
func702  IMPL_QITHUNK 702, 2808
func703  IMPL_QITHUNK 703, 2812
func704  IMPL_QITHUNK 704, 2816
func705  IMPL_QITHUNK 705, 2820
func706  IMPL_QITHUNK 706, 2824
func707  IMPL_QITHUNK 707, 2828
func708  IMPL_QITHUNK 708, 2832
func709  IMPL_QITHUNK 709, 2836
func710  IMPL_QITHUNK 710, 2840
func711  IMPL_QITHUNK 711, 2844
func712  IMPL_QITHUNK 712, 2848
func713  IMPL_QITHUNK 713, 2852
func714  IMPL_QITHUNK 714, 2856
func715  IMPL_QITHUNK 715, 2860
func716  IMPL_QITHUNK 716, 2864
func717  IMPL_QITHUNK 717, 2868
func718  IMPL_QITHUNK 718, 2872
func719  IMPL_QITHUNK 719, 2876
func720  IMPL_QITHUNK 720, 2880
func721  IMPL_QITHUNK 721, 2884
func722  IMPL_QITHUNK 722, 2888
func723  IMPL_QITHUNK 723, 2892
func724  IMPL_QITHUNK 724, 2896
func725  IMPL_QITHUNK 725, 2900
func726  IMPL_QITHUNK 726, 2904
func727  IMPL_QITHUNK 727, 2908
func728  IMPL_QITHUNK 728, 2912
func729  IMPL_QITHUNK 729, 2916
func730  IMPL_QITHUNK 730, 2920
func731  IMPL_QITHUNK 731, 2924
func732  IMPL_QITHUNK 732, 2928
func733  IMPL_QITHUNK 733, 2932
func734  IMPL_QITHUNK 734, 2936
func735  IMPL_QITHUNK 735, 2940
func736  IMPL_QITHUNK 736, 2944
func737  IMPL_QITHUNK 737, 2948
func738  IMPL_QITHUNK 738, 2952
func739  IMPL_QITHUNK 739, 2956
func740  IMPL_QITHUNK 740, 2960
func741  IMPL_QITHUNK 741, 2964
func742  IMPL_QITHUNK 742, 2968
func743  IMPL_QITHUNK 743, 2972
func744  IMPL_QITHUNK 744, 2976
func745  IMPL_QITHUNK 745, 2980
func746  IMPL_QITHUNK 746, 2984
func747  IMPL_QITHUNK 747, 2988
func748  IMPL_QITHUNK 748, 2992
func749  IMPL_QITHUNK 749, 2996
func750  IMPL_QITHUNK 750, 3000
func751  IMPL_QITHUNK 751, 3004
func752  IMPL_QITHUNK 752, 3008
func753  IMPL_QITHUNK 753, 3012
func754  IMPL_QITHUNK 754, 3016
func755  IMPL_QITHUNK 755, 3020
func756  IMPL_QITHUNK 756, 3024
func757  IMPL_QITHUNK 757, 3028
func758  IMPL_QITHUNK 758, 3032
func759  IMPL_QITHUNK 759, 3036
func760  IMPL_QITHUNK 760, 3040
func761  IMPL_QITHUNK 761, 3044
func762  IMPL_QITHUNK 762, 3048
func763  IMPL_QITHUNK 763, 3052
func764  IMPL_QITHUNK 764, 3056
func765  IMPL_QITHUNK 765, 3060
func766  IMPL_QITHUNK 766, 3064
func767  IMPL_QITHUNK 767, 3068
func768  IMPL_QITHUNK 768, 3072
func769  IMPL_QITHUNK 769, 3076
func770  IMPL_QITHUNK 770, 3080
func771  IMPL_QITHUNK 771, 3084
func772  IMPL_QITHUNK 772, 3088
func773  IMPL_QITHUNK 773, 3092
func774  IMPL_QITHUNK 774, 3096
func775  IMPL_QITHUNK 775, 3100
func776  IMPL_QITHUNK 776, 3104
func777  IMPL_QITHUNK 777, 3108
func778  IMPL_QITHUNK 778, 3112
func779  IMPL_QITHUNK 779, 3116
func780  IMPL_QITHUNK 780, 3120
func781  IMPL_QITHUNK 781, 3124
func782  IMPL_QITHUNK 782, 3128
func783  IMPL_QITHUNK 783, 3132
func784  IMPL_QITHUNK 784, 3136
func785  IMPL_QITHUNK 785, 3140
func786  IMPL_QITHUNK 786, 3144
func787  IMPL_QITHUNK 787, 3148
func788  IMPL_QITHUNK 788, 3152
func789  IMPL_QITHUNK 789, 3156
func790  IMPL_QITHUNK 790, 3160
func791  IMPL_QITHUNK 791, 3164
func792  IMPL_QITHUNK 792, 3168
func793  IMPL_QITHUNK 793, 3172
func794  IMPL_QITHUNK 794, 3176
func795  IMPL_QITHUNK 795, 3180
func796  IMPL_QITHUNK 796, 3184
func797  IMPL_QITHUNK 797, 3188
func798  IMPL_QITHUNK 798, 3192
func799  IMPL_QITHUNK 799, 3196

func800  IMPL_QITHUNK 800, 3200
func801  IMPL_QITHUNK 801, 3204
func802  IMPL_QITHUNK 802, 3208
func803  IMPL_QITHUNK 803, 3212
func804  IMPL_QITHUNK 804, 3216
func805  IMPL_QITHUNK 805, 3220
func806  IMPL_QITHUNK 806, 3224
func807  IMPL_QITHUNK 807, 3228
func808  IMPL_QITHUNK 808, 3232
func809  IMPL_QITHUNK 809, 3236
func810  IMPL_QITHUNK 810, 3240
func811  IMPL_QITHUNK 811, 3244
func812  IMPL_QITHUNK 812, 3248
func813  IMPL_QITHUNK 813, 3252
func814  IMPL_QITHUNK 814, 3256
func815  IMPL_QITHUNK 815, 3260
func816  IMPL_QITHUNK 816, 3264
func817  IMPL_QITHUNK 817, 3268
func818  IMPL_QITHUNK 818, 3272
func819  IMPL_QITHUNK 819, 3276
func820  IMPL_QITHUNK 820, 3280
func821  IMPL_QITHUNK 821, 3284
func822  IMPL_QITHUNK 822, 3288
func823  IMPL_QITHUNK 823, 3292
func824  IMPL_QITHUNK 824, 3296
func825  IMPL_QITHUNK 825, 3300
func826  IMPL_QITHUNK 826, 3304
func827  IMPL_QITHUNK 827, 3308
func828  IMPL_QITHUNK 828, 3312
func829  IMPL_QITHUNK 829, 3316
func830  IMPL_QITHUNK 830, 3320
func831  IMPL_QITHUNK 831, 3324
func832  IMPL_QITHUNK 832, 3328
func833  IMPL_QITHUNK 833, 3332
func834  IMPL_QITHUNK 834, 3336
func835  IMPL_QITHUNK 835, 3340
func836  IMPL_QITHUNK 836, 3344
func837  IMPL_QITHUNK 837, 3348
func838  IMPL_QITHUNK 838, 3352
func839  IMPL_QITHUNK 839, 3356
func840  IMPL_QITHUNK 840, 3360
func841  IMPL_QITHUNK 841, 3364
func842  IMPL_QITHUNK 842, 3368
func843  IMPL_QITHUNK 843, 3372
func844  IMPL_QITHUNK 844, 3376
func845  IMPL_QITHUNK 845, 3380
func846  IMPL_QITHUNK 846, 3384
func847  IMPL_QITHUNK 847, 3388
func848  IMPL_QITHUNK 848, 3392
func849  IMPL_QITHUNK 849, 3396
func850  IMPL_QITHUNK 850, 3400
func851  IMPL_QITHUNK 851, 3404
func852  IMPL_QITHUNK 852, 3408
func853  IMPL_QITHUNK 853, 3412
func854  IMPL_QITHUNK 854, 3416
func855  IMPL_QITHUNK 855, 3420
func856  IMPL_QITHUNK 856, 3424
func857  IMPL_QITHUNK 857, 3428
func858  IMPL_QITHUNK 858, 3432
func859  IMPL_QITHUNK 859, 3436
func860  IMPL_QITHUNK 860, 3440
func861  IMPL_QITHUNK 861, 3444
func862  IMPL_QITHUNK 862, 3448
func863  IMPL_QITHUNK 863, 3452
func864  IMPL_QITHUNK 864, 3456
func865  IMPL_QITHUNK 865, 3460
func866  IMPL_QITHUNK 866, 3464
func867  IMPL_QITHUNK 867, 3468
func868  IMPL_QITHUNK 868, 3472
func869  IMPL_QITHUNK 869, 3476
func870  IMPL_QITHUNK 870, 3480
func871  IMPL_QITHUNK 871, 3484
func872  IMPL_QITHUNK 872, 3488
func873  IMPL_QITHUNK 873, 3492
func874  IMPL_QITHUNK 874, 3496
func875  IMPL_QITHUNK 875, 3500
func876  IMPL_QITHUNK 876, 3504
func877  IMPL_QITHUNK 877, 3508
func878  IMPL_QITHUNK 878, 3512
func879  IMPL_QITHUNK 879, 3516
func880  IMPL_QITHUNK 880, 3520
func881  IMPL_QITHUNK 881, 3524
func882  IMPL_QITHUNK 882, 3528
func883  IMPL_QITHUNK 883, 3532
func884  IMPL_QITHUNK 884, 3536
func885  IMPL_QITHUNK 885, 3540
func886  IMPL_QITHUNK 886, 3544
func887  IMPL_QITHUNK 887, 3548
func888  IMPL_QITHUNK 888, 3552
func889  IMPL_QITHUNK 889, 3556
func890  IMPL_QITHUNK 890, 3560
func891  IMPL_QITHUNK 891, 3564
func892  IMPL_QITHUNK 892, 3568
func893  IMPL_QITHUNK 893, 3572
func894  IMPL_QITHUNK 894, 3576
func895  IMPL_QITHUNK 895, 3580
func896  IMPL_QITHUNK 896, 3584
func897  IMPL_QITHUNK 897, 3588
func898  IMPL_QITHUNK 898, 3592
func899  IMPL_QITHUNK 899, 3596

func900  IMPL_QITHUNK 900, 3600
func901  IMPL_QITHUNK 901, 3604
func902  IMPL_QITHUNK 902, 3608
func903  IMPL_QITHUNK 903, 3612
func904  IMPL_QITHUNK 904, 3616
func905  IMPL_QITHUNK 905, 3620
func906  IMPL_QITHUNK 906, 3624
func907  IMPL_QITHUNK 907, 3628
func908  IMPL_QITHUNK 908, 3632
func909  IMPL_QITHUNK 909, 3636
func910  IMPL_QITHUNK 910, 3640
func911  IMPL_QITHUNK 911, 3644
func912  IMPL_QITHUNK 912, 3648
func913  IMPL_QITHUNK 913, 3652
func914  IMPL_QITHUNK 914, 3656
func915  IMPL_QITHUNK 915, 3660
func916  IMPL_QITHUNK 916, 3664
func917  IMPL_QITHUNK 917, 3668
func918  IMPL_QITHUNK 918, 3672
func919  IMPL_QITHUNK 919, 3676
func920  IMPL_QITHUNK 920, 3680
func921  IMPL_QITHUNK 921, 3684
func922  IMPL_QITHUNK 922, 3688
func923  IMPL_QITHUNK 923, 3692
func924  IMPL_QITHUNK 924, 3696
func925  IMPL_QITHUNK 925, 3700
func926  IMPL_QITHUNK 926, 3704
func927  IMPL_QITHUNK 927, 3708
func928  IMPL_QITHUNK 928, 3712
func929  IMPL_QITHUNK 929, 3716
func930  IMPL_QITHUNK 930, 3720
func931  IMPL_QITHUNK 931, 3724
func932  IMPL_QITHUNK 932, 3728
func933  IMPL_QITHUNK 933, 3732
func934  IMPL_QITHUNK 934, 3736
func935  IMPL_QITHUNK 935, 3740
func936  IMPL_QITHUNK 936, 3744
func937  IMPL_QITHUNK 937, 3748
func938  IMPL_QITHUNK 938, 3752
func939  IMPL_QITHUNK 939, 3756
func940  IMPL_QITHUNK 940, 3760
func941  IMPL_QITHUNK 941, 3764
func942  IMPL_QITHUNK 942, 3768
func943  IMPL_QITHUNK 943, 3772
func944  IMPL_QITHUNK 944, 3776
func945  IMPL_QITHUNK 945, 3780
func946  IMPL_QITHUNK 946, 3784
func947  IMPL_QITHUNK 947, 3788
func948  IMPL_QITHUNK 948, 3792
func949  IMPL_QITHUNK 949, 3796
func950  IMPL_QITHUNK 950, 3800
func951  IMPL_QITHUNK 951, 3804
func952  IMPL_QITHUNK 952, 3808
func953  IMPL_QITHUNK 953, 3812
func954  IMPL_QITHUNK 954, 3816
func955  IMPL_QITHUNK 955, 3820
func956  IMPL_QITHUNK 956, 3824
func957  IMPL_QITHUNK 957, 3828
func958  IMPL_QITHUNK 958, 3832
func959  IMPL_QITHUNK 959, 3836
func960  IMPL_QITHUNK 960, 3840
func961  IMPL_QITHUNK 961, 3844
func962  IMPL_QITHUNK 962, 3848
func963  IMPL_QITHUNK 963, 3852
func964  IMPL_QITHUNK 964, 3856
func965  IMPL_QITHUNK 965, 3860
func966  IMPL_QITHUNK 966, 3864
func967  IMPL_QITHUNK 967, 3868
func968  IMPL_QITHUNK 968, 3872
func969  IMPL_QITHUNK 969, 3876
func970  IMPL_QITHUNK 970, 3880
func971  IMPL_QITHUNK 971, 3884
func972  IMPL_QITHUNK 972, 3888
func973  IMPL_QITHUNK 973, 3892
func974  IMPL_QITHUNK 974, 3896
func975  IMPL_QITHUNK 975, 3900
func976  IMPL_QITHUNK 976, 3904
func977  IMPL_QITHUNK 977, 3908
func978  IMPL_QITHUNK 978, 3912
func979  IMPL_QITHUNK 979, 3916
func980  IMPL_QITHUNK 980, 3920
func981  IMPL_QITHUNK 981, 3924
func982  IMPL_QITHUNK 982, 3928
func983  IMPL_QITHUNK 983, 3932
func984  IMPL_QITHUNK 984, 3936
func985  IMPL_QITHUNK 985, 3940
func986  IMPL_QITHUNK 986, 3944
func987  IMPL_QITHUNK 987, 3948
func988  IMPL_QITHUNK 988, 3952
func989  IMPL_QITHUNK 989, 3956
func990  IMPL_QITHUNK 990, 3960
func991  IMPL_QITHUNK 991, 3964
func992  IMPL_QITHUNK 992, 3968
func993  IMPL_QITHUNK 993, 3972
func994  IMPL_QITHUNK 994, 3976
func995  IMPL_QITHUNK 995, 3980
func996  IMPL_QITHUNK 996, 3984
func997  IMPL_QITHUNK 997, 3988
func998  IMPL_QITHUNK 998, 3992
func999  IMPL_QITHUNK 999, 3996

func1000  IMPL_QITHUNK 1000, 4000
func1001  IMPL_QITHUNK 1001, 4004
func1002  IMPL_QITHUNK 1002, 4008
func1003  IMPL_QITHUNK 1003, 4012
func1004  IMPL_QITHUNK 1004, 4016
func1005  IMPL_QITHUNK 1005, 4020
func1006  IMPL_QITHUNK 1006, 4024
func1007  IMPL_QITHUNK 1007, 4028
func1008  IMPL_QITHUNK 1008, 4032
func1009  IMPL_QITHUNK 1009, 4036
func1010  IMPL_QITHUNK 1010, 4040
func1011  IMPL_QITHUNK 1011, 4044
func1012  IMPL_QITHUNK 1012, 4048
func1013  IMPL_QITHUNK 1013, 4052
func1014  IMPL_QITHUNK 1014, 4056
func1015  IMPL_QITHUNK 1015, 4060
func1016  IMPL_QITHUNK 1016, 4064
func1017  IMPL_QITHUNK 1017, 4068
func1018  IMPL_QITHUNK 1018, 4072
func1019  IMPL_QITHUNK 1019, 4076
func1020  IMPL_QITHUNK 1020, 4080
func1021  IMPL_QITHUNK 1021, 4084
func1022  IMPL_QITHUNK 1022, 4088
func1023  IMPL_QITHUNK 1023, 4092
    END
