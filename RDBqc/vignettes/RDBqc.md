---
title: "RDBqc: Quality checks on RDBFIS data formats" 
author: "Walter Zupa"
date: "2022-11-11"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteEngine{knitr::knitr}
  %\VignetteIndexEntry{RDBqc: Quality checks on RDBFIS data formats}
  %\usepackage[UTF-8]{inputenc}
---




RDBqc allows to carry out a set of _a priori_ quality checks on detailed sampling data and on aggregated landing data, and _a posteriori_ quality check on MEDBS, FDI and GFCM data call formats.

The supported quality checks in version 0.0.13 are:

### _A priori_ quality checks
* RCG CS - biological sampling data
* RCG CL - aggregated landing data

### _A posteriori_ quality checks
* MEDBS - catch data
* MEDBS - discard data
* MEDBS - landing data
* MEDBS - GP table
* MEDBS - LW table
* MEDBS - MA table
* MEDBS - ML table
* MEDBS - SA table
* MEDBS - SL table
* FDI tables (A, G, H, I and J)
* GFCM - Task II.2 table
* GFCM - Task III table
* GFCM - Task VII.2 table
* GFCM - Task VII.3.1 table
* GFCM - Task VII.3.2 table

# Checks on RCG

Example of Regional Coordination Group Mediterranean & Black Sea data formats:

**CS table**


```r
head(data_ex)
#>   Sampling_type Flag_country Year  Trip_code Harbour
#> 1             S          ITA 2016 01_18_2016   ITMOL
#> 2             S          ITA 2016 01_18_2016   ITMOL
#> 3             S          ITA 2016 01_18_2016   ITMOL
#> 4             S          ITA 2016 01_18_2016   ITMOL
#> 5             S          ITA 2016 01_18_2016   ITMOL
#> 6             S          ITA 2016 01_18_2016   ITMOL
#>   Number_of_sets_hauls_on_trip Days_at_sea Sampling_method Aggregation_level
#> 1                            4           1    SelfSampling              TRUE
#> 2                            4           1    SelfSampling              TRUE
#> 3                            4           1    SelfSampling              TRUE
#> 4                            4           1    SelfSampling              TRUE
#> 5                            4           1    SelfSampling              TRUE
#> 6                            4           1    SelfSampling              TRUE
#>   Station_number Duration_of_fishing_operation Initial_latitude
#> 1            999                           960         42.04033
#> 2            999                           960         42.04033
#> 3            999                           960         42.04033
#> 4            999                           960         42.04033
#> 5            999                           960         42.04033
#> 6            999                           960         42.04033
#>   Initial_longitude Final_latitude Final_longitude Depth_of_fishing_operation
#> 1          18.48217       42.09067        18.48483                        113
#> 2          18.48217       42.09067        18.48483                        113
#> 3          18.48217       42.09067        18.48483                        113
#> 4          18.48217       42.09067        18.48483                        113
#> 5          18.48217       42.09067        18.48483                        113
#> 6          18.48217       42.09067        18.48483                        113
#>   Water_depth Catch_registration Species_registration       Date  Area
#> 1          NA                Lan                  All 18/02/2016 GSA99
#> 2          NA                Lan                  All 18/02/2016 GSA99
#> 3          NA                Lan                  All 18/02/2016 GSA99
#> 4          NA                Lan                  All 18/02/2016 GSA99
#> 5          NA                Lan                  All 18/02/2016 GSA99
#> 6          NA                Lan                  All 18/02/2016 GSA99
#>   Fishing_activity_category_National Fishing_activity_category_European_lvl_6
#> 1                          OTB_shelf                         OTB_DEF_>=40_0_0
#> 2                          OTB_shelf                         OTB_DEF_>=40_0_0
#> 3                          OTB_shelf                         OTB_DEF_>=40_0_0
#> 4                          OTB_shelf                         OTB_DEF_>=40_0_0
#> 5                          OTB_shelf                         OTB_DEF_>=40_0_0
#> 6                          OTB_shelf                         OTB_DEF_>=40_0_0
#>           Species Catch_category Weight Subsample_weight Sex Maturity_method
#> 1 Mullus barbatus            Lan  18000             6000   F            Macr
#> 2 Mullus barbatus            Lan  18000             6000   F            Macr
#> 3 Mullus barbatus            Lan  18000             6000   F            Macr
#> 4 Mullus barbatus            Lan  18000             6000   F            Macr
#> 5 Mullus barbatus            Lan  18000             6000   F            Macr
#> 6 Mullus barbatus            Lan  18000             6000   F            Macr
#>   Maturity_scale Maturity_Stage Ageing.method Age Length_code Length_class
#> 1   Medits scale             2b           OWR  NA         scm          500
#> 2   Medits scale             2b           OWR  NA         scm          170
#> 3   Medits scale             2b           OWR  NA         scm          175
#> 4   Medits scale             2b           OWR  NA         scm          180
#> 5   Medits scale             2c           OWR  NA         scm          180
#> 6   Medits scale             2b           OWR  10         scm          185
#>   Number_at_length Commercial_size_category_scale Commercial_size_category
#> 1                2                            ITA                        1
#> 2                1                            ITA                        1
#> 3                7                            ITA                        1
#> 4               10                            ITA                        1
#> 5                2                            ITA                        1
#> 6                2                            ITA                        1
#>   fish_ID Individual_weight
#> 1      NA        1424.34463
#> 2      NA          49.41020
#> 3      NA          34.40999
#> 4      NA          49.40479
#> 5      NA          97.93418
#> 6      NA          74.61447
```

**CL table**


```r
head(data_exampleCL)
#>   landCtry vslFlgCtry year quarter month  area rect subRect
#> 1       NA   COUNTRY1 1900       1     1 GSA99   NA      NA
#> 2       NA   COUNTRY1 1900       1     2 GSA99   NA      NA
#> 3       NA   COUNTRY1 1900       1     3 GSA99   NA      NA
#> 4       NA   COUNTRY1 1900       2     4 GSA99   NA      NA
#> 5       NA   COUNTRY1 1900       2     5 GSA99   NA      NA
#> 6       NA   COUNTRY1 1900       2     6 GSA99   NA      NA
#>                      taxon landCat commCatScl commCat  foCatNat foCatEu5
#> 1 Parapenaeus longirostris      NA         NA      NA OTB_shelf       NA
#> 2 Parapenaeus longirostris      NA         NA      NA OTB_shelf       NA
#> 3 Parapenaeus longirostris      NA         NA      NA OTB_shelf       NA
#> 4 Parapenaeus longirostris      NA         NA      NA OTB_shelf       NA
#> 5 Parapenaeus longirostris      NA         NA      NA OTB_shelf       NA
#> 6 Parapenaeus longirostris      NA         NA      NA OTB_shelf       NA
#>           foCatEu6 harbour vslLenCat unallocCatchWt misRepCatchWt    landWt
#> 1 OTB_DEF_>=40_0_0    Port        NA             NA            NA  73452.53
#> 2 OTB_DEF_>=40_0_0    Port        NA             NA            NA  78741.52
#> 3 OTB_DEF_>=40_0_0    Port        NA             NA            NA  82021.10
#> 4 OTB_DEF_>=40_0_0    Port        NA             NA            NA  89022.59
#> 5 OTB_DEF_>=40_0_0    Port        NA             NA            NA 103911.92
#> 6 OTB_DEF_>=40_0_0    Port        NA             NA            NA 102987.30
#>   landMult landValue
#> 1       NA  372658.8
#> 2       NA  392665.2
#> 3       NA  460280.8
#> 4       NA  433524.2
#> 5       NA  494103.4
#> 6       NA  498298.8
```

## Checks on CS

### check LFD

This function `RCG_check_LFD` returns an empty data frame if all the lengths collected are within the length range min_len-max_len; if some lengths are outside this range, the corresponding records are returned as a data frame.


```r
RCG_check_LFD(data_ex,MS="ITA",GSA="GSA99", SP="Mullus barbatus",min_len=6,max_len=250)[[1]]
#>      Flag_country Year  Trip_code       Date  Area Commercial_size_category Age
#> 1             ITA 2016 01_18_2016 18/02/2016 GSA99                        1  NA
#> 5544          ITA 2014  4_18_2014 04/07/2014 GSA99                        1   7
#>      Sex Length_class fish_ID
#> 1      F          500      NA
#> 5544   F          270      NA
```

A plot of the frequency distribution is also returned:


```r
RCG_check_LFD(data_ex,MS="ITA",GSA="GSA99", SP="Mullus barbatus",min_len=6,max_len=250)[[2]]
```

![plot of chunk RCG_check_LFD2](figure/RCG_check_LFD2-1.png)

### check LFD by commercial categories

This function `RCG_check_LFD_comm_cat` reports for each year and commercial category the minimum and maximum lengths in the dataset.


```r
RCG_check_LFD_comm_cat(data_ex,MS="ITA",GSA="GSA99", SP="Mullus barbatus")[[1]]
#>    Year Commercial_size_category Min Max
#> 1  2014                        1  75 270
#> 2  2014                        2  60 205
#> 3  2014                        3  65 155
#> 4  2014                        S  50 130
#> 5  2015                        1  75 250
#> 6  2015                        2  45 195
#> 7  2015                        3  80 175
#> 8  2015                        S  45 140
#> 9  2016                        1  50 500
#> 10 2016                        2  70 190
#> 11 2016                        3  80 155
#> 12 2016                        S  50 130
#> 13 2017                        1  80 225
#> 14 2017                        2  70 205
#> 15 2017                        3  65 150
#> 16 2017                        S  55 130
```

A plot of the length distributions by year and commercial category is also returned:


```r
RCG_check_LFD_comm_cat(data_ex,MS="ITA",GSA="GSA99", SP="Mullus barbatus")[[2]]
```

![plot of chunk RCG_check_LFD_comm_cat2](figure/RCG_check_LFD_comm_cat2-1.png)

### Check AL 

This function `RCG_check_AL` reports for each year and length class the number of age measurements in the dataset, providing a summary data frame. 


```r
results <- RCG_check_AL(data_ex,MS="ITA",GSA="GSA99",SP="Mullus barbatus",min_age=0,max_age=5)[[1]]
#> NA included in the 'Age' field have been removed from the analysis.
head(results)
#>   Year Length_class nb_age_measurements
#> 1 2014           50                   1
#> 2 2014           60                  11
#> 3 2014           65                  20
#> 4 2014           70                  20
#> 5 2014           75                  18
#> 6 2014           80                  18
```

Moreover, the function detects if the age data are in the range min_age-max_age, reporting the list of the trip codes including outliers. 


```r
RCG_check_AL(data_ex,MS="ITA",GSA="GSA99",SP="Mullus barbatus",min_age=0,max_age=5)[[2]]
#> NA included in the 'Age' field have been removed from the analysis.
#>      Flag_country Year  Trip_code       Date  Area Commercial_size_category
#> 6             ITA 2016 01_18_2016 18/02/2016 GSA99                        1
#> 25            ITA 2016 01_18_2016 18/02/2016 GSA99                        1
#> 75            ITA 2016 02_18_2016 21/03/2016 GSA99                        1
#> 78            ITA 2016 02_18_2016 21/03/2016 GSA99                        1
#> 394           ITA 2015 05_18_2015 22/04/2015 GSA99                        1
#> 396           ITA 2015 05_18_2015 22/04/2015 GSA99                        1
#> 397           ITA 2015 05_18_2015 22/04/2015 GSA99                        1
#> 529           ITA 2016 07_18_2016 17/03/2016 GSA99                        1
#> 705           ITA 2016 08_18_2016 29/03/2016 GSA99                        1
#> 2455          ITA 2015 12_18_2015 24/05/2015 GSA99                        1
#> 4267          ITA 2014 17_18_2014 08/08/2014 GSA99                        1
#> 4269          ITA 2014 17_18_2014 08/08/2014 GSA99                        1
#> 5210          ITA 2017 31_18_2017 11/05/2017 GSA99                        1
#> 5399          ITA 2016 34_18_2016 20/06/2016 GSA99                        1
#> 5544          ITA 2014  4_18_2014 04/07/2014 GSA99                        1
#> 6786          ITA 2017 57_18_2017 24/05/2017 GSA99                        1
#> 7129          ITA 2017 66_18_2017 29/05/2017 GSA99                        1
#>       Age Sex Length_class fish_ID
#> 6    10.0   F          185      NA
#> 25    5.5   F          230      NA
#> 75    5.5   F          220      NA
#> 78    5.5   F          235      NA
#> 394   5.5   F          225      NA
#> 396   5.5   F          235      NA
#> 397   5.5   F          250      NA
#> 529   5.5   F          235      NA
#> 705   5.5   F          235      NA
#> 2455  5.5   F          245      NA
#> 4267  6.0   F          225      NA
#> 4269  6.0   F          245      NA
#> 5210  5.5   F          210      NA
#> 5399  5.5   F          235      NA
#> 5544  7.0   F          270      NA
#> 6786  5.5   F          210      NA
#> 7129  5.5   F          225      NA
```

A plot of the age/length relationship by sex and year is outputted for the selected species


```r
RCG_check_AL(data_ex,MS="ITA",GSA="GSA99",SP="Mullus barbatus",min_age=0,max_age=5)[[3]]
#> NA included in the 'Age' field have been removed from the analysis.
```

![plot of chunk RCG_check_AL3](figure/RCG_check_AL3-1.png)

### Check lw 

This function `RCG_check_lw` plots for each year and sex the length-weight scatter plot


```r
RCG_check_lw(data_ex,MS="ITA",GSA="GSA99", SP="Mullus barbatus",Min=0,Max=200)[[2]]
```

![plot of chunk RCG_check_lw2](figure/RCG_check_lw2-1.png)

Furthermore, it checks if the weight data are within the boundaries in input, providing the data frame of the records with the outliers


```r
RCG_check_lw(data_ex,MS="ITA",GSA="GSA99", SP="Mullus barbatus",Min=0,Max=200)[[1]]
#>      Flag_country Year  Trip_code       Date  Area Commercial_size_category Age
#> 1             ITA 2016 01_18_2016 18/02/2016 GSA99                        1  NA
#> 77            ITA 2016 02_18_2016 21/03/2016 GSA99                        1 4.5
#> 2430          ITA 2014 12_18_2014 24/07/2014 GSA99                        1 5.0
#> 5544          ITA 2014  4_18_2014 04/07/2014 GSA99                        1 7.0
#> 5777          ITA 2015 43_18_2015 31/07/2015 GSA99                        1 4.0
#> 7946          ITA 2014 87_18_2014 05/12/2014 GSA99                        1 4.0
#> 7949          ITA 2014 87_18_2014 05/12/2014 GSA99                        1 5.0
#>      Sex Length_class fish_ID
#> 1      F          500      NA
#> 77     F          225      NA
#> 2430   F          220      NA
#> 5544   F          270      NA
#> 5777   F          205      NA
#> 7946   F          215      NA
#> 7949   F          245      NA
```

### check maturity stages 

This function `RCG_check_mat` plots for each year and sex the length-maturity stage scatter plot


```r
RCG_check_mat(data_ex,MS="ITA",GSA="GSA99",SP="Mullus barbatus")
```

![plot of chunk RCG_check_mat](figure/RCG_check_mat-1.png)

### check matutity ogive

This function `RCG_check_mat_ogive` plots the maturity ogive by sex derived from the dataset:


```r
RCG_check_mat_ogive(data_ex,MS="ITA",GSA="GSA99",SP="Mullus barbatus", sex="F",immature_stages=c("0","1","2a"))
```

![plot of chunk RCG_check_mat_ogive](figure/RCG_check_mat_ogive-1.png)
 
### Summarize individual measurements

This function `RCG_summarize_ind_meas` reports for each trip the number of length sex, maturity, individual weight and age measurements for a selected species. 


```r
results <- RCG_summarize_ind_meas(data=data_ex,MS="ITA",GSA="GSA99",SP="Mullus barbatus")
head(results)
#>   Year  Area         Species  Trip_code age_data length_measurements
#> 1 2014 GSA99 Mullus barbatus 12_18_2014       54                 120
#> 2 2014 GSA99 Mullus barbatus 14_18_2014       52                 163
#> 3 2014 GSA99 Mullus barbatus 15_18_2014       68                 252
#> 4 2014 GSA99 Mullus barbatus 17_18_2014       27                 239
#> 5 2014 GSA99 Mullus barbatus 19_18_2014       84                1657
#> 6 2014 GSA99 Mullus barbatus 20_18_2014       32                 752
#>   maturity_data sex_data weight_data
#> 1           120      120         120
#> 2           163      163         163
#> 3           252      252         252
#> 4           239      239         239
#> 5          1657     1657        1657
#> 6           752      752         752
```

### Summarize trips

This function `RCG_summarize_trips` reports for the selected species the number of trips in the dataset for each year, area, harbour, metier and sampling method. 


```r
results <- RCG_summarize_trips(data_ex,MS="ITA",GSA="GSA99",SP="Mullus barbatus")
head(results)
#>   Year Flag_country  Area Harbour         Species
#> 1 2014          ITA GSA99   ITBCE Mullus barbatus
#> 2 2014          ITA GSA99   ITBDS Mullus barbatus
#> 3 2014          ITA GSA99   ITBDS Mullus barbatus
#> 4 2014          ITA GSA99   ITMFR Mullus barbatus
#> 5 2014          ITA GSA99   ITMFR Mullus barbatus
#> 6 2014          ITA GSA99   ITMNP Mullus barbatus
#>   Fishing_activity_category_European_lvl_6 Sampling_method Nb_trips
#> 1                         OTB_DEF_>=40_0_0        Observer        2
#> 2                         OTB_DEF_>=40_0_0        Observer        2
#> 3                         OTB_DEF_>=40_0_0    SelfSampling        2
#> 4                         OTB_DEF_>=40_0_0        Observer        1
#> 5                         OTB_DEF_>=40_0_0    SelfSampling        7
#> 6                         OTB_DEF_>=40_0_0        Observer        2
```

### Check trips location

The function `RCG_check_loc` allows to check the spatial distribution of data using the initial and final coordinates, where available, and the ports position included in the data.


```r
RCG_check_loc(data_ex)
#> Regions defined for each Polygons
```

![plot of chunk RCG_check_loc](figure/RCG_check_loc-1.png)

## Checks on CL

This function `RCG_check_CL` allows to check the data in the CL table for the selected species. The output is a list of 6 data frames:

1. Sum of Landings by year, quarter and month;


```r
RCG_check_CL(data_exampleCL,MS="COUNTRY1",GSA="GSA99",SP="Parapenaeus longirostris")[[1]]
#>    Year Quarter Month Sum_Landings
#> 1  1900       1     1     80553.10
#> 2  1900       1     2     80519.05
#> 3  1900       1     3     85107.68
#> 4  1900       2     4     90093.59
#> 5  1900       2     5    110096.34
#> 6  1900       2     6    117515.89
#> 7  1900       3     7     98584.85
#> 8  1900       3     8     49500.43
#> 9  1900       3     9     32084.59
#> 10 1900       4    10    153080.70
#> 11 1900       4    11    123574.70
#> 12 1900       4    12     99743.72
```

2. Sum of Landing value by year, quarter and month;


```r
RCG_check_CL(data_exampleCL,MS="COUNTRY1",GSA="GSA99",SP="Parapenaeus longirostris")[[2]]
#>    Year Quarter Month Sum_LandingsValue
#> 1  1900       1     1          410296.6
#> 2  1900       1     2          400928.4
#> 3  1900       1     3          476691.5
#> 4  1900       2     4          438991.9
#> 5  1900       2     5          521380.8
#> 6  1900       2     6          571712.2
#> 7  1900       3     7          518606.2
#> 8  1900       3     8          308576.7
#> 9  1900       3     9          161772.9
#> 10 1900       4    10          609361.4
#> 11 1900       4    11          576900.8
#> 12 1900       4    12          601217.8
```

3. Sum of landings by LandCtry, VslFlgCtry,  Area, Rect, SubRect, Harbour;


```r
RCG_check_CL(data_exampleCL,MS="COUNTRY1",GSA="GSA99",SP="Parapenaeus longirostris")[[3]]
#>   LandCtry VslFlgCtry  Area Rect SubRect Harbour Sum_Landings
#> 1       NA   COUNTRY1 GSA99   NA      NA    Port      1120455
```

4. Sum of landing value by LandCtry, VslFlgCtry,  Area, Rect, SubRect, Harbour;


```r
RCG_check_CL(data_exampleCL,MS="COUNTRY1",GSA="GSA99",SP="Parapenaeus longirostris")[[4]]
#>   LandCtry VslFlgCtry  Area Rect SubRect Harbour Sum_LandingsValue
#> 1       NA   COUNTRY1 GSA99   NA      NA    Port           5596437
```

5. Sum of landings by Year, Species, foCatEu5, foCatEu6;


```r
RCG_check_CL(data_exampleCL,MS="COUNTRY1",GSA="GSA99",SP="Parapenaeus longirostris")[[5]]
#>   Year                  Species foCatEu5         foCatEu6 Sum_Landings
#> 1 1900 Parapenaeus longirostris       NA OTB_DEF_>=40_0_0  1018083.081
#> 2 1900 Parapenaeus longirostris       NA OTB_DWS_>=40_0_0     1453.471
#> 3 1900 Parapenaeus longirostris       NA OTB_MDD_>=40_0_0   100918.089
```

6. Sum of landing value by Year, Species, foCatEu5, foCatEu6.


```r
RCG_check_CL(data_exampleCL,MS="COUNTRY1",GSA="GSA99",SP="Parapenaeus longirostris")[[6]]
#>   Year                  Species foCatEu5         foCatEu6 Sum_LandingsValue
#> 1 1900 Parapenaeus longirostris       NA OTB_DEF_>=40_0_0       5050728.907
#> 2 1900 Parapenaeus longirostris       NA OTB_DWS_>=40_0_0          7721.884
#> 3 1900 Parapenaeus longirostris       NA OTB_MDD_>=40_0_0        537986.519
```

7. Plot of the landings by year and foCatEu6


```r
RCG_check_CL(data_exampleCL,MS="COUNTRY1",GSA="GSA99",SP="Parapenaeus longirostris")[[7]]
#> geom_path: Each group consists of only one observation. Do you need to adjust
#> the group aesthetic?
```

![plot of chunk RCG_check_CL7](figure/RCG_check_CL7-1.png)

# Checks on MEDBS tables

_catch table_


```r
head(Catch_tab_example)
#>                              id country year quarter vessel_length gear
#> 1       ITA 2008-1GNS-1DEMFSA 9     ITA 2008      -1            -1  GNS
#> 2   ITA 2010-1OTB50D100DWSPSA 9     ITA 2010      -1            -1  OTB
#> 3   ITA 2014-1OTB50D100DWSPSA 9     ITA 2014      -1            -1  OTB
#> 4  ITA 2008-1OTB50D100DEMSPSA 9     ITA 2008      -1            -1  OTB
#> 5 ITA 2008-1OTB50D100MDDWSPSA 9     ITA 2008      -1            -1  OTB
#> 6  ITA 2007-1OTB50D100DEMSPSA 9     ITA 2007      -1            -1  OTB
#>   mesh_size_range fishery  area specon species  landings discards
#> 1              -1    DEMF GSA 9     -1     DPS   0.50829       -1
#> 2          50D100    DWSP GSA 9     -1     DPS   9.69116       -1
#> 3          50D100    DWSP GSA 9     -1     DPS   2.11283       -1
#> 4          50D100   DEMSP GSA 9     -1     DPS 187.26219       -1
#> 5          50D100  MDDWSP GSA 9     -1     DPS  66.06531       -1
#> 6          50D100   DEMSP GSA 9     -1     DPS  89.84975       -1
#>   no_samples_landings no_length_measurements_landings
#> 1                  30                               0
#> 2                   6                               0
#> 3                   2                               0
#> 4                  67                            3038
#> 5                  12                            1461
#> 6                  50                            2452
#>   no_age_measurements_landings no_samples_discards
#> 1                            0                   0
#> 2                            0                   0
#> 3                            0                   0
#> 4                            0                   0
#> 5                            0                   0
#> 6                            0                   0
#>   no_length_measurements_discards no_age_measurements_discards no_samples_catch
#> 1                              -1                           -1               -1
#> 2                              -1                           -1               -1
#> 3                              -1                           -1               -1
#> 4                              -1                           -1               -1
#> 5                              -1                           -1               -1
#> 6                              -1                           -1               -1
#>   no_length_measurements_catch no_age_measurements_catch min_age max_age age_0
#> 1                           -1                        -1      -1      -1     0
#> 2                           -1                        -1      -1      -1     0
#> 3                           -1                        -1      -1      -1     0
#> 4                           -1                        -1       0       4     0
#> 5                           -1                        -1       0       4     0
#> 6                           -1                        -1       0       4     0
#>   age_0_no_landed age_0_mean_weight_landed age_0_mean_length_landed
#> 1           0.000                    0.000                     0.00
#> 2           0.000                    0.000                     0.00
#> 3           0.000                    0.000                     0.00
#> 4        8859.650                    0.005                     1.97
#> 5         489.758                    0.006                     2.02
#> 6        1430.784                    0.006                     2.06
#>   age_0_no_discard age_0_mean_weight_discard age_0_mean_length_discard age_1
#> 1               -1                        -1                        -1     1
#> 2               -1                        -1                        -1     1
#> 3               -1                        -1                        -1     1
#> 4               -1                        -1                         0     1
#> 5               -1                        -1                         0     1
#> 6               -1                        -1                         0     1
#>   age_1_no_landed age_1_mean_weight_landed age_1_mean_length_landed
#> 1           0.000                    0.000                     0.00
#> 2           0.000                    0.000                     0.00
#> 3           0.000                    0.000                     0.00
#> 4        8431.094                    0.012                     2.68
#> 5        2721.682                    0.013                     2.80
#> 6        4638.951                    0.013                     2.77
#>   age_1_no_discard age_1_mean_weight_discard age_1_mean_length_discard age_2
#> 1               -1                        -1                        -1     2
#> 2               -1                        -1                        -1     2
#> 3               -1                        -1                        -1     2
#> 4               -1                        -1                         0     2
#> 5               -1                        -1                         0     2
#> 6               -1                        -1                         0     2
#>   age_2_no_landed age_2_mean_weight_landed age_2_mean_length_landed
#> 1           0.000                    0.000                     0.00
#> 2           0.000                    0.000                     0.00
#> 3           0.000                    0.000                     0.00
#> 4        1395.641                    0.020                     3.28
#> 5         638.159                    0.020                     3.31
#> 6         935.121                    0.021                     3.35
#>   age_2_no_discard age_2_mean_weight_discard age_2_mean_length_discard age_3
#> 1               -1                        -1                        -1     3
#> 2               -1                        -1                        -1     3
#> 3               -1                        -1                        -1     3
#> 4               -1                        -1                         0     3
#> 5               -1                        -1                         0     3
#> 6               -1                        -1                         0     3
#>   age_3_no_landed age_3_mean_weight_landed age_3_mean_length_landed
#> 1           0.000                    0.000                     0.00
#> 2           0.000                    0.000                     0.00
#> 3           0.000                    0.000                     0.00
#> 4         213.802                    0.024                     3.54
#> 5         197.337                    0.026                     3.63
#> 6          64.480                    0.022                     3.39
#>   age_3_no_discard age_3_mean_weight_discard age_3_mean_length_discard age_4
#> 1               -1                        -1                        -1     4
#> 2               -1                        -1                        -1     4
#> 3               -1                        -1                        -1     4
#> 4               -1                        -1                         0     4
#> 5               -1                        -1                         0     4
#> 6               -1                        -1                         0     4
#>   age_4_no_landed age_4_mean_weight_landed age_4_mean_length_landed
#> 1           0.000                    0.000                     0.00
#> 2           0.000                    0.000                     0.00
#> 3           0.000                    0.000                     0.00
#> 4         414.040                    0.023                     3.50
#> 5         388.771                    0.024                     3.55
#> 6          29.945                    0.023                     3.49
#>   age_4_no_discard age_4_mean_weight_discard age_4_mean_length_discard age_5
#> 1               -1                        -1                        -1     5
#> 2               -1                        -1                        -1     5
#> 3               -1                        -1                        -1     5
#> 4               -1                        -1                         0     5
#> 5               -1                        -1                         0     5
#> 6               -1                        -1                         0     5
#>   age_5_no_landed age_5_mean_weight_landed age_5_mean_length_landed
#> 1               0                        0                        0
#> 2               0                        0                        0
#> 3               0                        0                        0
#> 4               0                        0                        0
#> 5               0                        0                        0
#> 6               0                        0                        0
#>   age_5_no_discard age_5_mean_weight_discard age_5_mean_length_discard age_6
#> 1               -1                        -1                        -1     6
#> 2               -1                        -1                        -1     6
#> 3               -1                        -1                        -1     6
#> 4               -1                        -1                         0     6
#> 5               -1                        -1                         0     6
#> 6               -1                        -1                         0     6
#>   age_6_no_landed age_6_mean_weight_landed age_6_mean_length_landed
#> 1               0                        0                        0
#> 2               0                        0                        0
#> 3               0                        0                        0
#> 4               0                        0                        0
#> 5               0                        0                        0
#> 6               0                        0                        0
#>   age_6_no_discard age_6_mean_weight_discard age_6_mean_length_discard age_7
#> 1               -1                        -1                        -1     7
#> 2               -1                        -1                        -1     7
#> 3               -1                        -1                        -1     7
#> 4               -1                        -1                         0     7
#> 5               -1                        -1                         0     7
#> 6               -1                        -1                         0     7
#>   age_7_no_landed age_7_mean_weight_landed age_7_mean_length_landed
#> 1               0                        0                        0
#> 2               0                        0                        0
#> 3               0                        0                        0
#> 4               0                        0                        0
#> 5               0                        0                        0
#> 6               0                        0                        0
#>   age_7_no_discard age_7_mean_weight_discard age_7_mean_length_discard age_8
#> 1               -1                        -1                        -1     8
#> 2               -1                        -1                        -1     8
#> 3               -1                        -1                        -1     8
#> 4               -1                        -1                         0     8
#> 5               -1                        -1                         0     8
#> 6               -1                        -1                         0     8
#>   age_8_no_landed age_8_mean_weight_landed age_8_mean_length_landed
#> 1               0                        0                        0
#> 2               0                        0                        0
#> 3               0                        0                        0
#> 4               0                        0                        0
#> 5               0                        0                        0
#> 6               0                        0                        0
#>   age_8_no_discard age_8_mean_weight_discard age_8_mean_length_discard age_9
#> 1               -1                        -1                        -1     9
#> 2               -1                        -1                        -1     9
#> 3               -1                        -1                        -1     9
#> 4               -1                        -1                         0     9
#> 5               -1                        -1                         0     9
#> 6               -1                        -1                         0     9
#>   age_9_no_landed age_9_mean_weight_landed age_9_mean_length_landed
#> 1               0                        0                        0
#> 2               0                        0                        0
#> 3               0                        0                        0
#> 4               0                        0                        0
#> 5               0                        0                        0
#> 6               0                        0                        0
#>   age_9_no_discard age_9_mean_weight_discard age_9_mean_length_discard age_10
#> 1               -1                        -1                        -1     10
#> 2               -1                        -1                        -1     10
#> 3               -1                        -1                        -1     10
#> 4               -1                        -1                         0     10
#> 5               -1                        -1                         0     10
#> 6               -1                        -1                         0     10
#>   age_10_no_landed age_10_mean_weight_landed age_10_mean_length_landed
#> 1                0                         0                         0
#> 2                0                         0                         0
#> 3                0                         0                         0
#> 4                0                         0                         0
#> 5                0                         0                         0
#> 6                0                         0                         0
#>   age_10_no_discard age_10_mean_weight_discard age_10_mean_length_discard
#> 1                -1                         -1                         -1
#> 2                -1                         -1                         -1
#> 3                -1                         -1                         -1
#> 4                -1                         -1                          0
#> 5                -1                         -1                          0
#> 6                -1                         -1                          0
#>   age_11 age_11_no_landed age_11_mean_weight_landed age_11_mean_length_landed
#> 1     11                0                         0                         0
#> 2     11                0                         0                         0
#> 3     11                0                         0                         0
#> 4     11                0                         0                         0
#> 5     11                0                         0                         0
#> 6     11                0                         0                         0
#>   age_11_no_discard age_11_mean_weight_discard age_11_mean_length_discard
#> 1                -1                         -1                         -1
#> 2                -1                         -1                         -1
#> 3                -1                         -1                         -1
#> 4                -1                         -1                          0
#> 5                -1                         -1                          0
#> 6                -1                         -1                          0
#>   age_12 age_12_no_landed age_12_mean_weight_landed age_12_mean_length_landed
#> 1     12                0                         0                         0
#> 2     12                0                         0                         0
#> 3     12                0                         0                         0
#> 4     12                0                         0                         0
#> 5     12                0                         0                         0
#> 6     12                0                         0                         0
#>   age_12_no_discard age_12_mean_weight_discard age_12_mean_length_discard
#> 1                -1                         -1                         -1
#> 2                -1                         -1                         -1
#> 3                -1                         -1                         -1
#> 4                -1                         -1                          0
#> 5                -1                         -1                          0
#> 6                -1                         -1                          0
#>   age_13 age_13_no_landed age_13_mean_weight_landed age_13_mean_length_landed
#> 1     13                0                         0                         0
#> 2     13                0                         0                         0
#> 3     13                0                         0                         0
#> 4     13                0                         0                         0
#> 5     13                0                         0                         0
#> 6     13                0                         0                         0
#>   age_13_no_discard age_13_mean_weight_discard age_13_mean_length_discard
#> 1                -1                         -1                         -1
#> 2                -1                         -1                         -1
#> 3                -1                         -1                         -1
#> 4                -1                         -1                          0
#> 5                -1                         -1                          0
#> 6                -1                         -1                          0
#>   age_14 age_14_no_landed age_14_mean_weight_landed age_14_mean_length_landed
#> 1     14                0                         0                         0
#> 2     14                0                         0                         0
#> 3     14                0                         0                         0
#> 4     14                0                         0                         0
#> 5     14                0                         0                         0
#> 6     14                0                         0                         0
#>   age_14_no_discard age_14_mean_weight_discard age_14_mean_length_discard
#> 1                -1                         -1                         -1
#> 2                -1                         -1                         -1
#> 3                -1                         -1                         -1
#> 4                -1                         -1                          0
#> 5                -1                         -1                          0
#> 6                -1                         -1                          0
#>   age_15 age_15_no_landed age_15_mean_weight_landed age_15_mean_length_landed
#> 1     15                0                         0                         0
#> 2     15                0                         0                         0
#> 3     15                0                         0                         0
#> 4     15                0                         0                         0
#> 5     15                0                         0                         0
#> 6     15                0                         0                         0
#>   age_15_no_discard age_15_mean_weight_discard age_15_mean_length_discard
#> 1                -1                         -1                         -1
#> 2                -1                         -1                         -1
#> 3                -1                         -1                         -1
#> 4                -1                         -1                          0
#> 5                -1                         -1                          0
#> 6                -1                         -1                          0
#>   age_16 age_16_no_landed age_16_mean_weight_landed age_16_mean_length_landed
#> 1     16                0                         0                         0
#> 2     16                0                         0                         0
#> 3     16                0                         0                         0
#> 4     16                0                         0                         0
#> 5     16                0                         0                         0
#> 6     16                0                         0                         0
#>   age_16_no_discard age_16_mean_weight_discard age_16_mean_length_discard
#> 1                -1                         -1                         -1
#> 2                -1                         -1                         -1
#> 3                -1                         -1                         -1
#> 4                -1                         -1                          0
#> 5                -1                         -1                          0
#> 6                -1                         -1                          0
#>   age_17 age_17_no_landed age_17_mean_weight_landed age_17_mean_length_landed
#> 1     17                0                         0                         0
#> 2     17                0                         0                         0
#> 3     17                0                         0                         0
#> 4     17                0                         0                         0
#> 5     17                0                         0                         0
#> 6     17                0                         0                         0
#>   age_17_no_discard age_17_mean_weight_discard age_17_mean_length_discard
#> 1                -1                         -1                         -1
#> 2                -1                         -1                         -1
#> 3                -1                         -1                         -1
#> 4                -1                         -1                          0
#> 5                -1                         -1                          0
#> 6                -1                         -1                          0
#>   age_18 age_18_no_landed age_18_mean_weight_landed age_18_mean_length_landed
#> 1     18                0                         0                         0
#> 2     18                0                         0                         0
#> 3     18                0                         0                         0
#> 4     18                0                         0                         0
#> 5     18                0                         0                         0
#> 6     18                0                         0                         0
#>   age_18_no_discard age_18_mean_weight_discard age_18_mean_length_discard
#> 1                -1                         -1                         -1
#> 2                -1                         -1                         -1
#> 3                -1                         -1                         -1
#> 4                -1                         -1                          0
#> 5                -1                         -1                          0
#> 6                -1                         -1                          0
#>   age_19 age_19_no_landed age_19_mean_weight_landed age_19_mean_length_landed
#> 1     19                0                         0                         0
#> 2     19                0                         0                         0
#> 3     19                0                         0                         0
#> 4     19                0                         0                         0
#> 5     19                0                         0                         0
#> 6     19                0                         0                         0
#>   age_19_no_discard age_19_mean_weight_discard age_19_mean_length_discard
#> 1                -1                         -1                         -1
#> 2                -1                         -1                         -1
#> 3                -1                         -1                         -1
#> 4                -1                         -1                          0
#> 5                -1                         -1                          0
#> 6                -1                         -1                          0
#>   age_20_plus age_20_plus_no_landed age_20_plus_mean_weight_landed
#> 1          20                     0                              0
#> 2          20                     0                              0
#> 3          20                     0                              0
#> 4          20                     0                              0
#> 5          20                     0                              0
#> 6          20                     0                              0
#>   age_20_plus_mean_length_landed age_20_plus_no_discard
#> 1                              0                     -1
#> 2                              0                     -1
#> 3                              0                     -1
#> 4                              0                     -1
#> 5                              0                     -1
#> 6                              0                     -1
#>   age_20_plus_mean_weight_discard age_20_plus_mean_length_discard
#> 1                              -1                              -1
#> 2                              -1                              -1
#> 3                              -1                              -1
#> 4                              -1                               0
#> 5                              -1                               0
#> 6                              -1                               0
```

_landings table_


```r
head(Landing_tab_example)
#>                             id country year quarter vessel_length gear
#> 1     ITA 2003 1GTR-1DEMSPSA 9     ITA 2003      -1            -1  GTR
#> 2      ITA 2003 1OTB50D100SA 9     ITA 2003      -1            -1  OTB
#> 3      ITA 2004-1GNS-1DEMFSA 9     ITA 2004      -1            -1  GNS
#> 4     ITA 2004-1GTR-1DEMSPSA 9     ITA 2004      -1            -1  GTR
#> 5 ITA 2004-1OTB50D100DEMSPSA 9     ITA 2004      -1            -1  OTB
#> 6     ITA 2005-1GTR-1DEMSPSA 9     ITA 2005      -1            -1  GTR
#>   mesh_size_range fishery  area specon species   landings unit lengthclass0
#> 1              -1   DEMSP GSA 9     -1     DPS   5.933227   mm            0
#> 2          50D100      -1 GSA 9     -1     DPS 316.615971   mm            0
#> 3              -1    DEMF GSA 9     -1     DPS   3.628830   mm            0
#> 4              -1   DEMSP GSA 9     -1     DPS   4.177760   mm            0
#> 5          50D100      -1 GSA 9     -1     DPS 367.431910   mm            0
#> 6              -1   DEMSP GSA 9     -1     DPS   0.517960   mm            0
#>   lengthclass1 lengthclass2 lengthclass3 lengthclass4 lengthclass5 lengthclass6
#> 1            0            0            0            0            0            0
#> 2            0            0            0            0            0            0
#> 3            0            0            0            0            0            0
#> 4            0            0            0            0            0            0
#> 5            0            0            0            0            0            0
#> 6            0            0            0            0            0            0
#>   lengthclass7 lengthclass8 lengthclass9 lengthclass10 lengthclass11
#> 1            0            0            0             0             0
#> 2            0            0            0             0             0
#> 3            0            0            0             0             0
#> 4            0            0            0             0             0
#> 5            0            0            0             0             0
#> 6            0            0            0             0             0
#>   lengthclass12 lengthclass13 lengthclass14 lengthclass15 lengthclass16
#> 1             0             0             0             0             0
#> 2             0             0             0             0             0
#> 3             0             0             0             0             0
#> 4             0             0             0             0             0
#> 5             0             0             0             0             0
#> 6             0             0             0             0             0
#>   lengthclass17 lengthclass18 lengthclass19 lengthclass20 lengthclass21
#> 1             0             0             0             0        0.0000
#> 2             0             0             0             0      370.3284
#> 3             0             0             0             0        0.0000
#> 4             0             0             0             0        0.0000
#> 5             0             0             0             0        0.0000
#> 6             0             0             0             0        0.0000
#>   lengthclass22 lengthclass23 lengthclass24 lengthclass25 lengthclass26
#> 1        0.0000        0.0000        0.0000         0.000        0.0000
#> 2      740.6568      740.6568      740.6568      1110.985      740.6568
#> 3        0.0000        0.0000        0.0000         0.000        0.0000
#> 4        0.0000        0.0000        0.0000         0.000        0.0000
#> 5      317.9662      317.9662      953.8985      1589.831      953.8985
#> 6        0.0000        0.0000        0.0000         0.000        0.0000
#>   lengthclass27 lengthclass28 lengthclass29 lengthclass30 lengthclass31
#> 1        0.0000         0.000         0.000         0.000         0.000
#> 2     1110.9851      1110.985      1481.314      1110.985      1110.985
#> 3        0.0000         0.000         0.000         0.000         0.000
#> 4        0.0000         0.000         0.000         0.000         0.000
#> 5      953.8985      1907.797      1907.797      2543.729      1589.831
#> 6        0.0000         0.000         0.000         0.000         0.000
#>   lengthclass32 lengthclass33 lengthclass34 lengthclass35 lengthclass36
#> 1        0.0000         0.000        0.0000         0.000         0.000
#> 2      370.3284      1110.985      740.6568      1481.314      1110.985
#> 3        0.0000         0.000        0.0000         0.000         0.000
#> 4        0.0000         0.000        0.0000         0.000         0.000
#> 5     1271.8647      1907.797      953.8985      1589.831      1271.865
#> 6        0.0000         0.000        0.0000         0.000         0.000
#>   lengthclass37 lengthclass38 lengthclass39 lengthclass40 lengthclass41
#> 1        0.0000        0.0000        0.0000        0.0000        0.0000
#> 2      740.6568     1110.9851        0.0000      740.6568      740.6568
#> 3        0.0000        0.0000        0.0000        0.0000        0.0000
#> 4        0.0000        0.0000        0.0000        0.0000        0.0000
#> 5      317.9662      953.8985      635.9323      317.9662        0.0000
#> 6        0.0000        0.0000        0.0000        0.0000        0.0000
#>   lengthclass42 lengthclass43 lengthclass44 lengthclass45 lengthclass46
#> 1             0             0             0             0             0
#> 2             0             0             0             0             0
#> 3             0             0             0             0             0
#> 4             0             0             0             0             0
#> 5             0             0             0             0             0
#> 6             0             0             0             0             0
#>   lengthclass47 lengthclass48 lengthclass49 lengthclass50 lengthclass51
#> 1             0             0             0             0             0
#> 2             0             0             0             0             0
#> 3             0             0             0             0             0
#> 4             0             0             0             0             0
#> 5             0             0             0             0             0
#> 6             0             0             0             0             0
#>   lengthclass52 lengthclass53 lengthclass54 lengthclass55 lengthclass56
#> 1             0             0             0             0             0
#> 2             0             0             0             0             0
#> 3             0             0             0             0             0
#> 4             0             0             0             0             0
#> 5             0             0             0             0             0
#> 6             0             0             0             0             0
#>   lengthclass57 lengthclass58 lengthclass59 lengthclass60 lengthclass61
#> 1             0             0             0             0             0
#> 2             0             0             0             0             0
#> 3             0             0             0             0             0
#> 4             0             0             0             0             0
#> 5             0             0             0             0             0
#> 6             0             0             0             0             0
#>   lengthclass62 lengthclass63 lengthclass64 lengthclass65 lengthclass66
#> 1             0             0             0             0             0
#> 2             0             0             0             0             0
#> 3             0             0             0             0             0
#> 4             0             0             0             0             0
#> 5             0             0             0             0             0
#> 6             0             0             0             0             0
#>   lengthclass67 lengthclass68 lengthclass69 lengthclass70 lengthclass71
#> 1             0             0             0             0             0
#> 2             0             0             0             0             0
#> 3             0             0             0             0             0
#> 4             0             0             0             0             0
#> 5             0             0             0             0             0
#> 6             0             0             0             0             0
#>   lengthclass72 lengthclass73 lengthclass74 lengthclass75 lengthclass76
#> 1             0             0             0             0             0
#> 2             0             0             0             0             0
#> 3             0             0             0             0             0
#> 4             0             0             0             0             0
#> 5             0             0             0             0             0
#> 6             0             0             0             0             0
#>   lengthclass77 lengthclass78 lengthclass79 lengthclass80 lengthclass81
#> 1             0             0             0             0             0
#> 2             0             0             0             0             0
#> 3             0             0             0             0             0
#> 4             0             0             0             0             0
#> 5             0             0             0             0             0
#> 6             0             0             0             0             0
#>   lengthclass82 lengthclass83 lengthclass84 lengthclass85 lengthclass86
#> 1             0             0             0             0             0
#> 2             0             0             0             0             0
#> 3             0             0             0             0             0
#> 4             0             0             0             0             0
#> 5             0             0             0             0             0
#> 6             0             0             0             0             0
#>   lengthclass87 lengthclass88 lengthclass89 lengthclass90 lengthclass91
#> 1             0             0             0             0             0
#> 2             0             0             0             0             0
#> 3             0             0             0             0             0
#> 4             0             0             0             0             0
#> 5             0             0             0             0             0
#> 6             0             0             0             0             0
#>   lengthclass92 lengthclass93 lengthclass94 lengthclass95 lengthclass96
#> 1             0             0             0             0             0
#> 2             0             0             0             0             0
#> 3             0             0             0             0             0
#> 4             0             0             0             0             0
#> 5             0             0             0             0             0
#> 6             0             0             0             0             0
#>   lengthclass97 lengthclass98 lengthclass99 lengthclass100_plus
#> 1             0             0             0                   0
#> 2             0             0             0                   0
#> 3             0             0             0                   0
#> 4             0             0             0                   0
#> 5             0             0             0                   0
#> 6             0             0             0                   0
```

_discards table_


```r
head(Discard_tab_example)
#>      id country year quarter vessel_length gear mesh_size_range fishery  area
#> 1 44554     ITA 2009      -1            -1  OTB          50D100   DEMSP GSA 9
#> 2 44571     ITA 2010      -1            -1  OTB          50D100   DEMSP GSA 9
#> 3 44583     ITA 2010      -1            -1  OTB          50D100  MDDWSP GSA 9
#> 4 44593     ITA 2011      -1            -1  OTB          50D100   DEMSP GSA 9
#> 5 44603     ITA 2011      -1            -1  OTB          50D100  MDDWSP GSA 9
#> 6 44612     ITA 2012      -1            -1  OTB          50D100   DEMSP GSA 9
#>   specon species  discards unit lengthclass0 lengthclass1 lengthclass2
#> 1     -1     DPS 38.355420   mm            0            0            0
#> 2     -1     DPS 24.396528   mm            0            0            0
#> 3     -1     DPS  2.703603   mm            0            0            0
#> 4     -1     DPS 60.519315   mm            0            0            0
#> 5     -1     DPS  2.743526   mm            0            0            0
#> 6     -1     DPS  6.571266   mm            0            0            0
#>   lengthclass3 lengthclass4 lengthclass5 lengthclass6 lengthclass7 lengthclass8
#> 1            0            0            0            0      0.00000     74.26968
#> 2            0            0            0            0      0.00000      0.00000
#> 3            0            0            0            0      0.00000      0.00000
#> 4            0            0            0            0     23.41301    331.93787
#> 5            0            0            0            0      0.00000      0.00000
#> 6            0            0            0            0      0.00000      0.00000
#>   lengthclass9 lengthclass10 lengthclass11 lengthclass12 lengthclass13
#> 1    113.43072     442.02312      434.9182      471.1954     752.23604
#> 2    130.45957      80.11084      198.6577      145.7827     176.68910
#> 3      0.00000       0.00000        0.0000        0.0000       0.00000
#> 4   1327.75149     995.81361     4016.2372     4653.3614    5670.98422
#> 5     26.79004      61.23438      109.7116      101.0095      65.06153
#> 6      0.00000       0.00000        0.0000        0.0000       0.00000
#>   lengthclass14 lengthclass15 lengthclass16 lengthclass17 lengthclass18
#> 1   1174.441705   1831.805062   1370.380186    1159.51237    1113.68098
#> 2    283.241041    572.533620    703.764644     670.61857     823.34906
#> 3      3.310774      7.863089      3.310774      15.13318      12.00156
#> 4   5094.996618   1147.629659   2957.577556     976.13109     587.32022
#> 5     73.426166     55.973862     44.260017      35.15468      38.62213
#> 6      0.000000     35.151758     37.336046      22.22715      43.75506
#>   lengthclass19 lengthclass20 lengthclass21 lengthclass22 lengthclass23
#> 1     594.55120     498.71922     212.97009     462.96405    159.640324
#> 2     668.89430     610.65602     232.57380     230.80286    107.478681
#> 3      15.72618      10.34617      49.86152      39.07667     47.871878
#> 4     519.91832     190.70604      54.88637      15.01747     35.314873
#> 5      12.93248      15.66377      11.48145       0.00000      3.647299
#> 6     175.86297      98.13143     222.55692     106.41507     53.043923
#>   lengthclass24 lengthclass25 lengthclass26 lengthclass27 lengthclass28
#> 1    164.862551      92.79238     14.948854     19.931806    122.146589
#> 2    165.664995      90.46759     47.612437     23.733082     30.451867
#> 3     26.653323      32.38000     43.557343     11.587710      6.263249
#> 4     76.952619     331.93787      5.981089     53.379728     12.787659
#> 5      5.102865      18.85079     10.241397      7.869814      3.467449
#> 6     62.295724      26.15134     47.875720     23.355164      1.946264
#>   lengthclass29 lengthclass30 lengthclass31 lengthclass32 lengthclass33
#> 1     20.280591      0.000000      0.000000      4.982951      0.000000
#> 2      1.374058     14.504053      0.639375      0.000000      0.631143
#> 3     11.587710      0.827694      0.000000      7.863089      0.000000
#> 4     23.413008      0.000000     29.966720      0.000000      0.000000
#> 5      7.689965      1.275716      0.000000     19.351260      0.000000
#> 6      0.000000     13.377407      4.742440     14.200285      1.946264
#>   lengthclass34 lengthclass35 lengthclass36 lengthclass37 lengthclass38
#> 1      0.000000     10.126292      0.000000      0.000000       0.00000
#> 2      0.639375      0.000000      0.000000      0.000000       0.00000
#> 3      0.000000      0.000000      0.000000      0.000000       0.00000
#> 4      0.000000      0.000000      0.000000      0.000000       0.00000
#> 5      2.551432      0.000000      0.000000      0.000000      12.75716
#> 6      0.000000      1.946264      1.946264      3.892527       0.00000
#>   lengthclass39 lengthclass40 lengthclass41 lengthclass42 lengthclass43
#> 1             0             0             0             0             0
#> 2             0             0             0             0             0
#> 3             0             0             0             0             0
#> 4             0             0             0             0             0
#> 5             0             0             0             0             0
#> 6             0             0             0             0             0
#>   lengthclass44 lengthclass45 lengthclass46 lengthclass47 lengthclass48
#> 1             0             0             0             0             0
#> 2             0             0             0             0             0
#> 3             0             0             0             0             0
#> 4             0             0             0             0             0
#> 5             0             0             0             0             0
#> 6             0             0             0             0             0
#>   lengthclass49 lengthclass50 lengthclass51 lengthclass52 lengthclass53
#> 1             0             0             0             0             0
#> 2             0             0             0             0             0
#> 3             0             0             0             0             0
#> 4             0             0             0             0             0
#> 5             0             0             0             0             0
#> 6             0             0             0             0             0
#>   lengthclass54 lengthclass55 lengthclass56 lengthclass57 lengthclass58
#> 1             0             0             0             0             0
#> 2             0             0             0             0             0
#> 3             0             0             0             0             0
#> 4             0             0             0             0             0
#> 5             0             0             0             0             0
#> 6             0             0             0             0             0
#>   lengthclass59 lengthclass60 lengthclass61 lengthclass62 lengthclass63
#> 1             0             0             0             0             0
#> 2             0             0             0             0             0
#> 3             0             0             0             0             0
#> 4             0             0             0             0             0
#> 5             0             0             0             0             0
#> 6             0             0             0             0             0
#>   lengthclass64 lengthclass65 lengthclass66 lengthclass67 lengthclass68
#> 1             0             0             0             0             0
#> 2             0             0             0             0             0
#> 3             0             0             0             0             0
#> 4             0             0             0             0             0
#> 5             0             0             0             0             0
#> 6             0             0             0             0             0
#>   lengthclass69 lengthclass70 lengthclass71 lengthclass72 lengthclass73
#> 1             0             0             0             0             0
#> 2             0             0             0             0             0
#> 3             0             0             0             0             0
#> 4             0             0             0             0             0
#> 5             0             0             0             0             0
#> 6             0             0             0             0             0
#>   lengthclass74 lengthclass75 lengthclass76 lengthclass77 lengthclass78
#> 1             0             0             0             0             0
#> 2             0             0             0             0             0
#> 3             0             0             0             0             0
#> 4             0             0             0             0             0
#> 5             0             0             0             0             0
#> 6             0             0             0             0             0
#>   lengthclass79 lengthclass80 lengthclass81 lengthclass82 lengthclass83
#> 1             0             0             0             0             0
#> 2             0             0             0             0             0
#> 3             0             0             0             0             0
#> 4             0             0             0             0             0
#> 5             0             0             0             0             0
#> 6             0             0             0             0             0
#>   lengthclass84 lengthclass85 lengthclass86 lengthclass87 lengthclass88
#> 1             0             0             0             0             0
#> 2             0             0             0             0             0
#> 3             0             0             0             0             0
#> 4             0             0             0             0             0
#> 5             0             0             0             0             0
#> 6             0             0             0             0             0
#>   lengthclass89 lengthclass90 lengthclass91 lengthclass92 lengthclass93
#> 1             0             0             0             0             0
#> 2             0             0             0             0             0
#> 3             0             0             0             0             0
#> 4             0             0             0             0             0
#> 5             0             0             0             0             0
#> 6             0             0             0             0             0
#>   lengthclass94 lengthclass95 lengthclass96 lengthclass97 lengthclass98
#> 1             0             0             0             0             0
#> 2             0             0             0             0             0
#> 3             0             0             0             0             0
#> 4             0             0             0             0             0
#> 5             0             0             0             0             0
#> 6             0             0             0             0             0
#>   lengthclass99 lengthclass100_plus
#> 1             0                   0
#> 2             0                   0
#> 3             0                   0
#> 4             0                   0
#> 5             0                   0
#> 6             0                   0
```

## Checks on Catch table

The function `MEDBS_check_duplicates` checks the presence of duplicated rows in catch table 


```r
catch_with_diplicate <- rbind(Catch_tab_example,Catch_tab_example[1,])
MEDBS_check_duplicates(data=catch_with_diplicate,type="c",MS="ITA",GSA="GSA 9",SP="DPS",verbose=TRUE)
#> There is/are 1 replicated row/rows in the data.
#>                         ID COUNTRY YEAR QUARTER VESSEL_LENGTH GEAR
#> 58 ITA 2008-1GNS-1DEMFSA 9     ITA 2008      -1            -1  GNS
#>    MESH_SIZE_RANGE FISHERY  AREA SPECON SPECIES LANDINGS DISCARDS
#> 58              -1    DEMF GSA 9     -1     DPS  0.50829        0
#>    NO_SAMPLES_LANDINGS NO_LENGTH_MEASUREMENTS_LANDINGS
#> 58                  30                               0
#>    NO_AGE_MEASUREMENTS_LANDINGS NO_SAMPLES_DISCARDS
#> 58                            0                   0
#>    NO_LENGTH_MEASUREMENTS_DISCARDS NO_AGE_MEASUREMENTS_DISCARDS
#> 58                              -1                           -1
#>    NO_SAMPLES_CATCH NO_LENGTH_MEASUREMENTS_CATCH NO_AGE_MEASUREMENTS_CATCH
#> 58               -1                           -1                        -1
#>    MIN_AGE MAX_AGE
#> 58      -1      -1
```

### Check catches coverage

The function `MEDBS_Catch_coverage` allows to check the coverage in Catch table by mean of summary tables summarizing both landing and discard volumes and producing relative plots for the selected species. In particular:

1. summary table of landings


```r
results <- suppressMessages(MEDBS_Catch_coverage(Catch_tab_example,"DPS","ITA","GSA 9"))
head(results[[1]])
#>   country year quarter vessel_length gear mesh_size_range fishery  area species
#> 1     ITA 2003      -1            -1  GTR              -1   DEMSP GSA 9     DPS
#> 2     ITA 2003      -1            -1  OTB              -1   DEMSP GSA 9     DPS
#> 3     ITA 2004      -1            -1  GNS              -1    DEMF GSA 9     DPS
#> 4     ITA 2004      -1            -1  GTR              -1   DEMSP GSA 9     DPS
#> 5     ITA 2004      -1            -1  OTB          50D100      -1 GSA 9     DPS
#> 6     ITA 2005      -1            -1  GTR              -1   DEMSP GSA 9     DPS
#>     landings
#> 1   5.933227
#> 2 316.615971
#> 3   3.628830
#> 4   4.177760
#> 5 367.431910
#> 6   0.517960
```

2. summary table of discards


```r
head(results[[2]])
#>   country year quarter vessel_length gear mesh_size_range fishery  area species
#> 1     ITA 2003      -1            -1  GTR              -1   DEMSP GSA 9     DPS
#> 2     ITA 2003      -1            -1  OTB              -1   DEMSP GSA 9     DPS
#> 3     ITA 2006      -1            -1  OTB          50D100   DEMSP GSA 9     DPS
#> 4     ITA 2006      -1            -1  OTB          50D100  MDDWSP GSA 9     DPS
#> 5     ITA 2009      -1            -1  OTB          50D100   DEMSP GSA 9     DPS
#> 6     ITA 2009      -1            -1  OTB          50D100  MDDWSP GSA 9     DPS
#>   discards
#> 1  0.00000
#> 2  0.00000
#> 3  0.00000
#> 4  0.00000
#> 5 38.35542
#> 6  0.00000
```

3. Plot of landing volumes in catch table


```r
results[[3]]
```

![plot of chunk MEDBS_Catch_coverage3](figure/MEDBS_Catch_coverage3-1.png)

4. Plot of discard volumes in catch table


```r
results[[4]]
```

![plot of chunk MEDBS_Catch_coverage4](figure/MEDBS_Catch_coverage4-1.png)

### check Sum of products (SOP)

The function checks if the percentage difference between SOP and both volumes of landing and discard are greater then a threshold value. The default value is fixed to 5%.

threshold = 5


```r
MEDBS_SOP(data=Catch_tab_example,SP="DPS",MS="ITA",GSA="GSA 9",threshold = 5)
#>    YEAR QUARTER VESSEL_LENGTH GEAR MESH_SIZE_RANGE FISHERY check_LANDING
#> 24 2009      -1            -1  OTB          50D100   DEMSP              
#> 25 2014      -1            -1  OTB          50D100   DEMSP              
#> 54 2017       4            -1  OTB          50D100   DEMSP              
#>    check_DISCARD
#> 24          7.68
#> 25          5.53
#> 54          7.73
```

threshold = 2


```r
MEDBS_SOP(data=Catch_tab_example,SP="DPS",MS="ITA",GSA="GSA 9",threshold = 2)
#>    YEAR QUARTER VESSEL_LENGTH GEAR MESH_SIZE_RANGE FISHERY check_LANDING
#> 11 2004      -1            -1  OTB          50D100      -1          2.98
#> 21 2011      -1            -1  OTB          50D100   DEMSP              
#> 24 2009      -1            -1  OTB          50D100   DEMSP         -3.62
#> 25 2014      -1            -1  OTB          50D100   DEMSP              
#> 30 2017       1            -1  OTB          50D100   DEMSP         -3.37
#> 32 2017       4            -1  OTB          50D100  MDDWSP          2.05
#> 40 2016       3            -1  OTB          50D100  MDDWSP          2.84
#> 43 2016       3            -1  OTB          50D100   DEMSP              
#> 44 2012      -1            -1  OTB          50D100  MDDWSP              
#> 54 2017       4            -1  OTB          50D100   DEMSP          2.89
#>    check_DISCARD
#> 11              
#> 21          4.96
#> 24          7.68
#> 25          5.53
#> 30          2.07
#> 32              
#> 40              
#> 43          3.29
#> 44          3.88
#> 54          7.73
```

## Checks on discard and landing tables

### check duplicated records

The function `MEDBS_check_duplicates` checks the presence of duplicated rows in landings 


```r
Landing_tab_example <- rbind(Landing_tab_example,Landing_tab_example[1,])
MEDBS_check_duplicates(data=Landing_tab_example,type="l",MS="ITA",GSA="GSA 9",SP="DPS",verbose=TRUE)
#> There is/are 1 replicated row/rows in the data.
#>                          ID COUNTRY YEAR QUARTER VESSEL_LENGTH GEAR
#> 58 ITA 2003 1GTR-1DEMSPSA 9     ITA 2003      -1            -1  GTR
#>    MESH_SIZE_RANGE FISHERY  AREA SPECON SPECIES LANDINGS
#> 58              -1   DEMSP GSA 9     -1     DPS 5.933227
```

The function `MEDBS_check_duplicates` also checks the presence of duplicated rows in landings 


```r
Discard_tab_example <- rbind(Discard_tab_example,Discard_tab_example[1,])
MEDBS_check_duplicates(data=Discard_tab_example,type="d",SP="DPS",MS="ITA",GSA="GSA 9",verbose=TRUE)
#> There is/are 1 replicated row/rows in the data.
#>       ID COUNTRY YEAR QUARTER VESSEL_LENGTH GEAR MESH_SIZE_RANGE FISHERY  AREA
#> 22 44554     ITA 2009      -1            -1  OTB          50D100   DEMSP GSA 9
#>    SPECON SPECIES DISCARDS
#> 22     -1     DPS 38.35542
```

## Kolmogorov-Smirnov test

The function `MEDBS_ks` allows to perform the Kolmogorov-Smirnov test on both landings and discards for a selected species. The function performs Kolmogorov-Smirnov tests on couples of years to assess if they belong to the same population, returning a summary data frame. The function returns also the cumulative length distribution plots by fishery and year.


```r
ks <- MEDBS_ks(data=Landing_tab_example, type="l", SP="DPS",MS="ITA",GSA="GSA 9",Rt=1)
```

![plot of chunk MEDBS_ks_landing1](figure/MEDBS_ks_landing1-1.png)

```r
results <- ks[[1]]
head(results)
#>   year gear fishery total_number min_size mean_size max_size  sd_size
#> 1 2003  GTR   DEMSP         0.00       NA        NA       NA       NA
#> 2 2003  OTB      -1     18516.42       21  30.94000       41 5.460587
#> 3 2004  GNS    DEMF         0.00       NA        NA       NA       NA
#> 4 2004  GTR   DEMSP         0.00       NA        NA       NA       NA
#> 5 2004  OTB      -1     22257.63       22  30.77143       40 4.316747
#> 6 2005  GTR   DEMSP         0.00       NA        NA       NA       NA
```



```r
# plot(ks[[3]])
```

### Check consistency of length data

The function `MEDBS_length_ind` allows to check the consistency of length data for a selected species on both landings and discards returning a summary table of the main length size indicators time series by fishery.


```r
results <- MEDBS_length_ind(Discard_tab_example,type="d",SP="DPS",MS=c("ITA"),GSA=c("GSA 9"), splines=c(0.2,0.4,0.6,0.8),Xtresholds = c(0.25,0.5,0.75))
head(results[[1]])
#>   year gear fishery total_number min_size mean_size max_size  sd_size spline
#> 1 2009  OTB   DEMSP     22633.62        8  16.18669       35 3.691644    0.2
#> 2 2009  OTB   DEMSP     22633.62        8  16.18669       35 3.691644    0.2
#> 3 2009  OTB   DEMSP     22633.62        8  16.18669       35 3.691644    0.2
#> 4 2009  OTB   DEMSP     22633.62        8  16.18669       35 3.691644    0.4
#> 5 2009  OTB   DEMSP     22633.62        8  16.18669       35 3.691644    0.4
#> 6 2009  OTB   DEMSP     22633.62        8  16.18669       35 3.691644    0.4
#>   percentile percentile_value
#> 1       0.25         12.97333
#> 2       0.50         15.37941
#> 3       0.75         18.07179
#> 4       0.25         10.17795
#> 5       0.50         14.99112
#> 6       0.75         19.41598
```

A plot of the time series of mean length in discards and landings is returned.


```r
results[[2]]
```

![plot of chunk MEDBS_length_ind_plot1](figure/MEDBS_length_ind_plot1-1.png)

A plot of the time series of median length in discards and landings is returned.


```r
results[[3]]
```

![plot of chunk MEDBS_length_ind_plot2](figure/MEDBS_length_ind_plot2-1.png)

### Check of null individuals in landings and discards

The function `MEDBS_lengthclass_0` checks landings and discards for the presence of length class filled in having weigth > 0, returning a data frame with the rows with 0 values length class having weigth > 0.



































































































































































































































