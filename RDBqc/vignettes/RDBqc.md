---
title: "RDBqc: Quality checks on RDBFIS data formats" 
author: "Walter Zupa"
date: "2022-09-13"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteEngine{knitr::knitr}
  %\VignetteIndexEntry{RDBqc: Quality checks on RDBFIS data formats}
  %\usepackage[UTF-8]{inputenc}
---




```r
library(RDBqc)
```

RDBqc allows to carry out a set of _a priori_ quality checks on detailed sampling data and on aggregated landing data, and _a posteriori_ quality checks on MEDBS, FDI and GFCM data call formats.

The supported quality checks in version 0.0.10 are:

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
* FDI tables (G, H, I and J)
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
#>   Number_of_sets_hauls_on_trip Days_at_sea Sampling.method Aggregation_level
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
#> [1] No individual length classes out of the expected range
#>  [1] Sampling_type                           
#>  [2] Flag_country                            
#>  [3] Year                                    
#>  [4] Trip_code                               
#>  [5] Harbour                                 
#>  [6] Number_of_sets_hauls_on_trip            
#>  [7] Days_at_sea                             
#>  [8] Sampling.method                         
#>  [9] Aggregation_level                       
#> [10] Station_number                          
#> [11] Duration_of_fishing_operation           
#> [12] Initial_latitude                        
#> [13] Initial_longitude                       
#> [14] Final_latitude                          
#> [15] Final_longitude                         
#> [16] Depth_of_fishing_operation              
#> [17] Water_depth                             
#> [18] Catch_registration                      
#> [19] Species_registration                    
#> [20] Date                                    
#> [21] Area                                    
#> [22] Fishing_activity_category_National      
#> [23] Fishing_activity_category_European_lvl_6
#> [24] Species                                 
#> [25] Catch_category                          
#> [26] Weight                                  
#> [27] Subsample_weight                        
#> [28] Sex                                     
#> [29] Maturity_method                         
#> [30] Maturity_scale                          
#> [31] Maturity_Stage                          
#> [32] Ageing.method                           
#> [33] Age                                     
#> [34] Length_code                             
#> [35] Length_class                            
#> [36] Number_at_length                        
#> [37] Commercial_size_category_scale          
#> [38] Commercial_size_category                
#> [39] fish_ID                                 
#> [40] Individual_weight                       
#> <0 righe> (o 0-length row.names)
```

A plot of the frequency distribution is also returned:


```r
RCG_check_LFD(data_ex,MS="ITA",GSA="GSA99", SP="Mullus barbatus",min_len=6,max_len=250)[[2]]
#> [1] No individual length classes out of the expected range
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
#> NA included in the 'Length_class' field have been removed from the analysis.
head(results)
#>   Year Length_class nb_age_measurements
#> 1 2015           45                   1
#> 2 2014           50                   1
#> 3 2015           50                   1
#> 4 2016           50                   1
#> 5 2015           55                   3
#> 6 2016           55                   1
```

Moreover, the function detects if the age data are in the range min_age-max_age, reporting the list of the trip codes including outliers. 


```r
RCG_check_AL(data_ex,MS="ITA",GSA="GSA99",SP="Mullus barbatus",min_age=0,max_age=5)[[2]]
#> NA included in the 'Age' field have been removed from the analysis.
#> NA included in the 'Length_class' field have been removed from the analysis.
#>  [1] "01_18_2016" "02_18_2016" "05_18_2015" "07_18_2016" "08_18_2016"
#>  [6] "12_18_2015" "17_18_2014" "31_18_2017" "34_18_2016" "4_18_2014" 
#> [11] "57_18_2017" "66_18_2017"
```

A plot of the age/length relationship by sex and year is outputted for the selected species


```r
RCG_check_AL(data_ex,MS="ITA",GSA="GSA99",SP="Mullus barbatus",min_age=0,max_age=5)[[3]]
#> NA included in the 'Age' field have been removed from the analysis.
#> NA included in the 'Length_class' field have been removed from the analysis.
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
#>      Sampling_type Flag_country Year  Trip_code Harbour
#> 1                S          ITA 2016 01_18_2016   ITMOL
#> 77               S          ITA 2016 02_18_2016   ITMOL
#> 2430             S          ITA 2014 12_18_2014   ITMOL
#> 5544             S          ITA 2014  4_18_2014   ITBDS
#> 5777             S          ITA 2015 43_18_2015   ITMOL
#> 7946             S          ITA 2014 87_18_2014   ITBDS
#> 7949             S          ITA 2014 87_18_2014   ITBDS
#>      Number_of_sets_hauls_on_trip Days_at_sea Sampling.method Aggregation_level
#> 1                               4           1    SelfSampling              TRUE
#> 77                              8           2        Observer              TRUE
#> 2430                            5           1    SelfSampling              TRUE
#> 5544                            7           2    SelfSampling              TRUE
#> 5777                            4           1        Observer              TRUE
#> 7946                            5           1        Observer              TRUE
#> 7949                            5           1        Observer              TRUE
#>      Station_number Duration_of_fishing_operation Initial_latitude
#> 1               999                           960         42.04033
#> 77              999                          2052         40.58517
#> 2430            999                          1035         41.18683
#> 5544            999                          1770         41.90100
#> 5777            999                           990         41.38517
#> 7946            999                          1209         42.12050
#> 7949            999                          1209         42.12050
#>      Initial_longitude Final_latitude Final_longitude
#> 1             18.48217       42.09067        18.48483
#> 77            18.27417       40.60467        18.25550
#> 2430          16.81317       41.17550        16.84333
#> 5544          16.76867       41.92400        16.75783
#> 5777          16.41050       41.40850        16.39733
#> 7946          17.02167       42.07350        17.02017
#> 7949          17.02167       42.07350        17.02017
#>      Depth_of_fishing_operation Water_depth Catch_registration
#> 1                           113          NA                Lan
#> 77                          165          NA                All
#> 2430                        210          NA                Lan
#> 5544                        183          NA                Lan
#> 5777                         98          NA                All
#> 7946                        120          NA                All
#> 7949                        120          NA                All
#>      Species_registration       Date  Area Fishing_activity_category_National
#> 1                     All 18/02/2016 GSA99                          OTB_shelf
#> 77                    All 21/03/2016 GSA99                          OTB_shelf
#> 2430                  All 24/07/2014 GSA99                          OTB_shelf
#> 5544                  All 04/07/2014 GSA99                          OTB_shelf
#> 5777                  All 31/07/2015 GSA99                          OTB_shelf
#> 7946                  All 05/12/2014 GSA99                          OTB_shelf
#> 7949                  All 05/12/2014 GSA99                          OTB_shelf
#>      Fishing_activity_category_European_lvl_6         Species Catch_category
#> 1                            OTB_DEF_>=40_0_0 Mullus barbatus            Lan
#> 77                           OTB_DEF_>=40_0_0 Mullus barbatus            Lan
#> 2430                         OTB_DEF_>=40_0_0 Mullus barbatus            Lan
#> 5544                         OTB_DEF_>=40_0_0 Mullus barbatus            Lan
#> 5777                         OTB_DEF_>=40_0_0 Mullus barbatus            Lan
#> 7946                         OTB_DEF_>=40_0_0 Mullus barbatus            Lan
#> 7949                         OTB_DEF_>=40_0_0 Mullus barbatus            Lan
#>      Weight Subsample_weight Sex Maturity_method Maturity_scale Maturity_Stage
#> 1     18000             6000   F            Macr   Medits scale             2b
#> 77    19200             6400   F            Macr   Medits scale              3
#> 2430   6200             6200   F            Macr   Medits scale             4a
#> 5544   4760             4760   F            Macr   Medits scale              3
#> 5777   4600             4600   F            Macr   Medits scale             4b
#> 7946   5130             5130   F            Macr   Medits scale             2b
#> 7949   5130             5130   F            Macr   Medits scale             2b
#>      Ageing.method Age Length_code Length_class Number_at_length
#> 1              OWR  NA         scm          500                2
#> 77             OWR 4.5         scm          225                1
#> 2430           OWR 5.0         scm          220                1
#> 5544           OWR 7.0         scm          270                1
#> 5777           OWR 4.0         scm          205                1
#> 7946           OWR 4.0         scm          215                1
#> 7949           OWR 5.0         scm          245                1
#>      Commercial_size_category_scale Commercial_size_category fish_ID
#> 1                               ITA                        1      NA
#> 77                              ITA                        1      NA
#> 2430                            ITA                        1      NA
#> 5544                            ITA                        1      NA
#> 5777                            ITA                        1      NA
#> 7946                            ITA                        1      NA
#> 7949                            ITA                        1      NA
#>      Individual_weight
#> 1            1424.3446
#> 77            209.2891
#> 2430          201.8513
#> 5544          202.9782
#> 5777          220.3938
#> 7946          231.6174
#> 7949          206.2320
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
#> Warning: glm.fit: si sono verificate probabilità stimate numericamente pari a 0
#> o 1
```

![plot of chunk RCG_check_mat_ogive](figure/RCG_check_mat_ogive-1.png)
 
### Summarize individual measurements

This function `RCG_summarize_ind_meas` reports for each trip the number of length sex, maturity, individual weight and age measurements for a selected species. 


```r
results <- RCG_summarize_ind_meas(data=data_ex,MS="ITA",GSA="GSA99",SP="Mullus barbatus")
head(results)
#>   Year  Area         Species  Trip_code number_of_data            variable
#> 1 2014 GSA99 Mullus barbatus 12_18_2014            120 length_measurements
#> 2 2014 GSA99 Mullus barbatus 14_18_2014            163 length_measurements
#> 3 2014 GSA99 Mullus barbatus 15_18_2014            252 length_measurements
#> 4 2014 GSA99 Mullus barbatus 17_18_2014            239 length_measurements
#> 5 2014 GSA99 Mullus barbatus 19_18_2014           1657 length_measurements
#> 6 2014 GSA99 Mullus barbatus 20_18_2014            752 length_measurements
```

### Summarize trips

This function `RCG_summarize_trips` reports for the selected species the number of trips in the dataset for each year, area, harbour, metier and sampling method. 


```r
results <- RCG_summarize_trips(data_ex,MS="ITA",GSA="GSA99",SP="Mullus barbatus")
head(results)
#>   Year  Area Harbour Fishing_activity_category_European_lvl_6 Sampling.method
#> 1 2014 GSA99   ITBCE                         OTB_DEF_>=40_0_0        Observer
#> 2 2014 GSA99   ITBDS                         OTB_DEF_>=40_0_0        Observer
#> 3 2014 GSA99   ITBDS                         OTB_DEF_>=40_0_0    SelfSampling
#> 4 2014 GSA99   ITMFR                         OTB_DEF_>=40_0_0        Observer
#> 5 2014 GSA99   ITMFR                         OTB_DEF_>=40_0_0    SelfSampling
#> 6 2014 GSA99   ITMNP                         OTB_DEF_>=40_0_0        Observer
#>   Nb_trips
#> 1        2
#> 2        2
#> 3        2
#> 4        1
#> 5        7
#> 6        2
```

### Check trips location

The function `RCG_check_loc` allows to check the spatial distribution of data using the initial and final coordinates, where available, and the ports position included in the data.


```r
RCG_check_loc(data_ex)
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
#> 1      999   COUNTRY1 GSA99  999     999    Port      1120455
```

4. Sum of landing value by LandCtry, VslFlgCtry,  Area, Rect, SubRect, Harbour;


```r
RCG_check_CL(data_exampleCL,MS="COUNTRY1",GSA="GSA99",SP="Parapenaeus longirostris")[[4]]
#>   LandCtry VslFlgCtry  Area Rect SubRect Harbour Sum_LandingsValue
#> 1      999   COUNTRY1 GSA99  999     999    Port           5596437
```

5. Sum of landings by Year, Species, foCatEu5, foCatEu6;


```r
RCG_check_CL(data_exampleCL,MS="COUNTRY1",GSA="GSA99",SP="Parapenaeus longirostris")[[5]]
#>   Year                  Species foCatEu5         foCatEu6 Sum_Landings
#> 1 1900 Parapenaeus longirostris      999 OTB_DEF_>=40_0_0  1018083.081
#> 2 1900 Parapenaeus longirostris      999 OTB_DWS_>=40_0_0     1453.471
#> 3 1900 Parapenaeus longirostris      999 OTB_MDD_>=40_0_0   100918.089
```

6. Sum of landing value by Year, Species, foCatEu5, foCatEu6.


```r
RCG_check_CL(data_exampleCL,MS="COUNTRY1",GSA="GSA99",SP="Parapenaeus longirostris")[[6]]
#>   Year                  Species foCatEu5         foCatEu6 Sum_LandingsValue
#> 1 1900 Parapenaeus longirostris      999 OTB_DEF_>=40_0_0       5050728.907
#> 2 1900 Parapenaeus longirostris      999 OTB_DWS_>=40_0_0          7721.884
#> 3 1900 Parapenaeus longirostris      999 OTB_MDD_>=40_0_0        537986.519
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
#>                              ID COUNTRY YEAR QUARTER VESSEL_LENGTH GEAR
#> 1       ITA 2008-1GNS-1DEMFSA 9     ITA 2008      -1            -1  GNS
#> 2   ITA 2010-1OTB50D100DWSPSA 9     ITA 2010      -1            -1  OTB
#> 3   ITA 2014-1OTB50D100DWSPSA 9     ITA 2014      -1            -1  OTB
#> 4  ITA 2008-1OTB50D100DEMSPSA 9     ITA 2008      -1            -1  OTB
#> 5 ITA 2008-1OTB50D100MDDWSPSA 9     ITA 2008      -1            -1  OTB
#> 6  ITA 2007-1OTB50D100DEMSPSA 9     ITA 2007      -1            -1  OTB
#>   MESH_SIZE_RANGE FISHERY  AREA SPECON SPECIES  LANDINGS DISCARDS
#> 1              -1    DEMF GSA 9     -1     DPS   0.50829       -1
#> 2          50D100    DWSP GSA 9     -1     DPS   9.69116       -1
#> 3          50D100    DWSP GSA 9     -1     DPS   2.11283       -1
#> 4          50D100   DEMSP GSA 9     -1     DPS 187.26219       -1
#> 5          50D100  MDDWSP GSA 9     -1     DPS  66.06531       -1
#> 6          50D100   DEMSP GSA 9     -1     DPS  89.84975       -1
#>   NO_SAMPLES_LANDINGS NO_LENGTH_MEASUREMENTS_LANDINGS
#> 1                  30                               0
#> 2                   6                               0
#> 3                   2                               0
#> 4                  67                            3038
#> 5                  12                            1461
#> 6                  50                            2452
#>   NO_AGE_MEASUREMENTS_LANDINGS NO_SAMPLES_DISCARDS
#> 1                            0                   0
#> 2                            0                   0
#> 3                            0                   0
#> 4                            0                   0
#> 5                            0                   0
#> 6                            0                   0
#>   NO_LENGTH_MEASUREMENTS_DISCARDS NO_AGE_MEASUREMENTS_DISCARDS NO_SAMPLES_CATCH
#> 1                              -1                           -1               -1
#> 2                              -1                           -1               -1
#> 3                              -1                           -1               -1
#> 4                              -1                           -1               -1
#> 5                              -1                           -1               -1
#> 6                              -1                           -1               -1
#>   NO_LENGTH_MEASUREMENTS_CATCH NO_AGE_MEASUREMENTS_CATCH MIN_AGE MAX_AGE AGE_0
#> 1                           -1                        -1      -1      -1     0
#> 2                           -1                        -1      -1      -1     0
#> 3                           -1                        -1      -1      -1     0
#> 4                           -1                        -1       0       4     0
#> 5                           -1                        -1       0       4     0
#> 6                           -1                        -1       0       4     0
#>   AGE_0_NO_LANDED AGE_0_MEAN_WEIGHT_LANDED AGE_0_MEAN_LENGTH_LANDED
#> 1           0.000                    0.000                     0.00
#> 2           0.000                    0.000                     0.00
#> 3           0.000                    0.000                     0.00
#> 4        8859.650                    0.005                     1.97
#> 5         489.758                    0.006                     2.02
#> 6        1430.784                    0.006                     2.06
#>   AGE_0_NO_DISCARD AGE_0_MEAN_WEIGHT_DISCARD AGE_0_MEAN_LENGTH_DISCARD AGE_1
#> 1               -1                        -1                        -1     1
#> 2               -1                        -1                        -1     1
#> 3               -1                        -1                        -1     1
#> 4               -1                        -1                         0     1
#> 5               -1                        -1                         0     1
#> 6               -1                        -1                         0     1
#>   AGE_1_NO_LANDED AGE_1_MEAN_WEIGHT_LANDED AGE_1_MEAN_LENGTH_LANDED
#> 1           0.000                    0.000                     0.00
#> 2           0.000                    0.000                     0.00
#> 3           0.000                    0.000                     0.00
#> 4        8431.094                    0.012                     2.68
#> 5        2721.682                    0.013                     2.80
#> 6        4638.951                    0.013                     2.77
#>   AGE_1_NO_DISCARD AGE_1_MEAN_WEIGHT_DISCARD AGE_1_MEAN_LENGTH_DISCARD AGE_2
#> 1               -1                        -1                        -1     2
#> 2               -1                        -1                        -1     2
#> 3               -1                        -1                        -1     2
#> 4               -1                        -1                         0     2
#> 5               -1                        -1                         0     2
#> 6               -1                        -1                         0     2
#>   AGE_2_NO_LANDED AGE_2_MEAN_WEIGHT_LANDED AGE_2_MEAN_LENGTH_LANDED
#> 1           0.000                    0.000                     0.00
#> 2           0.000                    0.000                     0.00
#> 3           0.000                    0.000                     0.00
#> 4        1395.641                    0.020                     3.28
#> 5         638.159                    0.020                     3.31
#> 6         935.121                    0.021                     3.35
#>   AGE_2_NO_DISCARD AGE_2_MEAN_WEIGHT_DISCARD AGE_2_MEAN_LENGTH_DISCARD AGE_3
#> 1               -1                        -1                        -1     3
#> 2               -1                        -1                        -1     3
#> 3               -1                        -1                        -1     3
#> 4               -1                        -1                         0     3
#> 5               -1                        -1                         0     3
#> 6               -1                        -1                         0     3
#>   AGE_3_NO_LANDED AGE_3_MEAN_WEIGHT_LANDED AGE_3_MEAN_LENGTH_LANDED
#> 1           0.000                    0.000                     0.00
#> 2           0.000                    0.000                     0.00
#> 3           0.000                    0.000                     0.00
#> 4         213.802                    0.024                     3.54
#> 5         197.337                    0.026                     3.63
#> 6          64.480                    0.022                     3.39
#>   AGE_3_NO_DISCARD AGE_3_MEAN_WEIGHT_DISCARD AGE_3_MEAN_LENGTH_DISCARD AGE_4
#> 1               -1                        -1                        -1     4
#> 2               -1                        -1                        -1     4
#> 3               -1                        -1                        -1     4
#> 4               -1                        -1                         0     4
#> 5               -1                        -1                         0     4
#> 6               -1                        -1                         0     4
#>   AGE_4_NO_LANDED AGE_4_MEAN_WEIGHT_LANDED AGE_4_MEAN_LENGTH_LANDED
#> 1           0.000                    0.000                     0.00
#> 2           0.000                    0.000                     0.00
#> 3           0.000                    0.000                     0.00
#> 4         414.040                    0.023                     3.50
#> 5         388.771                    0.024                     3.55
#> 6          29.945                    0.023                     3.49
#>   AGE_4_NO_DISCARD AGE_4_MEAN_WEIGHT_DISCARD AGE_4_MEAN_LENGTH_DISCARD AGE_5
#> 1               -1                        -1                        -1     5
#> 2               -1                        -1                        -1     5
#> 3               -1                        -1                        -1     5
#> 4               -1                        -1                         0     5
#> 5               -1                        -1                         0     5
#> 6               -1                        -1                         0     5
#>   AGE_5_NO_LANDED AGE_5_MEAN_WEIGHT_LANDED AGE_5_MEAN_LENGTH_LANDED
#> 1               0                        0                        0
#> 2               0                        0                        0
#> 3               0                        0                        0
#> 4               0                        0                        0
#> 5               0                        0                        0
#> 6               0                        0                        0
#>   AGE_5_NO_DISCARD AGE_5_MEAN_WEIGHT_DISCARD AGE_5_MEAN_LENGTH_DISCARD AGE_6
#> 1               -1                        -1                        -1     6
#> 2               -1                        -1                        -1     6
#> 3               -1                        -1                        -1     6
#> 4               -1                        -1                         0     6
#> 5               -1                        -1                         0     6
#> 6               -1                        -1                         0     6
#>   AGE_6_NO_LANDED AGE_6_MEAN_WEIGHT_LANDED AGE_6_MEAN_LENGTH_LANDED
#> 1               0                        0                        0
#> 2               0                        0                        0
#> 3               0                        0                        0
#> 4               0                        0                        0
#> 5               0                        0                        0
#> 6               0                        0                        0
#>   AGE_6_NO_DISCARD AGE_6_MEAN_WEIGHT_DISCARD AGE_6_MEAN_LENGTH_DISCARD AGE_7
#> 1               -1                        -1                        -1     7
#> 2               -1                        -1                        -1     7
#> 3               -1                        -1                        -1     7
#> 4               -1                        -1                         0     7
#> 5               -1                        -1                         0     7
#> 6               -1                        -1                         0     7
#>   AGE_7_NO_LANDED AGE_7_MEAN_WEIGHT_LANDED AGE_7_MEAN_LENGTH_LANDED
#> 1               0                        0                        0
#> 2               0                        0                        0
#> 3               0                        0                        0
#> 4               0                        0                        0
#> 5               0                        0                        0
#> 6               0                        0                        0
#>   AGE_7_NO_DISCARD AGE_7_MEAN_WEIGHT_DISCARD AGE_7_MEAN_LENGTH_DISCARD AGE_8
#> 1               -1                        -1                        -1     8
#> 2               -1                        -1                        -1     8
#> 3               -1                        -1                        -1     8
#> 4               -1                        -1                         0     8
#> 5               -1                        -1                         0     8
#> 6               -1                        -1                         0     8
#>   AGE_8_NO_LANDED AGE_8_MEAN_WEIGHT_LANDED AGE_8_MEAN_LENGTH_LANDED
#> 1               0                        0                        0
#> 2               0                        0                        0
#> 3               0                        0                        0
#> 4               0                        0                        0
#> 5               0                        0                        0
#> 6               0                        0                        0
#>   AGE_8_NO_DISCARD AGE_8_MEAN_WEIGHT_DISCARD AGE_8_MEAN_LENGTH_DISCARD AGE_9
#> 1               -1                        -1                        -1     9
#> 2               -1                        -1                        -1     9
#> 3               -1                        -1                        -1     9
#> 4               -1                        -1                         0     9
#> 5               -1                        -1                         0     9
#> 6               -1                        -1                         0     9
#>   AGE_9_NO_LANDED AGE_9_MEAN_WEIGHT_LANDED AGE_9_MEAN_LENGTH_LANDED
#> 1               0                        0                        0
#> 2               0                        0                        0
#> 3               0                        0                        0
#> 4               0                        0                        0
#> 5               0                        0                        0
#> 6               0                        0                        0
#>   AGE_9_NO_DISCARD AGE_9_MEAN_WEIGHT_DISCARD AGE_9_MEAN_LENGTH_DISCARD AGE_10
#> 1               -1                        -1                        -1     10
#> 2               -1                        -1                        -1     10
#> 3               -1                        -1                        -1     10
#> 4               -1                        -1                         0     10
#> 5               -1                        -1                         0     10
#> 6               -1                        -1                         0     10
#>   AGE_10_NO_LANDED AGE_10_MEAN_WEIGHT_LANDED AGE_10_MEAN_LENGTH_LANDED
#> 1                0                         0                         0
#> 2                0                         0                         0
#> 3                0                         0                         0
#> 4                0                         0                         0
#> 5                0                         0                         0
#> 6                0                         0                         0
#>   AGE_10_NO_DISCARD AGE_10_MEAN_WEIGHT_DISCARD AGE_10_MEAN_LENGTH_DISCARD
#> 1                -1                         -1                         -1
#> 2                -1                         -1                         -1
#> 3                -1                         -1                         -1
#> 4                -1                         -1                          0
#> 5                -1                         -1                          0
#> 6                -1                         -1                          0
#>   AGE_11 AGE_11_NO_LANDED AGE_11_MEAN_WEIGHT_LANDED AGE_11_MEAN_LENGTH_LANDED
#> 1     11                0                         0                         0
#> 2     11                0                         0                         0
#> 3     11                0                         0                         0
#> 4     11                0                         0                         0
#> 5     11                0                         0                         0
#> 6     11                0                         0                         0
#>   AGE_11_NO_DISCARD AGE_11_MEAN_WEIGHT_DISCARD AGE_11_MEAN_LENGTH_DISCARD
#> 1                -1                         -1                         -1
#> 2                -1                         -1                         -1
#> 3                -1                         -1                         -1
#> 4                -1                         -1                          0
#> 5                -1                         -1                          0
#> 6                -1                         -1                          0
#>   AGE_12 AGE_12_NO_LANDED AGE_12_MEAN_WEIGHT_LANDED AGE_12_MEAN_LENGTH_LANDED
#> 1     12                0                         0                         0
#> 2     12                0                         0                         0
#> 3     12                0                         0                         0
#> 4     12                0                         0                         0
#> 5     12                0                         0                         0
#> 6     12                0                         0                         0
#>   AGE_12_NO_DISCARD AGE_12_MEAN_WEIGHT_DISCARD AGE_12_MEAN_LENGTH_DISCARD
#> 1                -1                         -1                         -1
#> 2                -1                         -1                         -1
#> 3                -1                         -1                         -1
#> 4                -1                         -1                          0
#> 5                -1                         -1                          0
#> 6                -1                         -1                          0
#>   AGE_13 AGE_13_NO_LANDED AGE_13_MEAN_WEIGHT_LANDED AGE_13_MEAN_LENGTH_LANDED
#> 1     13                0                         0                         0
#> 2     13                0                         0                         0
#> 3     13                0                         0                         0
#> 4     13                0                         0                         0
#> 5     13                0                         0                         0
#> 6     13                0                         0                         0
#>   AGE_13_NO_DISCARD AGE_13_MEAN_WEIGHT_DISCARD AGE_13_MEAN_LENGTH_DISCARD
#> 1                -1                         -1                         -1
#> 2                -1                         -1                         -1
#> 3                -1                         -1                         -1
#> 4                -1                         -1                          0
#> 5                -1                         -1                          0
#> 6                -1                         -1                          0
#>   AGE_14 AGE_14_NO_LANDED AGE_14_MEAN_WEIGHT_LANDED AGE_14_MEAN_LENGTH_LANDED
#> 1     14                0                         0                         0
#> 2     14                0                         0                         0
#> 3     14                0                         0                         0
#> 4     14                0                         0                         0
#> 5     14                0                         0                         0
#> 6     14                0                         0                         0
#>   AGE_14_NO_DISCARD AGE_14_MEAN_WEIGHT_DISCARD AGE_14_MEAN_LENGTH_DISCARD
#> 1                -1                         -1                         -1
#> 2                -1                         -1                         -1
#> 3                -1                         -1                         -1
#> 4                -1                         -1                          0
#> 5                -1                         -1                          0
#> 6                -1                         -1                          0
#>   AGE_15 AGE_15_NO_LANDED AGE_15_MEAN_WEIGHT_LANDED AGE_15_MEAN_LENGTH_LANDED
#> 1     15                0                         0                         0
#> 2     15                0                         0                         0
#> 3     15                0                         0                         0
#> 4     15                0                         0                         0
#> 5     15                0                         0                         0
#> 6     15                0                         0                         0
#>   AGE_15_NO_DISCARD AGE_15_MEAN_WEIGHT_DISCARD AGE_15_MEAN_LENGTH_DISCARD
#> 1                -1                         -1                         -1
#> 2                -1                         -1                         -1
#> 3                -1                         -1                         -1
#> 4                -1                         -1                          0
#> 5                -1                         -1                          0
#> 6                -1                         -1                          0
#>   AGE_16 AGE_16_NO_LANDED AGE_16_MEAN_WEIGHT_LANDED AGE_16_MEAN_LENGTH_LANDED
#> 1     16                0                         0                         0
#> 2     16                0                         0                         0
#> 3     16                0                         0                         0
#> 4     16                0                         0                         0
#> 5     16                0                         0                         0
#> 6     16                0                         0                         0
#>   AGE_16_NO_DISCARD AGE_16_MEAN_WEIGHT_DISCARD AGE_16_MEAN_LENGTH_DISCARD
#> 1                -1                         -1                         -1
#> 2                -1                         -1                         -1
#> 3                -1                         -1                         -1
#> 4                -1                         -1                          0
#> 5                -1                         -1                          0
#> 6                -1                         -1                          0
#>   AGE_17 AGE_17_NO_LANDED AGE_17_MEAN_WEIGHT_LANDED AGE_17_MEAN_LENGTH_LANDED
#> 1     17                0                         0                         0
#> 2     17                0                         0                         0
#> 3     17                0                         0                         0
#> 4     17                0                         0                         0
#> 5     17                0                         0                         0
#> 6     17                0                         0                         0
#>   AGE_17_NO_DISCARD AGE_17_MEAN_WEIGHT_DISCARD AGE_17_MEAN_LENGTH_DISCARD
#> 1                -1                         -1                         -1
#> 2                -1                         -1                         -1
#> 3                -1                         -1                         -1
#> 4                -1                         -1                          0
#> 5                -1                         -1                          0
#> 6                -1                         -1                          0
#>   AGE_18 AGE_18_NO_LANDED AGE_18_MEAN_WEIGHT_LANDED AGE_18_MEAN_LENGTH_LANDED
#> 1     18                0                         0                         0
#> 2     18                0                         0                         0
#> 3     18                0                         0                         0
#> 4     18                0                         0                         0
#> 5     18                0                         0                         0
#> 6     18                0                         0                         0
#>   AGE_18_NO_DISCARD AGE_18_MEAN_WEIGHT_DISCARD AGE_18_MEAN_LENGTH_DISCARD
#> 1                -1                         -1                         -1
#> 2                -1                         -1                         -1
#> 3                -1                         -1                         -1
#> 4                -1                         -1                          0
#> 5                -1                         -1                          0
#> 6                -1                         -1                          0
#>   AGE_19 AGE_19_NO_LANDED AGE_19_MEAN_WEIGHT_LANDED AGE_19_MEAN_LENGTH_LANDED
#> 1     19                0                         0                         0
#> 2     19                0                         0                         0
#> 3     19                0                         0                         0
#> 4     19                0                         0                         0
#> 5     19                0                         0                         0
#> 6     19                0                         0                         0
#>   AGE_19_NO_DISCARD AGE_19_MEAN_WEIGHT_DISCARD AGE_19_MEAN_LENGTH_DISCARD
#> 1                -1                         -1                         -1
#> 2                -1                         -1                         -1
#> 3                -1                         -1                         -1
#> 4                -1                         -1                          0
#> 5                -1                         -1                          0
#> 6                -1                         -1                          0
#>   AGE_20_PLUS AGE_20_PLUS_NO_LANDED AGE_20_PLUS_MEAN_WEIGHT_LANDED
#> 1          20                     0                              0
#> 2          20                     0                              0
#> 3          20                     0                              0
#> 4          20                     0                              0
#> 5          20                     0                              0
#> 6          20                     0                              0
#>   AGE_20_PLUS_MEAN_LENGTH_LANDED AGE_20_PLUS_NO_DISCARD
#> 1                              0                     -1
#> 2                              0                     -1
#> 3                              0                     -1
#> 4                              0                     -1
#> 5                              0                     -1
#> 6                              0                     -1
#>   AGE_20_PLUS_MEAN_WEIGHT_DISCARD AGE_20_PLUS_MEAN_LENGTH_DISCARD
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

### check duplicated records

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
#>   COUNTRY YEAR QUARTER VESSEL_LENGTH GEAR MESH_SIZE_RANGE FISHERY  AREA SPECIES
#> 1     ITA 2004      -1            -1  OTB          50D100      -1 GSA 9     DPS
#> 2     ITA 2004      -1            -1  GNS              -1    DEMF GSA 9     DPS
#> 3     ITA 2007      -1            -1  GNS              -1    DEMF GSA 9     DPS
#> 4     ITA 2008      -1            -1  GNS              -1    DEMF GSA 9     DPS
#> 5     ITA 2014      -1            -1  GNS              -1    DEMF GSA 9     DPS
#> 6     ITA 2017       2            -1  GNS              -1    DEMF GSA 9     DPS
#>    LANDINGS
#> 1 367.43191
#> 2   3.62883
#> 3   2.26308
#> 4   0.50829
#> 5   0.02736
#> 6   0.02688
```

2. summary table of discards


```r
head(results[[2]])
#>    COUNTRY YEAR QUARTER VESSEL_LENGTH GEAR MESH_SIZE_RANGE FISHERY  AREA
#> 5      ITA 2014      -1            -1  GNS              -1    DEMF GSA 9
#> 6      ITA 2017       2            -1  GNS              -1    DEMF GSA 9
#> 7      ITA 2003      -1            -1  GTR              -1   DEMSP GSA 9
#> 10     ITA 2012      -1            -1  GTR              -1   DEMSP GSA 9
#> 11     ITA 2003      -1            -1  OTB              -1   DEMSP GSA 9
#> 13     ITA 2006      -1            -1  OTB          50D100   DEMSP GSA 9
#>    SPECIES DISCARDS
#> 5      DPS        0
#> 6      DPS        0
#> 7      DPS        0
#> 10     DPS        0
#> 11     DPS        0
#> 13     DPS        0
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

The function `MEDBS_check_duplicates` also checks the presence of duplicated rows in discard 


```r
Discard_tab_example <- rbind(Discard_tab_example,Discard_tab_example[1,])
MEDBS_check_duplicates(data=Discard_tab_example,type="d",MS="ITA",GSA="GSA 9",SP="DPS",verbose=TRUE)
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
#> Warning in melt.data.table(dat, id.vars = c("year", "area", "species",
#> "unit", : 'measure.vars' [0, 1, 2, 3, ...] are not all of the same type. By
#> order of hierarchy, the molten data value column will be of type 'double'. All
#> measure variables not of type 'double' will be coerced too. Check DETAILS in ?
#> melt.data.table for more on coercion.
#> Joining, by = c("year", "gear", "fishery")
#> Joining, by = c("year", "gear", "fishery")
#> Joining, by = c("year", "gear", "fishery")
#> Joining, by = c("year", "gear", "fishery")
#> Joining, by = c("year", "gear", "fishery")
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


```r
results <- MEDBS_lengthclass_0(data=Landing_tab_example,type="l",SP="DPS",MS="ITA",GSA="GSA 9",verbose=TRUE)
#> 17 cases in which length class number are zero and landings > 0
head(results)
#>                               id country year quarter vessel_length gear
#> 1       ITA 2003 1GTR-1DEMSPSA 9     ITA 2003      -1            -1  GTR
#> 3        ITA 2004-1GNS-1DEMFSA 9     ITA 2004      -1            -1  GNS
#> 4       ITA 2004-1GTR-1DEMSPSA 9     ITA 2004      -1            -1  GTR
#> 6       ITA 2005-1GTR-1DEMSPSA 9     ITA 2005      -1            -1  GTR
#> 10 ITA 2006-1OTB50D100MDDWSPSA 9     ITA 2006      -1            -1  OTB
#> 11       ITA 2007-1GNS-1DEMFSA 9     ITA 2007      -1            -1  GNS
#>    mesh_size_range fishery  area specon species   landings ck_0_length
#> 1               -1   DEMSP GSA 9     -1     DPS   5.933227           0
#> 3               -1    DEMF GSA 9     -1     DPS   3.628830           0
#> 4               -1   DEMSP GSA 9     -1     DPS   4.177760           0
#> 6               -1   DEMSP GSA 9     -1     DPS   0.517960           0
#> 10          50D100  MDDWSP GSA 9     -1     DPS 407.103060           0
#> 11              -1    DEMF GSA 9     -1     DPS   2.263080           0
```

### weight 0 in landings and discards

The function `MEDBS_weight_0` checks landings or discards in weight equal to 0 having length classes filled in, returning the number of rows with 0 values in weights having length classes filled in.


```r
MEDBS_weight_0(data=Discard_tab_example,type="d",SP="DPS",MS="ITA",GSA="GSA 9", verbose=TRUE)
#> There aren't 0 discards
#> [1] 0
```

### weight -1 in landings and discards

The function `MEDBS_weight_minus1` checks landings in weight equal to -1 having length class filled in, returning the number of rows with -1 values in landing weights having length class filled in.


```r
MEDBS_weight_minus1(data=Discard_tab_example,type="d",SP="DPS",MS="ITA",GSA="GSA 9",verbose=TRUE)
#> There aren't -1 discards
#> [1] 0
```

### Years with missing length distributions

The function `MEDBS_yr_missing_length` checks the presence of years with missing length distributions in both landings and discards for a selected species. A data frame of the missing length distributions is returned.


```r
results <- MEDBS_yr_missing_length(data=Landing_tab_example,type="l",SP="DPS",MS="ITA",GSA="GSA 9")
head(results)
#>   year gear fishery total_number_landed
#> 1 2003  GTR   DEMSP                   0
#> 2 2004  GNS    DEMF                   0
#> 3 2004  GTR   DEMSP                   0
#> 4 2005  GTR   DEMSP                   0
#> 5 2006  OTB  MDDWSP                   0
#> 6 2007  GNS    DEMF                   0
```

## Checks on landings

### Comparison between landings in weight by quarter accounting for vessel length

The function `MEDBS_comp_land_Q_VL` allows to perform the comparison of landings of a selected species aggregated by quarters accounting for the presence of vessel length. A dataframe for the comparison of landings aggregated by quarters accounting for the presence of vessel length information is returned.


```r
results <- suppressMessages(MEDBS_comp_land_Q_VL(data = Landing_tab_example, 
           SP = "DPS", MS = "ITA", GSA = "GSA 9"))
head(results)
#>   YEAR GEAR QUARTER    tot_VL tot_NoVL ratio
#> 1 2003  GTR      -1  11.86645       NA    NA
#> 2 2003  OTB      -1 316.61597       NA    NA
#> 3 2004  GNS      -1   3.62883       NA    NA
#> 4 2004  GTR      -1   4.17776       NA    NA
#> 5 2004  OTB      -1 367.43191       NA    NA
#> 6 2005  GTR      -1   0.51796       NA    NA
```

### Comparison between landings in weight by quarter and fishery accounting for vessel length

The function `MEDBS_comp_land_Q_VL_fishery` allows to perform the comparison of landings of a selected species aggregated by quarters and fishery accounting for the presence of vessel length. 
The function returns a data frame for the comparison of landings aggregated by quarters and fishery accounting for the presence of vessel length information.


```r
results <- suppressMessages(MEDBS_comp_land_Q_VL_fishery(data = Landing_tab_example, 
        MS = "ITA", GSA = "GSA 9", SP = "DPS"))
head(results)
#>   YEAR GEAR FISHERY QUARTER    tot_VL tot_NoVL ratio
#> 1 2003  GTR   DEMSP      -1  11.86645       NA    NA
#> 2 2003  OTB      -1      -1 316.61597       NA    NA
#> 3 2004  GNS    DEMF      -1   3.62883       NA    NA
#> 4 2004  GTR   DEMSP      -1   4.17776       NA    NA
#> 5 2004  OTB      -1      -1 367.43191       NA    NA
#> 6 2005  GTR   DEMSP      -1   0.51796       NA    NA
```

### Comparison between landings in weight by quarter and -1

The function `MEDBS_comp_land_YQ` allows to perform the comparison of landings of a selected species aggregated by quarters and by year.
The function returns a data frame  for the comparison of landings aggregated by quarters and by year.


```r
MEDBS_comp_land_YQ(data=Landing_tab_example,SP="DPS",MS="ITA",GSA="GSA 9")
#>    YEAR GEAR     tot_q    tot_yr  ratio
#> 1  2003  GTR        NA  11.86645     NA
#> 2  2003  OTB        NA 316.61597     NA
#> 3  2004  GNS        NA   3.62883     NA
#> 4  2004  GTR        NA   4.17776     NA
#> 5  2004  OTB        NA 367.43191     NA
#> 6  2005  GTR        NA   0.51796     NA
#> 7  2005  OTB        NA 430.42544     NA
#> 8  2006  OTB        NA 462.40605     NA
#> 9  2007  GNS        NA   2.26308     NA
#> 10 2007  OTB        NA 215.16790     NA
#> 11 2008  GNS        NA   0.50829     NA
#> 12 2008  OTB        NA 253.49215     NA
#> 13 2009  OTB        NA 303.14069     NA
#> 14 2010  OTB        NA 473.29438     NA
#> 15 2011  OTB        NA 551.03147     NA
#> 16 2012  GTR        NA   0.16116     NA
#> 17 2012  OTB        NA 621.08818     NA
#> 18 2013  OTB        NA 575.66107     NA
#> 19 2014  GNS        NA   0.02736     NA
#> 20 2014  OTB        NA 561.43756     NA
#> 21 2015  OTB        NA 791.44936     NA
#> 22 2016  OTB 825.13200  10.47800 78.749
#> 23 2017  GNS   0.02688        NA     NA
#> 24 2017  OTB 856.80650        NA     NA
```

### Comparison between landings in weight by quarter, quarter -1 and by fishery

The function `MEDBS_comp_land_YQ_fishery` allows to perform the comparison of landings of a selected species aggregated by quarters and by year and fishery.
The function returns a data frame  for the comparison of landings aggregated by quarters and by year and fishery.


```r
results <- suppressMessages(MEDBS_comp_land_YQ_fishery(data = Landing_tab_example, SP = "DPS", MS = "ITA", GSA = "GSA 9"))
head(results)
#>   YEAR GEAR FISHERY tot_q    tot_yr ratio
#> 1 2003  GTR   DEMSP    NA  11.86645    NA
#> 2 2003  OTB      -1    NA 316.61597    NA
#> 3 2004  GNS    DEMF    NA   3.62883    NA
#> 4 2004  GTR   DEMSP    NA   4.17776    NA
#> 5 2004  OTB      -1    NA 367.43191    NA
#> 6 2005  GTR   DEMSP    NA   0.51796    NA
```

### Check mean weight by year,gear and fishery aggregation

The function `MEDBS_land_mean_weight` allows to check consistency of  mean landing of a selected species plotting the landings' weight by year, gear and fishery.
A summary data frame is returned.


```r
results <- MEDBS_land_mean_weight(data=Landing_tab_example,SP="DPS",MS="ITA",GSA="GSA 9")[[1]]
head(results)
#>   year quarter vessel_length gear mesh_size_range fishery      totW     totN
#> 1 2003      -1            -1  GTR              -1   DEMSP  11866454        0
#> 2 2003      -1            -1  OTB          50D100      -1 316615971 18516419
#> 3 2004      -1            -1  GNS              -1    DEMF   3628830        0
#> 4 2004      -1            -1  GTR              -1   DEMSP   4177760        0
#> 5 2004      -1            -1  OTB          50D100      -1 367431910 22257632
#> 6 2005      -1            -1  GTR              -1   DEMSP    517960        0
#>         MW
#> 1      Inf
#> 2 17.09920
#> 3      Inf
#> 4      Inf
#> 5 16.50813
#> 6      Inf
```

The function returns a plot of the mean landing weight by year, gear and fishery aggregation as well.


```r
MEDBS_land_mean_weight(data=Landing_tab_example,SP="DPS",MS="ITA",GSA="GSA 9")[[2]]
```

![plot of chunk MEDBS_land_mean_weight2](figure/MEDBS_land_mean_weight2-1.png)

### Plot of total landing by gear and fishery

The function `MEDBS_plot_land_vol` allows to visual check the time series of landing volumes by fishery of a selected species. The function returns a plot of the total landing time series by fishery and gear.


```r
MEDBS_plot_land_vol(data=Landing_tab_example,SP="DPS",MS="ITA",GSA="GSA 9")
```

![plot of chunk MEDBS_plot_land_vol](figure/MEDBS_plot_land_vol-1.png)

### Plot of total landing

The function `MEDBS_plot_landing_ts` estimates the total landings time series by both year and quarters for a selected combination of member state, GSA and species. The function returns a plot of the total landing time series by year or by quarters. The plot by year also reports the landing by gear.


```r
suppressMessages(MEDBS_plot_landing_ts(data=Landing_tab_example,SP="DPS",MS="ITA",GSA="GSA 9",by="quarter"))
```

![plot of chunk MEDBS_plot_landing_ts](figure/MEDBS_plot_landing_ts-1.png)

### check the coverage in Landing table

The function `MEDBS_Landing_coverage` allows to check the coverage in landing table providing a summary table


```r
results <- suppressMessages(MEDBS_Landing_coverage(Landing_tab_example,"DPS","ITA","GSA 9"))
head(results[[1]])
#>   COUNTRY YEAR QUARTER VESSEL_LENGTH GEAR MESH_SIZE_RANGE FISHERY  AREA SPECIES
#> 1     ITA 2003      -1            -1  OTB          50D100      -1 GSA 9     DPS
#> 2     ITA 2004      -1            -1  OTB          50D100      -1 GSA 9     DPS
#> 3     ITA 2004      -1            -1  GNS              -1    DEMF GSA 9     DPS
#> 4     ITA 2007      -1            -1  GNS              -1    DEMF GSA 9     DPS
#> 5     ITA 2008      -1            -1  GNS              -1    DEMF GSA 9     DPS
#> 6     ITA 2014      -1            -1  GNS              -1    DEMF GSA 9     DPS
#>    LANDINGS
#> 1 316.61597
#> 2 367.43191
#> 3   3.62883
#> 4   2.26308
#> 5   0.50829
#> 6   0.02736
```

a plot of the landing coverage is also provided.


```r
results[[2]]
```

![plot of chunk MEDBS_Landing_coverage2](figure/MEDBS_Landing_coverage2-1.png)

## Checks on discards

### check the coverage in discard table

The function `MEDBS_discard_coverage` allows to check the coverage of the time series in discard table for a selected species. The function returns a summary table.


```r
results <- suppressMessages(MEDBS_discard_coverage(Discard_tab_example,"DPS","ITA","GSA 9"))
head(results[[1]])
#>   country year quarter vessel_length gear mesh_size_range fishery  area species
#> 1     ITA 2009      -1            -1  OTB          50D100   DEMSP GSA 9     DPS
#> 2     ITA 2010      -1            -1  OTB          50D100   DEMSP GSA 9     DPS
#> 3     ITA 2011      -1            -1  OTB          50D100   DEMSP GSA 9     DPS
#> 4     ITA 2012      -1            -1  OTB          50D100   DEMSP GSA 9     DPS
#> 5     ITA 2013      -1            -1  OTB          50D100   DEMSP GSA 9     DPS
#> 6     ITA 2014      -1            -1  OTB          50D100   DEMSP GSA 9     DPS
#>    discards
#> 1 76.710840
#> 2 24.396528
#> 3 60.519315
#> 4  6.571266
#> 5 26.761695
#> 6 44.978926
```

A plots of discard time series by year and gear is also provided.


```r
results[[2]]
```

![plot of chunk MEDBS_discard_coverage2](figure/MEDBS_discard_coverage2-1.png)

### Comparison between discards in weight by quarter and -1

The function `MEDBS_comp_disc_YQ` allows to compare the discards weights aggregated by quarter and by year for a selected species at the gear level. The function returns a data frame  for the comparison of discards aggregated by quarters and by year


```r
MEDBS_comp_disc_YQ(data=Discard_tab_example,SP="DPS",MS="ITA",GSA="GSA 9")
#>   YEAR GEAR    tot_q    tot_yr ratio
#> 1 2009  OTB       NA 76.710840    NA
#> 2 2010  OTB       NA 27.100131    NA
#> 3 2011  OTB       NA 63.262841    NA
#> 4 2012  OTB       NA  7.568045    NA
#> 5 2013  OTB       NA 30.040906    NA
#> 6 2014  OTB       NA 44.978926    NA
#> 7 2015  OTB       NA 89.320018    NA
#> 8 2016  OTB 34.93873        NA    NA
#> 9 2017  OTB 41.46659        NA    NA
```

### Comparison between discards in weight by quarter, quarter -1 and by fishery

The function `MEDBS_comp_disc_YQ_fishery` allow to estimates the discards in weight for a selected species by quarter and fishery. The function returns a data frame  for the comparison of discards aggregated by quarters and by year and fishery


```r
results <- MEDBS_comp_disc_YQ_fishery(data=Discard_tab_example,MS="ITA",GSA="GSA 9",SP="DPS")
head(results)
#>   YEAR GEAR FISHERY tot_q    tot_yr ratio
#> 1 2009  OTB   DEMSP    NA 76.710840    NA
#> 2 2010  OTB   DEMSP    NA 24.396528    NA
#> 3 2010  OTB  MDDWSP    NA  2.703603    NA
#> 4 2011  OTB   DEMSP    NA 60.519315    NA
#> 5 2011  OTB  MDDWSP    NA  2.743526    NA
#> 6 2012  OTB   DEMSP    NA  6.571266    NA
```

### Check mean weight by year,gear and fishery aggregation in discard

The function `MEDBS_disc_mean_weight` allows to check consistency of mean discard weight of a selected species providing a table of the mean individual weight by year, gear and fishery. 


```r
results <- MEDBS_disc_mean_weight(data=Discard_tab_example,SP="DPS",MS="ITA",GSA="GSA 9")
head(results[[1]])
#>   YEAR QUARTER VESSEL_LENGTH GEAR MESH_SIZE_RANGE FISHERY     totW       totN
#> 1 2009      -1            -1  OTB          50D100   DEMSP 76710840 22633620.8
#> 2 2010      -1            -1  OTB          50D100   DEMSP 24396528  6011330.6
#> 3 2010      -1            -1  OTB          50D100  MDDWSP  2703603   345221.9
#> 4 2011      -1            -1  OTB          50D100   DEMSP 60519315 29133415.7
#> 5 2011      -1            -1  OTB          50D100  MDDWSP  2743526   744126.7
#> 6 2012      -1            -1  OTB          50D100   DEMSP  6571266   998156.0
#>         MW
#> 1 3.389243
#> 2 4.058424
#> 3 7.831493
#> 4 2.077316
#> 5 3.686907
#> 6 6.583406
```

The function also returns a plot of the mean discards weight by year, gear and fishery aggregation.


```r
results[[2]]
#> geom_path: Each group consists of only one observation. Do you need to adjust
#> the group aesthetic?
#> geom_path: Each group consists of only one observation. Do you need to adjust
#> the group aesthetic?
```

![plot of chunk MEDBS_disc_mean_weight2](figure/MEDBS_disc_mean_weight2-1.png)

### Plot of total discards by gear and fishery

The function `MEDBS_plot_disc_vol` allows to visual check the time series of discard volumes by fishery of a selected species. The function returns a plot of the total discards time series by fishery and gear.


```r
MEDBS_plot_disc_vol(data=Discard_tab_example,SP="DPS",MS="ITA",GSA="GSA 9")
```

![plot of chunk MEDBS_plot_disc_vol](figure/MEDBS_plot_disc_vol-1.png)

### Plot of total discards time series

The function `MEDBS_plot_discard_ts` estimates the total discard time series by both year and quarters for a selected combination of member state, GSA and species. The function returns a plot of the total discard time series by year or by quarters. The parameter `by="year"` also reports the landing by gear.


```r
MEDBS_plot_discard_ts(data=Discard_tab_example,SP="DPS",MS="ITA",GSA="GSA 9",by="quarter")
```

![plot of chunk MEDBS_plot_discard_ts](figure/MEDBS_plot_discard_ts-1.png)

## Other checks

### GP_tab (growth params) table check

The function `MEDBS_GP_check` allows to check the growth parameters by sex and year for a selected species.  The function returns a list of objects containing a summary table and different plots of the growth curves by sex


```r
results <- MEDBS_GP_check(GP_tab_example,"MUT","ITA","18")
results[[1]]
#> NULL
print(names(results)[1])
#> NULL
```


```r
print(names(results)[2])
#> NULL
results[[2]]
#> NULL
```


```r
print(names(results)[3])
#> NULL
results[[3]]
#> NULL
```


```r
print(names(results)[4])
#> NULL
results[[4]]
#> NULL
```


```r
print(names(results)[5])
#> NULL
results[[5]]
#> NULL
```


```r
print(names(results)[6])
#> NULL
results[[6]]
#> NULL
```


```r
print(names(results)[7])
#> NULL
results[[7]]
#> NULL
```


```r
print(names(results)[8])
#> NULL
results[[8]]
#> NULL
```

### LW params in GP_tab in table check

The function `MEDBS_LW_check` allows to check the length-weight parameters included in the GP table for a selected species. The function returns a summary table.


```r
results <- MEDBS_LW_check(GP_tab_example,"MUT","ITA","GSA 18")
results[[1]]
#>    COUNTRY   AREA START_YEAR END_YEAR SPECIES SEX NA
#> 1      ITA GSA 18       2014     2014     MUT   C  1
#> 2      ITA GSA 18       2015     2015     MUT   C  1
#> 3      ITA GSA 18       2016     2016     MUT   C  1
#> 4      ITA GSA 18       2017     2017     MUT   C  1
#> 5      ITA GSA 18       2014     2014     MUT   F  1
#> 6      ITA GSA 18       2015     2015     MUT   F  1
#> 7      ITA GSA 18       2016     2016     MUT   F  1
#> 8      ITA GSA 18       2017     2017     MUT   F  1
#> 9      ITA GSA 18       2014     2014     MUT   M  1
#> 10     ITA GSA 18       2015     2015     MUT   M  1
#> 11     ITA GSA 18       2016     2016     MUT   M  1
#> 12     ITA GSA 18       2017     2017     MUT   M  1
```

plots of the length-weigth relationships for the selected species by year and sex are also returned.


```r
results[[2]]
```

![plot of chunk MEDBS_LW_check2](figure/MEDBS_LW_check2-1.png)

```r
results[[3]]
```

![plot of chunk MEDBS_LW_check2](figure/MEDBS_LW_check2-2.png)

```r
results[[4]]
```

![plot of chunk MEDBS_LW_check2](figure/MEDBS_LW_check2-3.png)

```r
results[[5]]
```

![plot of chunk MEDBS_LW_check2](figure/MEDBS_LW_check2-4.png)

```r
results[[6]]
```

![plot of chunk MEDBS_LW_check2](figure/MEDBS_LW_check2-5.png)

```r
results[[7]]
```

![plot of chunk MEDBS_LW_check2](figure/MEDBS_LW_check2-6.png)

```r
results[[8]]
```

![plot of chunk MEDBS_LW_check2](figure/MEDBS_LW_check2-7.png)

### MA_tab (maturity at age) table check

The function `MEDBS_MA_check` allows to check the maturity at age (MA) table providing a summary table of the data coverage.


```r
results <- MEDBS_MA_check(MA_tab_example,"DPS","ITA","GSA 99")
results[[1]]
#>    COUNTRY   YEAR START_YEAR END_YEAR SPECIES SEX COUNT
#> 1      ITA GSA 99       2006     2006     DPS   F     6
#> 2      ITA GSA 99       2007     2007     DPS   F     6
#> 3      ITA GSA 99       2008     2008     DPS   F     6
#> 4      ITA GSA 99       2009     2009     DPS   F     6
#> 5      ITA GSA 99       2010     2010     DPS   F     6
#> 6      ITA GSA 99       2011     2011     DPS   F     6
#> 7      ITA GSA 99       2012     2012     DPS   F     6
#> 8      ITA GSA 99       2013     2013     DPS   F     6
#> 9      ITA GSA 99       2014     2014     DPS   F     6
#> 10     ITA GSA 99       2015     2015     DPS   F     5
#> 11     ITA GSA 99       2016     2016     DPS   F     6
#> 12     ITA GSA 99       2017     2016     DPS   F     6
```

The function also provides plots for the selected species of the proportion of matures for age class by sex and year.


```r
results[[2]]
```

![plot of chunk MEDBS_MA_check2](figure/MEDBS_MA_check2-1.png)

```r
results[[3]]
```

![plot of chunk MEDBS_MA_check2](figure/MEDBS_MA_check2-2.png)

### ML_tab (maturity at length) table check

The function `MEDBS_ML_check` allows to check the maturity at length (ML) table providing a summary table of the data coverage for the selected species of the proportion of matures for age class by sex and year.


```r
results <- MEDBS_ML_check(ML_tab_example, "DPS", "ITA", "GSA 99")
```

![plot of chunk MEDBS_ML_check1](figure/MEDBS_ML_check1-1.png)

```r
results[[1]]
#>    COUNTRY   YEAR START_YEAR END_YEAR SPECIES SEX COUNT
#> 1      ITA GSA 99       2006     2006     DPS   F    31
#> 2      ITA GSA 99       2007     2007     DPS   F    32
#> 3      ITA GSA 99       2008     2008     DPS   F    33
#> 4      ITA GSA 99       2009     2009     DPS   F    42
#> 5      ITA GSA 99       2010     2010     DPS   F    39
#> 6      ITA GSA 99       2011     2011     DPS   F    41
#> 7      ITA GSA 99       2012     2012     DPS   F    35
#> 8      ITA GSA 99       2013     2013     DPS   F    38
#> 9      ITA GSA 99       2014     2014     DPS   F    38
#> 10     ITA GSA 99       2015     2015     DPS   F    35
#> 11     ITA GSA 99       2016     2016     DPS   F    37
#> 12     ITA GSA 99       2017     2017     DPS   F    36
```

Plots for the selected species of the proportion of matures for age class by sex and year are also returned.


```r
results[[2]]
```

![plot of chunk MEDBS_ML_check2](figure/MEDBS_ML_check2-1.png)

### SA_tab (sex ratio at age) table check

The function `MEDBS_SA_check` allows to check the sex ratio at age (SA) table providing a summary table of the data coverage for the selected species of the proportion of sex ratio for age class by year.


```r
results <- MEDBS_SA_check(SA_tab_example, "DPS", "ITA", "GSA 99")
results[[1]]
#>    COUNTRY   YEAR START_YEAR END_YEAR SPECIES
#> 1      ITA GSA 99       2003     2005     DPS
#> 2      ITA GSA 99       2006     2006     DPS
#> 3      ITA GSA 99       2007     2007     DPS
#> 4      ITA GSA 99       2008     2008     DPS
#> 5      ITA GSA 99       2009     2009     DPS
#> 6      ITA GSA 99       2010     2010     DPS
#> 7      ITA GSA 99       2011     2011     DPS
#> 8      ITA GSA 99       2012     2012     DPS
#> 9      ITA GSA 99       2013     2013     DPS
#> 10     ITA GSA 99       2014     2014     DPS
#> 11     ITA GSA 99       2015     2015     DPS
#> 12     ITA GSA 99       2016     2016     DPS
#> 13     ITA GSA 99       2017     2017     DPS
```

Plots for the selected species of the proportion of sex ratio for age class by year are also returned.


```r
results[[2]]
```

![plot of chunk MEDBS_SA_check2](figure/MEDBS_SA_check2-1.png)

```r
results[[3]]
```

![plot of chunk MEDBS_SA_check2](figure/MEDBS_SA_check2-2.png)

### SL_tab (sex ratio at length) table check

The function `MEDBS_SL_check` allows to check the sex ratio at length (SL) table providing a summary table of the data coverage for the selected species of the proportion of sex ratio for length class by year.


```r
results <- MEDBS_SL_check(SL_tab_example,"DPS","ITA","GSA 99")
results[[1]]
#>    COUNTRY    GSA START_YEAR END_YEAR SPECIES COUNT
#> 1      ITA GSA 99       2003     2005     DPS    30
#> 2      ITA GSA 99       2006     2006     DPS    29
#> 3      ITA GSA 99       2007     2007     DPS    29
#> 4      ITA GSA 99       2008     2008     DPS    32
#> 5      ITA GSA 99       2009     2009     DPS    40
#> 6      ITA GSA 99       2010     2010     DPS    39
#> 7      ITA GSA 99       2011     2011     DPS    40
#> 8      ITA GSA 99       2012     2012     DPS    35
#> 9      ITA GSA 99       2013     2013     DPS    37
#> 10     ITA GSA 99       2014     2014     DPS    37
#> 11     ITA GSA 99       2015     2015     DPS    32
#> 12     ITA GSA 99       2016     2016     DPS    37
#> 13     ITA GSA 99       2017     2017     DPS    37
```

Plots for the selected species of the proportion of sex ratio for length class by year are returned.


```r
results[[2]]
```

![plot of chunk MEDBS_SL_check2](figure/MEDBS_SL_check2-1.png)

```r
results[[3]]
```

![plot of chunk MEDBS_SL_check2](figure/MEDBS_SL_check2-2.png)

# Checks on FDI tables

## Table G

### Check empty fields in FDI G table

The function `check_EF_FDI_G` checks the presence of not allowed empty data in the given table, according to the 'Fisheries Dependent Information data call 2021 - Annex 1'.
A list is returned by the function. The first list's object is a vector containing the number of NA for each reference column. 


```r
check_EF_FDI_G(fdi_g_effort, verbose=FALSE)[[1]]
#>           country              year           quarter     vessel_length 
#>                 0                 0                 0                 0 
#>      fishing_tech         gear_type target_assemblage   mesh_size_range 
#>                 0                 0                 0               446 
#>            metier      supra_region        sub_region     eez_indicator 
#>                 0                 0                 0              2413 
#>     geo_indicator       specon_tech              deep        totseadays 
#>                 0                 0                 0                 0 
#>    totkwdaysatsea    totgtdaysatsea       totfishdays     totkwfishdays 
#>                 0                18                18                79 
#>     totgtfishdays             hrsea           kwhrsea           gthrsea 
#>               103                18                18                18 
#>            totves      confidential 
#>                 0                 0
```

The second list's object gives the index of each NA in the reference column.


```r
check_EF_FDI_G(fdi_g_effort, verbose=FALSE)[[2]]
#> $country
#> integer(0)
#> 
#> $year
#> integer(0)
#> 
#> $quarter
#> integer(0)
#> 
#> $vessel_length
#> integer(0)
#> 
#> $fishing_tech
#> integer(0)
#> 
#> $gear_type
#> integer(0)
#> 
#> $target_assemblage
#> integer(0)
#> 
#> $mesh_size_range
#>   [1]    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18
#>  [16]   19   20   21   22   23   24   25   26   27   28   29  447  448  449  450
#>  [31]  451  452  453  454  455  456  457  458  459  460  461  462  463  464  465
#>  [46]  466  467  468  469  470  471  472  473  474  475  476  477  478  479  480
#>  [61]  481  482  483  484  485  486  487  488  489  490  491  492  493  494  495
#>  [76]  496  497  498  499  500  501  502  503  504  505  506  507  508  509  510
#>  [91]  511  512  513  514  515  516  517  518  519  520  521  522  523  524  525
#> [106]  526  527  528  529  530  657  658  659  660  661  662  663  664  665  666
#> [121]  667  668  669  670  671  672  673  674  675  676  677  678  679  680  681
#> [136]  682  683  684  685  686  687 1730 1731 1732 1733 1734 1735 1736 1737 1738
#> [151] 1739 1740 1741 1742 1743 1744 1745 1746 1747 1748 1749 1750 1751 1752 1753
#> [166] 1754 1755 1756 1757 1758 1759 1760 1761 1762 1763 1764 1765 1766 1767 1768
#> [181] 1769 1770 1771 1772 1773 1774 1775 1776 1777 1778 1779 1780 1781 1782 1783
#> [196] 1784 1785 1786 1787 1788 1789 1790 1791 1792 1793 1794 1795 1796 1797 1798
#> [211] 1799 1800 1801 1802 1803 1804 1805 1806 1807 1808 1809 1810 1811 1812 1813
#> [226] 1814 1815 1816 1817 1818 1819 1820 1821 1822 1823 1824 1825 1826 1827 1828
#> [241] 1829 1830 1831 1832 1833 1834 1868 1869 1870 1871 1872 1873 1874 1875 1876
#> [256] 1877 1878 1879 1880 1881 1882 1883 1884 1885 1886 1887 1888 1909 1910 1911
#> [271] 1912 2082 2083 2084 2085 2086 2087 2088 2089 2090 2091 2092 2093 2133 2134
#> [286] 2135 2136 2137 2138 2139 2140 2141 2142 2143 2144 2145 2146 2147 2148 2149
#> [301] 2150 2151 2152 2153 2154 2155 2156 2312 2313 2314 2315 2316 2317 2318 2319
#> [316] 2320 2321 2322 2323 2324 2325 2326 2327 2328 2329 2330 2331 2332 2333 2334
#> [331] 2335 2336 2337 2338 2339 2340 2341 2342 2343 2344 2345 2346 2347 2348 2349
#> [346] 2350 2351 2352 2353 2354 2355 2356 2357 2358 2359 2360 2361 2362 2363 2364
#> [361] 2365 2366 2367 2368 2369 2370 2371 2372 2373 2374 2375 2376 2377 2378 2379
#> [376] 2380 2381 2382 2383 2384 2385 2386 2387 2388 2389 2390 2391 2392 2393 2394
#> [391] 2395 2396 2397 2398 2399 2400 2401 2402 2403 2404 2405 2406 2407 2408 2409
#> [406] 2410 2411 2412 2413 2414 2415 2416 2417 2418 2419 2420 2421 2422 2423 2424
#> [421] 2425 2426 2427 2428 2429 2430 2431 2432 2433 2434 2435 2436 2437 2438 2439
#> [436] 2440 2441 2442 2443 2444 2445 2446 2447 2448 2449 2450
#> 
#> $metier
#> integer(0)
#> 
#> $supra_region
#> integer(0)
#> 
#> $sub_region
#> integer(0)
#> 
#> $eez_indicator
#>    [1]    1    2    3    4    5    6    7    8    9   10   11   12   13   14
#>   [15]   15   16   17   18   19   20   21   22   23   24   25   26   27   28
#>   [29]   29   30   31   32   33   34   35   36   37   38   39   40   41   42
#>   [43]   43   44   45   46   47   48   49   50   51   52   53   54   55   56
#>   [57]   57   58   59   60   61   62   63   64   65   66   67   68   69   70
#>   [71]   71   72   73   74   75   76   77   78   79   80   81   82   83   84
#>   [85]   85   86   87   88   89   90   91   92   93   94   95   96   97   98
#>   [99]   99  100  101  102  103  104  105  106  107  108  109  110  111  112
#>  [113]  113  114  115  116  117  118  119  120  121  122  123  124  125  126
#>  [127]  127  128  129  130  131  132  133  134  135  136  137  138  139  140
#>  [141]  141  142  143  144  145  146  147  148  149  150  151  152  153  154
#>  [155]  155  156  157  158  159  160  161  162  163  164  165  166  167  168
#>  [169]  169  170  171  172  173  174  175  176  177  178  179  180  181  182
#>  [183]  183  184  185  186  187  188  189  190  191  192  193  194  195  196
#>  [197]  197  198  199  200  201  202  203  204  205  206  207  208  209  210
#>  [211]  211  212  213  214  215  216  217  218  219  220  221  222  223  224
#>  [225]  225  226  227  228  229  230  231  232  233  234  235  236  237  238
#>  [239]  239  240  241  242  243  244  245  246  247  248  249  250  251  252
#>  [253]  253  254  255  256  257  258  259  260  261  262  263  264  265  266
#>  [267]  267  268  269  270  271  272  273  274  275  276  277  278  279  280
#>  [281]  281  282  283  284  285  286  287  288  289  290  291  292  293  294
#>  [295]  295  296  297  298  299  300  301  302  303  304  305  306  307  308
#>  [309]  309  310  311  312  313  314  315  316  317  318  319  320  321  322
#>  [323]  323  324  325  326  327  328  329  330  331  332  333  334  335  336
#>  [337]  337  338  339  340  341  342  343  344  345  346  347  348  349  350
#>  [351]  351  352  353  354  355  356  357  358  359  360  361  362  363  364
#>  [365]  365  366  367  368  369  370  371  372  373  374  375  376  377  378
#>  [379]  379  380  381  382  383  384  385  386  387  388  389  390  391  392
#>  [393]  393  394  395  396  397  398  399  400  401  402  403  404  405  406
#>  [407]  407  408  409  410  411  412  413  414  415  416  417  418  419  420
#>  [421]  421  422  423  424  425  426  427  428  429  430  431  432  433  434
#>  [435]  435  436  437  438  439  440  441  442  443  444  445  446  447  448
#>  [449]  449  450  451  452  453  454  455  456  457  458  459  460  461  462
#>  [463]  463  464  465  466  467  468  469  470  471  472  473  474  475  476
#>  [477]  477  478  479  480  481  482  483  484  485  486  487  488  489  490
#>  [491]  491  492  493  494  495  496  497  498  499  500  501  502  503  504
#>  [505]  505  506  507  508  509  510  511  512  513  514  515  516  517  518
#>  [519]  519  520  521  522  523  524  525  526  528  537  538  539  540  541
#>  [533]  542  543  544  545  546  547  548  549  550  551  552  553  554  555
#>  [547]  556  557  558  559  560  561  562  563  564  565  566  567  568  569
#>  [561]  570  571  572  573  574  575  576  577  578  579  580  581  582  583
#>  [575]  584  585  586  587  588  589  590  591  592  593  594  595  596  597
#>  [589]  598  599  600  601  602  603  604  605  606  607  608  609  610  611
#>  [603]  612  613  614  615  616  622  623  624  625  626  627  628  629  630
#>  [617]  631  632  633  634  635  636  637  638  639  640  641  642  643  644
#>  [631]  645  646  647  648  649  650  651  652  653  654  655  656  657  658
#>  [645]  659  660  661  662  663  664  665  666  667  668  669  670  671  672
#>  [659]  673  674  675  676  677  678  679  680  681  682  683  684  685  686
#>  [673]  687  688  689  690  691  692  693  694  695  696  697  698  699  700
#>  [687]  701  702  703  704  705  706  707  708  709  710  711  712  713  714
#>  [701]  715  716  717  718  719  720  721  722  723  724  725  726  727  728
#>  [715]  729  730  731  732  733  734  735  736  737  738  739  740  741  742
#>  [729]  743  744  745  746  747  748  749  750  751  752  753  754  755  756
#>  [743]  757  758  759  760  761  762  763  764  765  766  767  768  769  770
#>  [757]  771  772  773  774  775  776  777  778  779  780  781  782  783  784
#>  [771]  785  786  787  788  789  790  791  792  793  794  795  796  797  798
#>  [785]  799  800  801  802  803  804  805  806  807  808  809  810  811  812
#>  [799]  813  814  815  816  817  818  819  820  821  822  823  824  825  826
#>  [813]  827  828  829  830  831  832  833  834  835  836  837  838  839  840
#>  [827]  841  842  843  844  845  846  847  848  849  850  851  852  853  854
#>  [841]  855  856  857  858  859  860  861  862  864  865  866  867  868  869
#>  [855]  870  871  872  873  874  875  876  877  878  879  880  881  882  883
#>  [869]  884  885  886  887  888  889  890  891  892  893  894  895  896  897
#>  [883]  898  899  900  901  902  903  904  905  906  907  908  909  910  911
#>  [897]  912  913  914  915  916  917  918  919  920  921  922  923  924  925
#>  [911]  926  927  928  929  930  931  932  933  934  935  936  937  938  939
#>  [925]  940  941  942  943  944  945  946  947  948  949  950  951  952  953
#>  [939]  954  955  956  957  958  959  960  961  962  963  964  965  966  967
#>  [953]  968  969  970  971  972  973  974  975  976  977  978  979  980  981
#>  [967]  982  983  984  985  986  987  988  989  990  991  992  993  994  995
#>  [981]  996  997  998  999 1000 1001 1002 1003 1004 1005 1006 1007 1008 1009
#>  [995] 1010 1011 1012 1013 1014 1015 1016 1017 1018 1019 1020 1021 1022 1023
#> [1009] 1024 1025 1026 1027 1028 1029 1030 1031 1032 1033 1034 1037 1038 1039
#> [1023] 1040 1041 1042 1043 1044 1045 1046 1047 1048 1049 1050 1051 1052 1053
#> [1037] 1054 1055 1056 1057 1058 1059 1060 1061 1062 1063 1064 1065 1066 1067
#> [1051] 1068 1069 1070 1071 1072 1073 1074 1075 1076 1077 1078 1079 1080 1081
#> [1065] 1082 1083 1084 1085 1086 1087 1088 1089 1090 1091 1092 1093 1094 1095
#> [1079] 1096 1097 1098 1099 1100 1101 1102 1103 1104 1105 1106 1107 1108 1109
#> [1093] 1110 1111 1112 1113 1114 1115 1116 1117 1118 1119 1120 1121 1122 1123
#> [1107] 1124 1125 1126 1127 1128 1129 1130 1131 1132 1133 1134 1135 1136 1137
#> [1121] 1138 1139 1140 1141 1142 1143 1144 1145 1146 1147 1148 1149 1150 1151
#> [1135] 1152 1153 1154 1155 1156 1157 1158 1159 1160 1161 1162 1163 1164 1165
#> [1149] 1166 1167 1168 1169 1170 1171 1172 1173 1174 1175 1176 1177 1178 1179
#> [1163] 1180 1181 1182 1183 1184 1185 1186 1187 1188 1189 1190 1191 1192 1193
#> [1177] 1194 1195 1196 1197 1198 1199 1200 1201 1202 1203 1204 1205 1206 1207
#> [1191] 1208 1209 1210 1211 1212 1213 1214 1215 1216 1217 1218 1219 1220 1221
#> [1205] 1222 1223 1224 1227 1228 1229 1230 1231 1232 1233 1234 1235 1236 1237
#> [1219] 1238 1239 1240 1241 1242 1243 1244 1245 1246 1247 1248 1249 1250 1251
#> [1233] 1252 1253 1254 1255 1256 1257 1258 1259 1260 1261 1262 1263 1264 1265
#> [1247] 1266 1267 1268 1269 1270 1271 1272 1273 1274 1275 1276 1277 1278 1279
#> [1261] 1280 1281 1282 1283 1284 1285 1286 1287 1288 1289 1290 1291 1292 1293
#> [1275] 1294 1295 1296 1297 1298 1299 1300 1301 1302 1303 1304 1305 1306 1307
#> [1289] 1308 1309 1310 1311 1312 1313 1314 1315 1316 1317 1318 1319 1320 1321
#> [1303] 1322 1323 1324 1325 1326 1327 1328 1329 1330 1331 1332 1333 1334 1335
#> [1317] 1336 1337 1338 1339 1340 1341 1342 1343 1344 1345 1346 1347 1348 1349
#> [1331] 1350 1351 1352 1353 1354 1355 1356 1357 1358 1359 1360 1361 1362 1363
#> [1345] 1364 1365 1366 1367 1368 1369 1370 1371 1372 1373 1374 1375 1376 1377
#> [1359] 1378 1379 1380 1381 1382 1383 1384 1385 1386 1387 1388 1389 1390 1391
#> [1373] 1392 1393 1394 1395 1396 1397 1398 1399 1400 1401 1402 1403 1404 1405
#> [1387] 1406 1407 1408 1409 1410 1411 1412 1413 1414 1415 1416 1417 1418 1419
#> [1401] 1420 1421 1422 1423 1424 1425 1426 1427 1428 1429 1430 1431 1432 1433
#> [1415] 1434 1435 1436 1437 1438 1439 1440 1441 1442 1443 1444 1445 1446 1447
#> [1429] 1448 1449 1450 1451 1452 1453 1454 1455 1456 1457 1458 1459 1460 1461
#> [1443] 1462 1463 1464 1465 1466 1467 1468 1469 1470 1471 1472 1473 1474 1475
#> [1457] 1476 1477 1478 1479 1480 1481 1482 1483 1484 1485 1486 1487 1488 1489
#> [1471] 1490 1491 1492 1493 1494 1495 1496 1497 1498 1499 1500 1501 1502 1503
#> [1485] 1504 1505 1506 1507 1508 1509 1510 1511 1512 1513 1514 1515 1516 1517
#> [1499] 1519 1520 1521 1522 1523 1524 1525 1526 1527 1528 1529 1530 1531 1532
#> [1513] 1533 1534 1535 1536 1537 1538 1539 1540 1541 1542 1543 1544 1545 1546
#> [1527] 1547 1548 1549 1550 1551 1552 1553 1554 1555 1556 1557 1558 1559 1560
#> [1541] 1561 1562 1563 1564 1565 1566 1567 1568 1569 1570 1571 1572 1573 1574
#> [1555] 1575 1576 1577 1578 1579 1580 1581 1582 1583 1584 1585 1586 1587 1588
#> [1569] 1589 1590 1591 1592 1593 1594 1595 1596 1597 1598 1599 1600 1601 1602
#> [1583] 1603 1604 1605 1607 1608 1609 1610 1611 1612 1613 1614 1615 1616 1617
#> [1597] 1618 1619 1620 1621 1622 1623 1624 1625 1626 1627 1628 1629 1630 1631
#> [1611] 1632 1633 1634 1635 1636 1637 1638 1639 1640 1641 1642 1643 1644 1645
#> [1625] 1646 1647 1648 1649 1650 1651 1652 1653 1654 1655 1656 1657 1658 1659
#> [1639] 1660 1661 1662 1663 1664 1665 1666 1667 1668 1669 1670 1671 1672 1673
#> [1653] 1674 1675 1676 1677 1678 1679 1680 1681 1682 1683 1684 1685 1686 1687
#> [1667] 1688 1689 1690 1691 1692 1693 1694 1695 1696 1697 1698 1699 1700 1701
#> [1681] 1702 1703 1704 1705 1706 1707 1708 1709 1710 1711 1712 1713 1714 1715
#> [1695] 1716 1717 1718 1719 1720 1721 1722 1723 1724 1725 1726 1727 1728 1729
#> [1709] 1730 1731 1732 1733 1734 1735 1736 1737 1738 1739 1740 1741 1742 1743
#> [1723] 1744 1745 1746 1747 1748 1749 1750 1751 1752 1753 1754 1755 1756 1757
#> [1737] 1758 1759 1760 1761 1762 1763 1764 1765 1766 1768 1769 1770 1771 1772
#> [1751] 1773 1774 1775 1777 1779 1780 1781 1782 1783 1784 1785 1786 1787 1788
#> [1765] 1789 1790 1791 1792 1793 1794 1795 1796 1797 1798 1799 1800 1801 1802
#> [1779] 1803 1804 1805 1806 1807 1808 1809 1810 1811 1812 1813 1814 1815 1816
#> [1793] 1817 1818 1819 1820 1821 1822 1823 1824 1825 1826 1827 1828 1829 1830
#> [1807] 1831 1832 1833 1834 1835 1836 1837 1838 1839 1840 1841 1842 1843 1844
#> [1821] 1845 1846 1847 1848 1849 1850 1851 1852 1853 1854 1855 1856 1857 1858
#> [1835] 1859 1860 1861 1862 1863 1864 1865 1866 1867 1868 1869 1870 1871 1872
#> [1849] 1873 1874 1875 1876 1877 1878 1879 1880 1881 1882 1883 1884 1885 1886
#> [1863] 1887 1888 1889 1890 1891 1892 1893 1894 1895 1896 1897 1898 1899 1900
#> [1877] 1901 1902 1903 1904 1905 1906 1907 1908 1909 1910 1911 1912 1913 1914
#> [1891] 1915 1916 1917 1918 1919 1920 1921 1922 1923 1924 1925 1926 1927 1928
#> [1905] 1929 1930 1931 1932 1933 1934 1935 1936 1937 1938 1939 1940 1941 1942
#> [1919] 1943 1944 1945 1946 1947 1948 1949 1950 1951 1952 1953 1954 1955 1956
#> [1933] 1957 1958 1959 1960 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970
#> [1947] 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984
#> [1961] 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998
#> [1975] 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012
#> [1989] 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026
#> [2003] 2027 2028 2029 2030 2031 2032 2033 2034 2035 2036 2037 2038 2039 2040
#> [2017] 2041 2042 2043 2044 2045 2046 2047 2048 2049 2050 2051 2052 2054 2055
#> [2031] 2056 2057 2059 2060 2061 2062 2063 2064 2065 2066 2067 2068 2069 2070
#> [2045] 2071 2072 2073 2074 2075 2076 2077 2078 2079 2080 2081 2082 2083 2084
#> [2059] 2085 2086 2087 2088 2089 2090 2091 2092 2093 2094 2095 2096 2097 2098
#> [2073] 2099 2100 2101 2102 2103 2104 2105 2106 2107 2108 2109 2110 2111 2112
#> [2087] 2113 2114 2115 2116 2117 2118 2119 2120 2121 2122 2123 2124 2125 2126
#> [2101] 2127 2128 2129 2130 2131 2132 2133 2134 2135 2136 2137 2138 2139 2140
#> [2115] 2141 2142 2143 2144 2145 2146 2147 2148 2149 2150 2151 2152 2153 2154
#> [2129] 2155 2156 2157 2158 2159 2160 2161 2162 2163 2164 2165 2166 2167 2168
#> [2143] 2169 2170 2171 2172 2173 2174 2175 2176 2177 2178 2179 2180 2181 2182
#> [2157] 2183 2184 2185 2186 2187 2188 2189 2190 2191 2192 2193 2194 2195 2196
#> [2171] 2197 2198 2199 2200 2201 2202 2203 2204 2205 2206 2208 2209 2210 2211
#> [2185] 2212 2213 2214 2215 2216 2217 2218 2219 2220 2221 2222 2223 2224 2225
#> [2199] 2226 2227 2228 2229 2230 2231 2232 2233 2234 2235 2236 2237 2238 2239
#> [2213] 2240 2241 2242 2243 2244 2245 2246 2247 2248 2249 2250 2251 2252 2253
#> [2227] 2254 2255 2256 2257 2258 2259 2260 2261 2262 2263 2264 2265 2266 2267
#> [2241] 2268 2269 2270 2271 2272 2273 2274 2275 2276 2277 2278 2279 2280 2283
#> [2255] 2284 2285 2286 2287 2288 2289 2290 2291 2292 2293 2294 2295 2296 2297
#> [2269] 2298 2299 2300 2301 2302 2303 2304 2305 2306 2307 2308 2309 2310 2311
#> [2283] 2312 2313 2314 2315 2316 2317 2318 2319 2320 2321 2322 2323 2324 2325
#> [2297] 2326 2327 2328 2329 2330 2331 2332 2333 2334 2335 2336 2337 2338 2339
#> [2311] 2340 2341 2342 2343 2344 2345 2346 2347 2348 2349 2350 2351 2352 2353
#> [2325] 2354 2355 2356 2357 2358 2359 2360 2361 2362 2363 2364 2365 2366 2367
#> [2339] 2368 2369 2370 2371 2372 2373 2374 2375 2376 2377 2378 2379 2380 2381
#> [2353] 2382 2383 2384 2385 2386 2387 2388 2389 2390 2391 2392 2393 2394 2395
#> [2367] 2396 2397 2398 2399 2400 2401 2402 2403 2404 2405 2406 2407 2408 2409
#> [2381] 2410 2411 2412 2413 2414 2415 2416 2417 2418 2419 2420 2421 2422 2423
#> [2395] 2426 2430 2431 2432 2433 2434 2438 2439 2440 2441 2442 2443 2444 2445
#> [2409] 2446 2447 2448 2449 2450
#> 
#> $geo_indicator
#> integer(0)
#> 
#> $specon_tech
#> integer(0)
#> 
#> $deep
#> integer(0)
#> 
#> $totseadays
#> integer(0)
#> 
#> $totkwdaysatsea
#> integer(0)
#> 
#> $totgtdaysatsea
#>  [1] 602 603 604 605 606 607 608 609 610 611 612 613 614 615 616 617 618 619
#> 
#> $totfishdays
#>  [1] 602 603 604 605 606 607 608 609 610 611 612 613 614 615 616 617 618 619
#> 
#> $totkwfishdays
#>  [1]   12   13   14   15   16   17   18   19   20   21   22   23   24  322  323
#> [16]  324  325  326  327  328  329  330  331  332  333  334  527  528  529  530
#> [31]  531  532  533  534  535  536  537  538  539  602  603  604  605  606  607
#> [46]  608  609  610  611  612  613  614  615  616  617  618  619  728  729  730
#> [61]  731  732  733  734  735  736  737  738  739  740 1224 1225 1226 1350 1351
#> [76] 1352 1513 1514 1515
#> 
#> $totgtfishdays
#>   [1]   72   73   74   75   76   77   78   79   80   81   82   83   84  154  155
#>  [16]  156  157  158  159  160  161  162  163  164  165  166  445  446  447  448
#>  [31]  449  450  451  452  453  454  455  456  457  602  603  604  605  606  607
#>  [46]  608  609  610  611  612  613  614  615  616  617  618  619  645  646  647
#>  [61]  648  649  650  651  652  653  654  655  656  657  807  808  809  810  811
#>  [76]  812  813  814  815  816  817  818  819  974  975  976  977  978  979  980
#>  [91]  981  982  983  984  985  986  987 1350 1351 1352 1519 1520 1521
#> 
#> $hrsea
#>  [1] 602 603 604 605 606 607 608 609 610 611 612 613 614 615 616 617 618 619
#> 
#> $kwhrsea
#>  [1] 602 603 604 605 606 607 608 609 610 611 612 613 614 615 616 617 618 619
#> 
#> $gthrsea
#>  [1] 602 603 604 605 606 607 608 609 610 611 612 613 614 615 616 617 618 619
#> 
#> $totves
#> integer(0)
#> 
#> $confidential
#> integer(0)
```

### Check duplicated records in FDI G table

The function `check_RD_FDI_G` check the presence of duplicated records. In particular, it checks whether the combination of the first 15 columns generates duplicate records. The function returns the indices of the duplicated rows.


```r
g_effort <- rbind(fdi_g_effort,fdi_g_effort[1,])
check_RD_FDI_G(g_effort)
#> 669 record/s duplicated
#>   [1]   42   43   44   45   46   52   53   54   55   61   62   63   69   75   81
#>  [16]   82   84   85   87   88   89   90   91   92   93   94   95   98  100  102
#>  [31]  104  107  108  109  110  111  112  113  114  115  116  119  121  123  125
#>  [46]  128  129  130  131  132  133  134  135  136  139  140  141  142  143  144
#>  [61]  145  146  147  148  149  150  151  152  153  155  156  157  163  164  165
#>  [76]  198  211  217  218  219  220  222  226  227  228  229  231  233  234  236
#>  [91]  237  238  239  240  253  254  255  256  262  263  264  265  266  272  273
#> [106]  274  275  281  282  283  289  295  300  302  304  308  311  313  315  317
#> [121]  320  325  327  329  331  334  335  338  340  342  344  347  348  349  350
#> [136]  351  352  353  355  356  357  358  359  360  361  362  363  364  365  366
#> [151]  367  368  369  370  371  372  373  374  375  376  377  378  381  383  385
#> [166]  387  390  391  392  395  397  399  401  404  405  406  407  408  409  410
#> [181]  411  412  413  414  415  416  417  418  420  421  422  423  424  425  426
#> [196]  427  428  429  430  431  432  433  435  436  437  438  439  440  441  442
#> [211]  443  444  446  474  486  493  502  509  521  523  524  525  526  550  558
#> [226]  583  586  587  588  592  594  596  598  602  603  607  613  622  626  629
#> [241]  631  632  635  637  639  641  644  646  647  650  652  654  674  680  693
#> [256]  704  735  742  758  770  776  777  778  790  796  797  803  804  805  806
#> [271]  812  814  823  831  832  833  834  840  846  852  853  859  860  861  862
#> [286]  878  879  880  881  887  888  889  901  907  908  914  915  916  917  923
#> [301]  924  925  926  927  936  942  950  956  962  963  981  982  988  989  997
#> [316]  998  999 1005 1011 1017 1018 1024 1025 1026 1027 1033 1034 1043 1044 1045
#> [331] 1046 1053 1079 1088 1091 1092 1098 1099 1100 1101 1107 1108 1109 1110 1111
#> [346] 1112 1113 1114 1115 1116 1122 1128 1131 1134 1135 1136 1137 1139 1141 1142
#> [361] 1143 1144 1147 1149 1151 1153 1154 1156 1157 1158 1159 1160 1161 1162 1163
#> [376] 1164 1165 1168 1170 1172 1174 1177 1178 1189 1190 1196 1205 1206 1207 1208
#> [391] 1209 1232 1238 1245 1251 1253 1260 1262 1265 1267 1270 1271 1272 1273 1276
#> [406] 1278 1287 1293 1299 1300 1306 1307 1308 1309 1315 1316 1317 1318 1319 1325
#> [421] 1326 1328 1330 1334 1335 1336 1337 1338 1339 1340 1341 1342 1343 1344 1347
#> [436] 1349 1351 1353 1356 1362 1371 1374 1383 1389 1396 1397 1398 1399 1401 1402
#> [451] 1403 1404 1405 1406 1407 1408 1409 1410 1411 1412 1413 1414 1415 1416 1417
#> [466] 1418 1419 1420 1421 1422 1423 1424 1425 1426 1427 1430 1432 1434 1436 1439
#> [481] 1440 1441 1444 1446 1448 1450 1453 1454 1466 1472 1474 1479 1480 1481 1483
#> [496] 1484 1486 1490 1493 1495 1496 1499 1500 1501 1502 1503 1504 1505 1506 1507
#> [511] 1508 1528 1535 1537 1554 1555 1556 1563 1576 1590 1592 1599 1601 1625 1627
#> [526] 1637 1638 1656 1665 1680 1686 1693 1699 1708 1721 1727 1729 1751 1758 1760
#> [541] 1769 1800 1807 1822 1823 1824 1825 1826 1832 1833 1834 1861 1880 1881 1926
#> [556] 1933 1934 1935 1936 1959 1965 1971 1972 1978 1979 1980 1981 1987 1989 1998
#> [571] 2008 2010 2022 2028 2029 2035 2036 2037 2042 2043 2044 2046 2047 2048 2049
#> [586] 2050 2051 2052 2054 2055 2056 2057 2061 2063 2065 2067 2100 2102 2110 2111
#> [601] 2112 2118 2119 2120 2126 2145 2146 2147 2148 2154 2155 2156 2166 2167 2173
#> [616] 2174 2175 2181 2187 2202 2209 2211 2214 2216 2218 2220 2223 2224 2242 2248
#> [631] 2249 2255 2256 2257 2258 2264 2265 2266 2267 2284 2293 2294 2297 2299 2321
#> [646] 2324 2333 2339 2341 2366 2368 2375 2377 2394 2395 2396 2403 2407 2411 2413
#> [661] 2416 2417 2418 2419 2422 2426 2430 2432 2451
```

## Table H

### Check empty fields in FDI H table

The function `check_EF_FDI_H` checks the presence of not allowed empty data in the given table, according to the 'Fisheries Dependent Information data call 2021 - Annex 1'.
A list is returned by the function. The first list's object is a vector containing the number of NA for each reference column. 


```r
check_EF_FDI_H(fdi_h_spatial_landings, verbose=FALSE)[[1]]
#>           country              year           quarter     vessel_length 
#>                 0                 0                 0                 0 
#>      fishing_tech         gear_type target_assemblage   mesh_size_range 
#>                 0                 0               446                 0 
#>            metier      supra_region        sub_region     eez_indicator 
#>                 0                 0                 0                 0 
#>     geo_indicator       specon_tech              deep    rectangle_type 
#>                 0              1138              2426                 0 
#>     rectangle_lat     rectangle_lon          c_square           species 
#>                 0                 0                 0                 0 
#>      totwghtlandg       totvallandg      confidential 
#>                 0                 0              2450
```

The second list's object gives the index of each NA in the reference column.


```r
check_EF_FDI_H(fdi_h_spatial_landings, verbose=FALSE)[[2]]
#> $country
#> integer(0)
#> 
#> $year
#> integer(0)
#> 
#> $quarter
#> integer(0)
#> 
#> $vessel_length
#> integer(0)
#> 
#> $fishing_tech
#> integer(0)
#> 
#> $gear_type
#> integer(0)
#> 
#> $target_assemblage
#>   [1]    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18
#>  [16]   19   20   21   22   23   24   25   26   27   28   29  447  448  449  450
#>  [31]  451  452  453  454  455  456  457  458  459  460  461  462  463  464  465
#>  [46]  466  467  468  469  470  471  472  473  474  475  476  477  478  479  480
#>  [61]  481  482  483  484  485  486  487  488  489  490  491  492  493  494  495
#>  [76]  496  497  498  499  500  501  502  503  504  505  506  507  508  509  510
#>  [91]  511  512  513  514  515  516  517  518  519  520  521  522  523  524  525
#> [106]  526  527  528  529  530  657  658  659  660  661  662  663  664  665  666
#> [121]  667  668  669  670  671  672  673  674  675  676  677  678  679  680  681
#> [136]  682  683  684  685  686  687 1730 1731 1732 1733 1734 1735 1736 1737 1738
#> [151] 1739 1740 1741 1742 1743 1744 1745 1746 1747 1748 1749 1750 1751 1752 1753
#> [166] 1754 1755 1756 1757 1758 1759 1760 1761 1762 1763 1764 1765 1766 1767 1768
#> [181] 1769 1770 1771 1772 1773 1774 1775 1776 1777 1778 1779 1780 1781 1782 1783
#> [196] 1784 1785 1786 1787 1788 1789 1790 1791 1792 1793 1794 1795 1796 1797 1798
#> [211] 1799 1800 1801 1802 1803 1804 1805 1806 1807 1808 1809 1810 1811 1812 1813
#> [226] 1814 1815 1816 1817 1818 1819 1820 1821 1822 1823 1824 1825 1826 1827 1828
#> [241] 1829 1830 1831 1832 1833 1834 1868 1869 1870 1871 1872 1873 1874 1875 1876
#> [256] 1877 1878 1879 1880 1881 1882 1883 1884 1885 1886 1887 1888 1909 1910 1911
#> [271] 1912 2082 2083 2084 2085 2086 2087 2088 2089 2090 2091 2092 2093 2133 2134
#> [286] 2135 2136 2137 2138 2139 2140 2141 2142 2143 2144 2145 2146 2147 2148 2149
#> [301] 2150 2151 2152 2153 2154 2155 2156 2312 2313 2314 2315 2316 2317 2318 2319
#> [316] 2320 2321 2322 2323 2324 2325 2326 2327 2328 2329 2330 2331 2332 2333 2334
#> [331] 2335 2336 2337 2338 2339 2340 2341 2342 2343 2344 2345 2346 2347 2348 2349
#> [346] 2350 2351 2352 2353 2354 2355 2356 2357 2358 2359 2360 2361 2362 2363 2364
#> [361] 2365 2366 2367 2368 2369 2370 2371 2372 2373 2374 2375 2376 2377 2378 2379
#> [376] 2380 2381 2382 2383 2384 2385 2386 2387 2388 2389 2390 2391 2392 2393 2394
#> [391] 2395 2396 2397 2398 2399 2400 2401 2402 2403 2404 2405 2406 2407 2408 2409
#> [406] 2410 2411 2412 2413 2414 2415 2416 2417 2418 2419 2420 2421 2422 2423 2424
#> [421] 2425 2426 2427 2428 2429 2430 2431 2432 2433 2434 2435 2436 2437 2438 2439
#> [436] 2440 2441 2442 2443 2444 2445 2446 2447 2448 2449 2450
#> 
#> $mesh_size_range
#> integer(0)
#> 
#> $metier
#> integer(0)
#> 
#> $supra_region
#> integer(0)
#> 
#> $sub_region
#> integer(0)
#> 
#> $eez_indicator
#> integer(0)
#> 
#> $geo_indicator
#> integer(0)
#> 
#> $specon_tech
#>    [1]    1    2    3    4  100  101  102  113  114  115  116  117  118  119
#>   [15]  129  130  131  132  133  150  151  152  160  161  162  163  164  165
#>   [29]  166  177  178  179  180  181  182  193  194  195  196  197  198  199
#>   [43]  200  201  216  226  227  231  232  233  234  235  236  246  247  248
#>   [57]  249  256  257  258  259  260  266  267  268  269  270  271  277  278
#>   [71]  279  280  281  282  283  284  285  289  290  291  292  293  294  297
#>   [85]  298  299  300  301  302  303  307  308  309  310  311  312  320  321
#>   [99]  322  323  324  333  334  335  336  337  338  339  340  341  344  345
#>  [113]  346  347  348  349  350  351  360  361  362  363  364  365  366  367
#>  [127]  379  380  381  382  383  384  385  386  387  398  399  400  401  402
#>  [141]  403  404  408  409  410  411  412  413  414  418  419  420  421  422
#>  [155]  423  424  425  433  434  435  436  437  438  439  448  449  450  451
#>  [169]  452  453  459  460  461  462  463  464  465  466  473  474  475  476
#>  [183]  477  478  479  480  484  485  486  487  488  494  495  496  497  498
#>  [197]  499  500  501  505  506  507  508  509  513  514  515  521  522  523
#>  [211]  524  527  528  529  530  531  532  533  534  535  536  537  538  539
#>  [225]  540  541  542  543  544  549  550  551  552  553  554  555  556  557
#>  [239]  558  559  560  561  562  565  566  567  568  569  570  571  576  577
#>  [253]  578  579  580  581  582  588  589  590  591  592  593  594  595  596
#>  [267]  597  598  599  601  602  603  604  605  606  607  609  610  611  612
#>  [281]  613  614  615  621  622  623  624  625  626  629  630  631  632  633
#>  [295]  635  636  637  638  639  640  641  642  643  644  645  646  647  648
#>  [309]  649  651  652  653  657  658  659  661  662  663  664  666  667  668
#>  [323]  670  671  672  673  674  676  678  679  680  684  685  687  688  689
#>  [337]  690  700  701  702  703  711  712  713  714  715  716  724  725  726
#>  [351]  727  728  735  736  737  742  743  744  745  749  750  751  755  756
#>  [365]  757  758  762  763  764  767  768  770  771  777  778  783  784  785
#>  [379]  787  789  790  792  795  796  798  807  808  810  811  812  813  814
#>  [393]  815  816  817  821  824  825  826  827  828  829  830  831  832  833
#>  [407]  843  848  849  850  851  852  853  854  855  868  869  870  871  872
#>  [421]  873  874  875  889  890  891  892  893  894  895  896  897  898  908
#>  [435]  909  910  911  912  913  914  915  916  917  929  932  933  934  935
#>  [449]  936  937  938  949  950  951  960  961  962  963  964  965  966  967
#>  [463]  968  980  981  982  983  984  985  986 1001 1002 1003 1004 1005 1006
#>  [477] 1007 1008 1024 1025 1026 1027 1028 1029 1041 1042 1043 1044 1045 1046
#>  [491] 1057 1058 1059 1060 1061 1062 1063 1070 1071 1072 1073 1074 1075 1076
#>  [505] 1086 1087 1088 1089 1090 1091 1092 1106 1107 1108 1109 1110 1111 1112
#>  [519] 1113 1124 1125 1126 1127 1128 1129 1130 1143 1144 1145 1146 1147 1148
#>  [533] 1149 1150 1163 1164 1165 1166 1167 1168 1169 1170 1179 1180 1181 1182
#>  [547] 1183 1184 1185 1186 1187 1198 1199 1200 1201 1202 1203 1204 1214 1215
#>  [561] 1216 1217 1218 1219 1229 1230 1231 1232 1233 1234 1235 1236 1245 1246
#>  [575] 1247 1248 1249 1250 1260 1261 1262 1263 1264 1265 1266 1267 1278 1279
#>  [589] 1280 1281 1282 1283 1284 1285 1298 1299 1300 1301 1302 1303 1312 1313
#>  [603] 1314 1315 1316 1317 1318 1328 1329 1330 1331 1332 1333 1334 1335 1336
#>  [617] 1346 1347 1348 1349 1350 1351 1352 1353 1354 1366 1367 1368 1369 1370
#>  [631] 1371 1372 1384 1385 1386 1387 1388 1389 1390 1391 1392 1393 1404 1405
#>  [645] 1406 1407 1408 1409 1410 1411 1412 1428 1429 1430 1431 1432 1433 1434
#>  [659] 1435 1436 1447 1448 1449 1450 1451 1452 1453 1454 1455 1465 1466 1467
#>  [673] 1468 1469 1470 1471 1472 1484 1485 1486 1487 1488 1489 1490 1491 1501
#>  [687] 1502 1503 1504 1600 1601 1602 1613 1614 1615 1616 1617 1618 1619 1629
#>  [701] 1630 1631 1632 1633 1650 1651 1652 1660 1661 1662 1663 1664 1665 1666
#>  [715] 1677 1678 1679 1680 1681 1682 1693 1694 1695 1696 1697 1698 1699 1700
#>  [729] 1701 1716 1726 1727 1731 1732 1733 1734 1735 1736 1746 1747 1748 1749
#>  [743] 1756 1757 1758 1759 1760 1766 1767 1768 1769 1770 1771 1777 1778 1779
#>  [757] 1780 1781 1782 1783 1784 1785 1789 1790 1791 1792 1793 1794 1797 1798
#>  [771] 1799 1800 1801 1802 1803 1807 1808 1809 1810 1811 1812 1820 1821 1822
#>  [785] 1823 1824 1833 1834 1835 1836 1837 1838 1839 1840 1841 1844 1845 1846
#>  [799] 1847 1848 1849 1850 1851 1860 1861 1862 1863 1864 1865 1866 1867 1879
#>  [813] 1880 1881 1882 1883 1884 1885 1886 1887 1898 1899 1900 1901 1902 1903
#>  [827] 1904 1908 1909 1910 1911 1912 1913 1914 1918 1919 1920 1921 1922 1923
#>  [841] 1924 1925 1933 1934 1935 1936 1937 1938 1939 1948 1949 1950 1951 1952
#>  [855] 1953 1959 1960 1961 1962 1963 1964 1965 1966 1973 1974 1975 1976 1977
#>  [869] 1978 1979 1980 1984 1985 1986 1987 1988 1994 1995 1996 1997 1998 1999
#>  [883] 2000 2001 2005 2006 2007 2008 2009 2013 2014 2015 2021 2022 2023 2024
#>  [897] 2027 2028 2029 2030 2031 2032 2033 2034 2035 2036 2037 2038 2039 2040
#>  [911] 2041 2042 2043 2044 2049 2050 2051 2052 2053 2054 2055 2056 2057 2058
#>  [925] 2059 2060 2061 2062 2065 2066 2067 2068 2069 2070 2071 2076 2077 2078
#>  [939] 2079 2080 2081 2082 2088 2089 2090 2091 2092 2093 2094 2095 2096 2097
#>  [953] 2098 2099 2101 2102 2103 2104 2105 2106 2107 2109 2110 2111 2112 2113
#>  [967] 2114 2115 2121 2122 2123 2124 2125 2126 2129 2130 2131 2132 2133 2135
#>  [981] 2136 2137 2138 2139 2140 2141 2142 2143 2144 2145 2146 2147 2148 2149
#>  [995] 2151 2152 2153 2157 2158 2159 2161 2162 2163 2164 2166 2167 2168 2170
#> [1009] 2171 2172 2173 2174 2176 2178 2179 2180 2184 2185 2187 2188 2189 2190
#> [1023] 2200 2201 2202 2203 2211 2212 2213 2214 2215 2216 2224 2225 2226 2227
#> [1037] 2228 2235 2236 2237 2242 2243 2244 2245 2249 2250 2251 2255 2256 2257
#> [1051] 2258 2262 2263 2264 2267 2268 2270 2271 2277 2278 2283 2284 2285 2287
#> [1065] 2289 2290 2292 2295 2296 2298 2307 2308 2310 2311 2312 2313 2314 2315
#> [1079] 2316 2317 2321 2324 2325 2326 2327 2328 2329 2330 2331 2332 2333 2343
#> [1093] 2348 2349 2350 2351 2352 2353 2354 2355 2368 2369 2370 2371 2372 2373
#> [1107] 2374 2375 2389 2390 2391 2392 2393 2394 2395 2396 2397 2398 2408 2409
#> [1121] 2410 2411 2412 2413 2414 2415 2416 2417 2429 2432 2433 2434 2435 2436
#> [1135] 2437 2438 2449 2450
#> 
#> $deep
#>    [1]    1    2    3    4    5    6    7    8    9   10   11   12   13   14
#>   [15]   15   16   17   18   19   20   21   23   24   25   26   27   28   29
#>   [29]   30   31   33   34   35   36   38   39   40   41   42   43   44   45
#>   [43]   46   48   49   50   53   54   55   56   57   58   60   61   62   63
#>   [57]   64   65   66   67   68   69   70   71   72   73   74   75   76   77
#>   [71]   78   79   80   82   83   84   86   87   88   89   90   91   92   93
#>   [85]   94   95   96   97   98   99  100  101  102  103  104  105  106  107
#>   [99]  108  109  110  111  112  113  114  115  116  117  118  119  120  121
#>  [113]  122  123  124  125  126  127  128  129  131  132  133  134  135  136
#>  [127]  137  138  139  140  141  142  143  144  145  146  147  148  149  150
#>  [141]  151  152  153  154  155  156  157  158  159  160  161  162  163  164
#>  [155]  165  166  167  168  169  170  171  172  173  174  176  177  178  179
#>  [169]  180  181  182  183  184  185  186  187  188  189  190  191  192  193
#>  [183]  194  195  196  197  198  199  200  201  202  203  204  205  206  207
#>  [197]  208  209  210  211  212  213  214  215  216  217  218  219  220  221
#>  [211]  222  223  224  225  226  227  228  230  231  232  233  234  235  236
#>  [225]  237  238  239  240  241  242  243  244  245  246  247  248  249  250
#>  [239]  251  252  253  254  255  256  257  258  259  260  261  262  263  264
#>  [253]  265  266  267  268  269  270  271  272  273  274  275  276  277  278
#>  [267]  279  280  281  282  283  284  285  286  287  288  289  290  291  292
#>  [281]  293  294  295  296  297  298  299  300  301  302  303  304  305  306
#>  [295]  307  308  309  310  311  312  313  314  315  316  317  318  319  320
#>  [309]  321  322  323  324  325  326  327  328  329  330  331  332  333  334
#>  [323]  335  336  337  338  339  340  341  342  343  344  345  346  347  348
#>  [337]  349  350  351  352  353  354  355  356  357  358  359  360  361  362
#>  [351]  363  364  365  366  367  368  369  370  371  372  373  374  375  376
#>  [365]  377  378  379  380  381  382  383  384  385  386  387  388  389  390
#>  [379]  391  392  393  394  395  396  397  398  399  400  401  402  403  404
#>  [393]  405  406  407  408  409  410  411  412  413  414  415  416  417  418
#>  [407]  419  420  421  422  423  424  425  426  427  428  429  430  431  432
#>  [421]  433  434  435  436  437  438  439  440  441  442  443  444  445  446
#>  [435]  447  448  449  450  451  452  453  454  455  456  457  458  459  460
#>  [449]  461  462  463  464  465  466  467  468  469  470  471  472  473  474
#>  [463]  475  476  477  478  479  480  481  482  483  484  485  486  487  488
#>  [477]  489  490  491  492  493  494  495  496  497  498  499  500  501  502
#>  [491]  503  504  505  506  507  508  509  510  511  512  513  514  515  516
#>  [505]  517  518  519  520  521  522  523  524  525  526  527  528  529  530
#>  [519]  531  532  533  534  535  536  537  538  539  540  541  542  543  544
#>  [533]  545  546  547  548  549  550  551  552  553  554  555  556  557  558
#>  [547]  559  560  561  562  563  564  565  566  567  568  569  570  571  572
#>  [561]  573  574  575  576  577  578  579  580  581  582  583  584  585  586
#>  [575]  587  588  589  590  591  592  593  594  595  596  597  598  599  600
#>  [589]  601  602  603  604  605  606  607  608  609  610  611  612  613  614
#>  [603]  615  616  617  618  619  620  621  622  623  624  625  626  627  628
#>  [617]  629  630  631  632  633  634  635  636  637  638  639  640  641  642
#>  [631]  643  644  645  646  647  648  649  650  651  652  653  654  655  656
#>  [645]  657  658  659  660  661  662  663  664  665  666  667  668  669  670
#>  [659]  671  672  673  674  675  676  677  678  679  680  681  682  683  684
#>  [673]  685  686  687  688  689  690  691  692  693  694  695  696  697  698
#>  [687]  699  700  701  702  703  704  705  706  707  708  709  710  711  712
#>  [701]  713  714  715  716  717  718  719  720  721  722  723  724  725  726
#>  [715]  727  728  729  730  731  732  733  734  735  736  737  738  739  740
#>  [729]  741  742  743  744  745  746  747  748  749  750  751  752  753  754
#>  [743]  755  756  757  758  759  760  761  762  763  764  765  766  767  768
#>  [757]  769  770  771  772  773  774  775  776  777  778  779  780  781  782
#>  [771]  783  784  785  786  787  788  789  790  791  792  793  794  795  796
#>  [785]  797  798  799  800  801  802  803  804  805  806  807  808  809  810
#>  [799]  811  812  813  814  815  816  817  818  819  820  821  822  823  824
#>  [813]  825  826  827  828  829  830  831  832  833  834  835  836  837  838
#>  [827]  839  840  841  842  843  844  845  846  847  848  849  850  851  852
#>  [841]  853  854  855  856  857  858  859  860  861  862  863  864  865  866
#>  [855]  867  868  869  870  871  872  873  874  875  876  877  878  879  880
#>  [869]  881  882  883  884  885  886  887  888  889  890  891  892  893  894
#>  [883]  895  896  897  898  899  900  901  902  903  904  905  906  907  908
#>  [897]  909  910  911  912  913  914  915  916  917  918  919  920  921  922
#>  [911]  923  924  925  926  927  928  929  930  931  932  933  934  935  936
#>  [925]  937  938  939  940  941  942  943  944  945  946  947  948  949  950
#>  [939]  951  952  953  954  955  956  957  958  959  960  961  962  963  964
#>  [953]  965  966  967  968  969  970  971  972  973  974  975  976  977  978
#>  [967]  979  980  981  982  983  984  985  986  987  988  989  990  991  992
#>  [981]  993  994  995  996  997  998  999 1000 1001 1002 1003 1004 1005 1006
#>  [995] 1007 1008 1009 1010 1011 1012 1013 1014 1015 1016 1017 1018 1019 1020
#> [1009] 1021 1022 1023 1024 1025 1026 1027 1028 1029 1030 1031 1032 1033 1034
#> [1023] 1035 1036 1037 1038 1039 1040 1041 1042 1043 1044 1045 1046 1047 1048
#> [1037] 1049 1050 1051 1052 1053 1054 1055 1056 1057 1058 1059 1060 1061 1062
#> [1051] 1063 1064 1065 1066 1067 1068 1069 1070 1071 1072 1073 1074 1075 1076
#> [1065] 1077 1078 1079 1080 1081 1082 1083 1084 1085 1086 1087 1088 1089 1090
#> [1079] 1091 1092 1093 1094 1095 1096 1097 1098 1099 1100 1101 1102 1103 1104
#> [1093] 1105 1106 1107 1108 1109 1110 1111 1112 1113 1114 1115 1116 1117 1118
#> [1107] 1119 1120 1121 1122 1123 1124 1125 1126 1127 1128 1129 1130 1131 1132
#> [1121] 1133 1134 1135 1136 1137 1138 1139 1140 1141 1142 1143 1144 1145 1146
#> [1135] 1147 1148 1149 1150 1151 1152 1153 1154 1155 1156 1157 1158 1159 1160
#> [1149] 1161 1162 1163 1164 1165 1166 1167 1168 1169 1170 1171 1172 1173 1174
#> [1163] 1175 1176 1177 1178 1179 1180 1181 1182 1183 1184 1185 1186 1187 1188
#> [1177] 1189 1190 1191 1192 1193 1194 1195 1196 1197 1198 1199 1200 1201 1202
#> [1191] 1203 1204 1205 1206 1207 1208 1209 1210 1211 1212 1213 1214 1215 1216
#> [1205] 1217 1218 1219 1220 1221 1222 1223 1224 1225 1226 1227 1228 1229 1230
#> [1219] 1231 1232 1233 1234 1235 1236 1237 1238 1239 1240 1241 1242 1243 1244
#> [1233] 1245 1246 1247 1248 1249 1250 1251 1252 1253 1254 1255 1256 1257 1258
#> [1247] 1259 1260 1261 1262 1263 1264 1265 1266 1267 1268 1269 1270 1271 1272
#> [1261] 1273 1274 1275 1276 1277 1278 1279 1280 1281 1282 1283 1284 1285 1286
#> [1275] 1287 1288 1289 1290 1291 1292 1293 1294 1295 1296 1297 1298 1299 1300
#> [1289] 1301 1302 1303 1304 1305 1306 1307 1308 1309 1310 1311 1312 1313 1314
#> [1303] 1315 1316 1317 1318 1319 1320 1321 1322 1323 1324 1325 1326 1327 1328
#> [1317] 1329 1330 1331 1332 1333 1334 1335 1336 1337 1338 1339 1340 1341 1342
#> [1331] 1343 1344 1345 1346 1347 1348 1349 1350 1351 1352 1353 1354 1355 1356
#> [1345] 1357 1358 1359 1360 1361 1362 1363 1364 1365 1366 1367 1368 1369 1370
#> [1359] 1371 1372 1373 1374 1375 1376 1377 1378 1379 1380 1381 1382 1383 1384
#> [1373] 1385 1386 1387 1388 1389 1390 1391 1392 1393 1394 1395 1396 1397 1398
#> [1387] 1399 1400 1401 1402 1403 1404 1405 1406 1407 1408 1409 1410 1411 1412
#> [1401] 1413 1414 1415 1416 1417 1418 1419 1420 1421 1422 1423 1424 1425 1426
#> [1415] 1427 1428 1429 1430 1431 1432 1433 1434 1435 1436 1437 1438 1439 1440
#> [1429] 1441 1442 1443 1444 1445 1446 1447 1448 1449 1450 1451 1452 1453 1454
#> [1443] 1455 1456 1457 1458 1459 1460 1461 1462 1463 1464 1465 1466 1467 1468
#> [1457] 1469 1470 1471 1472 1473 1474 1475 1476 1477 1478 1479 1480 1481 1482
#> [1471] 1483 1484 1485 1486 1487 1488 1489 1490 1491 1492 1493 1494 1495 1496
#> [1485] 1497 1498 1499 1500 1501 1502 1503 1504 1505 1506 1507 1508 1509 1510
#> [1499] 1511 1512 1513 1514 1515 1516 1517 1518 1519 1520 1521 1523 1524 1525
#> [1513] 1526 1527 1528 1529 1530 1531 1533 1534 1535 1536 1538 1539 1540 1541
#> [1527] 1542 1543 1544 1545 1546 1548 1549 1550 1553 1554 1555 1556 1557 1558
#> [1541] 1560 1561 1562 1563 1564 1565 1566 1567 1568 1569 1570 1571 1572 1573
#> [1555] 1574 1575 1576 1577 1578 1579 1580 1582 1583 1584 1586 1587 1588 1589
#> [1569] 1590 1591 1592 1593 1594 1595 1596 1597 1598 1599 1600 1601 1602 1603
#> [1583] 1604 1605 1606 1607 1608 1609 1610 1611 1612 1613 1614 1615 1616 1617
#> [1597] 1618 1619 1620 1621 1622 1623 1624 1625 1626 1627 1628 1629 1631 1632
#> [1611] 1633 1634 1635 1636 1637 1638 1639 1640 1641 1642 1643 1644 1645 1646
#> [1625] 1647 1648 1649 1650 1651 1652 1653 1654 1655 1656 1657 1658 1659 1660
#> [1639] 1661 1662 1663 1664 1665 1666 1667 1668 1669 1670 1671 1672 1673 1674
#> [1653] 1676 1677 1678 1679 1680 1681 1682 1683 1684 1685 1686 1687 1688 1689
#> [1667] 1690 1691 1692 1693 1694 1695 1696 1697 1698 1699 1700 1701 1702 1703
#> [1681] 1704 1705 1706 1707 1708 1709 1710 1711 1712 1713 1714 1715 1716 1717
#> [1695] 1718 1719 1720 1721 1722 1723 1724 1725 1726 1727 1728 1730 1731 1732
#> [1709] 1733 1734 1735 1736 1737 1738 1739 1740 1741 1742 1743 1744 1745 1746
#> [1723] 1747 1748 1749 1750 1751 1752 1753 1754 1755 1756 1757 1758 1759 1760
#> [1737] 1761 1762 1763 1764 1765 1766 1767 1768 1769 1770 1771 1772 1773 1774
#> [1751] 1775 1776 1777 1778 1779 1780 1781 1782 1783 1784 1785 1786 1787 1788
#> [1765] 1789 1790 1791 1792 1793 1794 1795 1796 1797 1798 1799 1800 1801 1802
#> [1779] 1803 1804 1805 1806 1807 1808 1809 1810 1811 1812 1813 1814 1815 1816
#> [1793] 1817 1818 1819 1820 1821 1822 1823 1824 1825 1826 1827 1828 1829 1830
#> [1807] 1831 1832 1833 1834 1835 1836 1837 1838 1839 1840 1841 1842 1843 1844
#> [1821] 1845 1846 1847 1848 1849 1850 1851 1852 1853 1854 1855 1856 1857 1858
#> [1835] 1859 1860 1861 1862 1863 1864 1865 1866 1867 1868 1869 1870 1871 1872
#> [1849] 1873 1874 1875 1876 1877 1878 1879 1880 1881 1882 1883 1884 1885 1886
#> [1863] 1887 1888 1889 1890 1891 1892 1893 1894 1895 1896 1897 1898 1899 1900
#> [1877] 1901 1902 1903 1904 1905 1906 1907 1908 1909 1910 1911 1912 1913 1914
#> [1891] 1915 1916 1917 1918 1919 1920 1921 1922 1923 1924 1925 1926 1927 1928
#> [1905] 1929 1930 1931 1932 1933 1934 1935 1936 1937 1938 1939 1940 1941 1942
#> [1919] 1943 1944 1945 1946 1947 1948 1949 1950 1951 1952 1953 1954 1955 1956
#> [1933] 1957 1958 1959 1960 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970
#> [1947] 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984
#> [1961] 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998
#> [1975] 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012
#> [1989] 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026
#> [2003] 2027 2028 2029 2030 2031 2032 2033 2034 2035 2036 2037 2038 2039 2040
#> [2017] 2041 2042 2043 2044 2045 2046 2047 2048 2049 2050 2051 2052 2053 2054
#> [2031] 2055 2056 2057 2058 2059 2060 2061 2062 2063 2064 2065 2066 2067 2068
#> [2045] 2069 2070 2071 2072 2073 2074 2075 2076 2077 2078 2079 2080 2081 2082
#> [2059] 2083 2084 2085 2086 2087 2088 2089 2090 2091 2092 2093 2094 2095 2096
#> [2073] 2097 2098 2099 2100 2101 2102 2103 2104 2105 2106 2107 2108 2109 2110
#> [2087] 2111 2112 2113 2114 2115 2116 2117 2118 2119 2120 2121 2122 2123 2124
#> [2101] 2125 2126 2127 2128 2129 2130 2131 2132 2133 2134 2135 2136 2137 2138
#> [2115] 2139 2140 2141 2142 2143 2144 2145 2146 2147 2148 2149 2150 2151 2152
#> [2129] 2153 2154 2155 2156 2157 2158 2159 2160 2161 2162 2163 2164 2165 2166
#> [2143] 2167 2168 2169 2170 2171 2172 2173 2174 2175 2176 2177 2178 2179 2180
#> [2157] 2181 2182 2183 2184 2185 2186 2187 2188 2189 2190 2191 2192 2193 2194
#> [2171] 2195 2196 2197 2198 2199 2200 2201 2202 2203 2204 2205 2206 2207 2208
#> [2185] 2209 2210 2211 2212 2213 2214 2215 2216 2217 2218 2219 2220 2221 2222
#> [2199] 2223 2224 2225 2226 2227 2228 2229 2230 2231 2232 2233 2234 2235 2236
#> [2213] 2237 2238 2239 2240 2241 2242 2243 2244 2245 2246 2247 2248 2249 2250
#> [2227] 2251 2252 2253 2254 2255 2256 2257 2258 2259 2260 2261 2262 2263 2264
#> [2241] 2265 2266 2267 2268 2269 2270 2271 2272 2273 2274 2275 2276 2277 2278
#> [2255] 2279 2280 2281 2282 2283 2284 2285 2286 2287 2288 2289 2290 2291 2292
#> [2269] 2293 2294 2295 2296 2297 2298 2299 2300 2301 2302 2303 2304 2305 2306
#> [2283] 2307 2308 2309 2310 2311 2312 2313 2314 2315 2316 2317 2318 2319 2320
#> [2297] 2321 2322 2323 2324 2325 2326 2327 2328 2329 2330 2331 2332 2333 2334
#> [2311] 2335 2336 2337 2338 2339 2340 2341 2342 2343 2344 2345 2346 2347 2348
#> [2325] 2349 2350 2351 2352 2353 2354 2355 2356 2357 2358 2359 2360 2361 2362
#> [2339] 2363 2364 2365 2366 2367 2368 2369 2370 2371 2372 2373 2374 2375 2376
#> [2353] 2377 2378 2379 2380 2381 2382 2383 2384 2385 2386 2387 2388 2389 2390
#> [2367] 2391 2392 2393 2394 2395 2396 2397 2398 2399 2400 2401 2402 2403 2404
#> [2381] 2405 2406 2407 2408 2409 2410 2411 2412 2413 2414 2415 2416 2417 2418
#> [2395] 2419 2420 2421 2422 2423 2424 2425 2426 2427 2428 2429 2430 2431 2432
#> [2409] 2433 2434 2435 2436 2437 2438 2439 2440 2441 2442 2443 2444 2445 2446
#> [2423] 2447 2448 2449 2450
#> 
#> $rectangle_type
#> integer(0)
#> 
#> $rectangle_lat
#> integer(0)
#> 
#> $rectangle_lon
#> integer(0)
#> 
#> $c_square
#> integer(0)
#> 
#> $species
#> integer(0)
#> 
#> $totwghtlandg
#> integer(0)
#> 
#> $totvallandg
#> integer(0)
#> 
#> $confidential
#>    [1]    1    2    3    4    5    6    7    8    9   10   11   12   13   14
#>   [15]   15   16   17   18   19   20   21   22   23   24   25   26   27   28
#>   [29]   29   30   31   32   33   34   35   36   37   38   39   40   41   42
#>   [43]   43   44   45   46   47   48   49   50   51   52   53   54   55   56
#>   [57]   57   58   59   60   61   62   63   64   65   66   67   68   69   70
#>   [71]   71   72   73   74   75   76   77   78   79   80   81   82   83   84
#>   [85]   85   86   87   88   89   90   91   92   93   94   95   96   97   98
#>   [99]   99  100  101  102  103  104  105  106  107  108  109  110  111  112
#>  [113]  113  114  115  116  117  118  119  120  121  122  123  124  125  126
#>  [127]  127  128  129  130  131  132  133  134  135  136  137  138  139  140
#>  [141]  141  142  143  144  145  146  147  148  149  150  151  152  153  154
#>  [155]  155  156  157  158  159  160  161  162  163  164  165  166  167  168
#>  [169]  169  170  171  172  173  174  175  176  177  178  179  180  181  182
#>  [183]  183  184  185  186  187  188  189  190  191  192  193  194  195  196
#>  [197]  197  198  199  200  201  202  203  204  205  206  207  208  209  210
#>  [211]  211  212  213  214  215  216  217  218  219  220  221  222  223  224
#>  [225]  225  226  227  228  229  230  231  232  233  234  235  236  237  238
#>  [239]  239  240  241  242  243  244  245  246  247  248  249  250  251  252
#>  [253]  253  254  255  256  257  258  259  260  261  262  263  264  265  266
#>  [267]  267  268  269  270  271  272  273  274  275  276  277  278  279  280
#>  [281]  281  282  283  284  285  286  287  288  289  290  291  292  293  294
#>  [295]  295  296  297  298  299  300  301  302  303  304  305  306  307  308
#>  [309]  309  310  311  312  313  314  315  316  317  318  319  320  321  322
#>  [323]  323  324  325  326  327  328  329  330  331  332  333  334  335  336
#>  [337]  337  338  339  340  341  342  343  344  345  346  347  348  349  350
#>  [351]  351  352  353  354  355  356  357  358  359  360  361  362  363  364
#>  [365]  365  366  367  368  369  370  371  372  373  374  375  376  377  378
#>  [379]  379  380  381  382  383  384  385  386  387  388  389  390  391  392
#>  [393]  393  394  395  396  397  398  399  400  401  402  403  404  405  406
#>  [407]  407  408  409  410  411  412  413  414  415  416  417  418  419  420
#>  [421]  421  422  423  424  425  426  427  428  429  430  431  432  433  434
#>  [435]  435  436  437  438  439  440  441  442  443  444  445  446  447  448
#>  [449]  449  450  451  452  453  454  455  456  457  458  459  460  461  462
#>  [463]  463  464  465  466  467  468  469  470  471  472  473  474  475  476
#>  [477]  477  478  479  480  481  482  483  484  485  486  487  488  489  490
#>  [491]  491  492  493  494  495  496  497  498  499  500  501  502  503  504
#>  [505]  505  506  507  508  509  510  511  512  513  514  515  516  517  518
#>  [519]  519  520  521  522  523  524  525  526  527  528  529  530  531  532
#>  [533]  533  534  535  536  537  538  539  540  541  542  543  544  545  546
#>  [547]  547  548  549  550  551  552  553  554  555  556  557  558  559  560
#>  [561]  561  562  563  564  565  566  567  568  569  570  571  572  573  574
#>  [575]  575  576  577  578  579  580  581  582  583  584  585  586  587  588
#>  [589]  589  590  591  592  593  594  595  596  597  598  599  600  601  602
#>  [603]  603  604  605  606  607  608  609  610  611  612  613  614  615  616
#>  [617]  617  618  619  620  621  622  623  624  625  626  627  628  629  630
#>  [631]  631  632  633  634  635  636  637  638  639  640  641  642  643  644
#>  [645]  645  646  647  648  649  650  651  652  653  654  655  656  657  658
#>  [659]  659  660  661  662  663  664  665  666  667  668  669  670  671  672
#>  [673]  673  674  675  676  677  678  679  680  681  682  683  684  685  686
#>  [687]  687  688  689  690  691  692  693  694  695  696  697  698  699  700
#>  [701]  701  702  703  704  705  706  707  708  709  710  711  712  713  714
#>  [715]  715  716  717  718  719  720  721  722  723  724  725  726  727  728
#>  [729]  729  730  731  732  733  734  735  736  737  738  739  740  741  742
#>  [743]  743  744  745  746  747  748  749  750  751  752  753  754  755  756
#>  [757]  757  758  759  760  761  762  763  764  765  766  767  768  769  770
#>  [771]  771  772  773  774  775  776  777  778  779  780  781  782  783  784
#>  [785]  785  786  787  788  789  790  791  792  793  794  795  796  797  798
#>  [799]  799  800  801  802  803  804  805  806  807  808  809  810  811  812
#>  [813]  813  814  815  816  817  818  819  820  821  822  823  824  825  826
#>  [827]  827  828  829  830  831  832  833  834  835  836  837  838  839  840
#>  [841]  841  842  843  844  845  846  847  848  849  850  851  852  853  854
#>  [855]  855  856  857  858  859  860  861  862  863  864  865  866  867  868
#>  [869]  869  870  871  872  873  874  875  876  877  878  879  880  881  882
#>  [883]  883  884  885  886  887  888  889  890  891  892  893  894  895  896
#>  [897]  897  898  899  900  901  902  903  904  905  906  907  908  909  910
#>  [911]  911  912  913  914  915  916  917  918  919  920  921  922  923  924
#>  [925]  925  926  927  928  929  930  931  932  933  934  935  936  937  938
#>  [939]  939  940  941  942  943  944  945  946  947  948  949  950  951  952
#>  [953]  953  954  955  956  957  958  959  960  961  962  963  964  965  966
#>  [967]  967  968  969  970  971  972  973  974  975  976  977  978  979  980
#>  [981]  981  982  983  984  985  986  987  988  989  990  991  992  993  994
#>  [995]  995  996  997  998  999 1000 1001 1002 1003 1004 1005 1006 1007 1008
#> [1009] 1009 1010 1011 1012 1013 1014 1015 1016 1017 1018 1019 1020 1021 1022
#> [1023] 1023 1024 1025 1026 1027 1028 1029 1030 1031 1032 1033 1034 1035 1036
#> [1037] 1037 1038 1039 1040 1041 1042 1043 1044 1045 1046 1047 1048 1049 1050
#> [1051] 1051 1052 1053 1054 1055 1056 1057 1058 1059 1060 1061 1062 1063 1064
#> [1065] 1065 1066 1067 1068 1069 1070 1071 1072 1073 1074 1075 1076 1077 1078
#> [1079] 1079 1080 1081 1082 1083 1084 1085 1086 1087 1088 1089 1090 1091 1092
#> [1093] 1093 1094 1095 1096 1097 1098 1099 1100 1101 1102 1103 1104 1105 1106
#> [1107] 1107 1108 1109 1110 1111 1112 1113 1114 1115 1116 1117 1118 1119 1120
#> [1121] 1121 1122 1123 1124 1125 1126 1127 1128 1129 1130 1131 1132 1133 1134
#> [1135] 1135 1136 1137 1138 1139 1140 1141 1142 1143 1144 1145 1146 1147 1148
#> [1149] 1149 1150 1151 1152 1153 1154 1155 1156 1157 1158 1159 1160 1161 1162
#> [1163] 1163 1164 1165 1166 1167 1168 1169 1170 1171 1172 1173 1174 1175 1176
#> [1177] 1177 1178 1179 1180 1181 1182 1183 1184 1185 1186 1187 1188 1189 1190
#> [1191] 1191 1192 1193 1194 1195 1196 1197 1198 1199 1200 1201 1202 1203 1204
#> [1205] 1205 1206 1207 1208 1209 1210 1211 1212 1213 1214 1215 1216 1217 1218
#> [1219] 1219 1220 1221 1222 1223 1224 1225 1226 1227 1228 1229 1230 1231 1232
#> [1233] 1233 1234 1235 1236 1237 1238 1239 1240 1241 1242 1243 1244 1245 1246
#> [1247] 1247 1248 1249 1250 1251 1252 1253 1254 1255 1256 1257 1258 1259 1260
#> [1261] 1261 1262 1263 1264 1265 1266 1267 1268 1269 1270 1271 1272 1273 1274
#> [1275] 1275 1276 1277 1278 1279 1280 1281 1282 1283 1284 1285 1286 1287 1288
#> [1289] 1289 1290 1291 1292 1293 1294 1295 1296 1297 1298 1299 1300 1301 1302
#> [1303] 1303 1304 1305 1306 1307 1308 1309 1310 1311 1312 1313 1314 1315 1316
#> [1317] 1317 1318 1319 1320 1321 1322 1323 1324 1325 1326 1327 1328 1329 1330
#> [1331] 1331 1332 1333 1334 1335 1336 1337 1338 1339 1340 1341 1342 1343 1344
#> [1345] 1345 1346 1347 1348 1349 1350 1351 1352 1353 1354 1355 1356 1357 1358
#> [1359] 1359 1360 1361 1362 1363 1364 1365 1366 1367 1368 1369 1370 1371 1372
#> [1373] 1373 1374 1375 1376 1377 1378 1379 1380 1381 1382 1383 1384 1385 1386
#> [1387] 1387 1388 1389 1390 1391 1392 1393 1394 1395 1396 1397 1398 1399 1400
#> [1401] 1401 1402 1403 1404 1405 1406 1407 1408 1409 1410 1411 1412 1413 1414
#> [1415] 1415 1416 1417 1418 1419 1420 1421 1422 1423 1424 1425 1426 1427 1428
#> [1429] 1429 1430 1431 1432 1433 1434 1435 1436 1437 1438 1439 1440 1441 1442
#> [1443] 1443 1444 1445 1446 1447 1448 1449 1450 1451 1452 1453 1454 1455 1456
#> [1457] 1457 1458 1459 1460 1461 1462 1463 1464 1465 1466 1467 1468 1469 1470
#> [1471] 1471 1472 1473 1474 1475 1476 1477 1478 1479 1480 1481 1482 1483 1484
#> [1485] 1485 1486 1487 1488 1489 1490 1491 1492 1493 1494 1495 1496 1497 1498
#> [1499] 1499 1500 1501 1502 1503 1504 1505 1506 1507 1508 1509 1510 1511 1512
#> [1513] 1513 1514 1515 1516 1517 1518 1519 1520 1521 1522 1523 1524 1525 1526
#> [1527] 1527 1528 1529 1530 1531 1532 1533 1534 1535 1536 1537 1538 1539 1540
#> [1541] 1541 1542 1543 1544 1545 1546 1547 1548 1549 1550 1551 1552 1553 1554
#> [1555] 1555 1556 1557 1558 1559 1560 1561 1562 1563 1564 1565 1566 1567 1568
#> [1569] 1569 1570 1571 1572 1573 1574 1575 1576 1577 1578 1579 1580 1581 1582
#> [1583] 1583 1584 1585 1586 1587 1588 1589 1590 1591 1592 1593 1594 1595 1596
#> [1597] 1597 1598 1599 1600 1601 1602 1603 1604 1605 1606 1607 1608 1609 1610
#> [1611] 1611 1612 1613 1614 1615 1616 1617 1618 1619 1620 1621 1622 1623 1624
#> [1625] 1625 1626 1627 1628 1629 1630 1631 1632 1633 1634 1635 1636 1637 1638
#> [1639] 1639 1640 1641 1642 1643 1644 1645 1646 1647 1648 1649 1650 1651 1652
#> [1653] 1653 1654 1655 1656 1657 1658 1659 1660 1661 1662 1663 1664 1665 1666
#> [1667] 1667 1668 1669 1670 1671 1672 1673 1674 1675 1676 1677 1678 1679 1680
#> [1681] 1681 1682 1683 1684 1685 1686 1687 1688 1689 1690 1691 1692 1693 1694
#> [1695] 1695 1696 1697 1698 1699 1700 1701 1702 1703 1704 1705 1706 1707 1708
#> [1709] 1709 1710 1711 1712 1713 1714 1715 1716 1717 1718 1719 1720 1721 1722
#> [1723] 1723 1724 1725 1726 1727 1728 1729 1730 1731 1732 1733 1734 1735 1736
#> [1737] 1737 1738 1739 1740 1741 1742 1743 1744 1745 1746 1747 1748 1749 1750
#> [1751] 1751 1752 1753 1754 1755 1756 1757 1758 1759 1760 1761 1762 1763 1764
#> [1765] 1765 1766 1767 1768 1769 1770 1771 1772 1773 1774 1775 1776 1777 1778
#> [1779] 1779 1780 1781 1782 1783 1784 1785 1786 1787 1788 1789 1790 1791 1792
#> [1793] 1793 1794 1795 1796 1797 1798 1799 1800 1801 1802 1803 1804 1805 1806
#> [1807] 1807 1808 1809 1810 1811 1812 1813 1814 1815 1816 1817 1818 1819 1820
#> [1821] 1821 1822 1823 1824 1825 1826 1827 1828 1829 1830 1831 1832 1833 1834
#> [1835] 1835 1836 1837 1838 1839 1840 1841 1842 1843 1844 1845 1846 1847 1848
#> [1849] 1849 1850 1851 1852 1853 1854 1855 1856 1857 1858 1859 1860 1861 1862
#> [1863] 1863 1864 1865 1866 1867 1868 1869 1870 1871 1872 1873 1874 1875 1876
#> [1877] 1877 1878 1879 1880 1881 1882 1883 1884 1885 1886 1887 1888 1889 1890
#> [1891] 1891 1892 1893 1894 1895 1896 1897 1898 1899 1900 1901 1902 1903 1904
#> [1905] 1905 1906 1907 1908 1909 1910 1911 1912 1913 1914 1915 1916 1917 1918
#> [1919] 1919 1920 1921 1922 1923 1924 1925 1926 1927 1928 1929 1930 1931 1932
#> [1933] 1933 1934 1935 1936 1937 1938 1939 1940 1941 1942 1943 1944 1945 1946
#> [1947] 1947 1948 1949 1950 1951 1952 1953 1954 1955 1956 1957 1958 1959 1960
#> [1961] 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974
#> [1975] 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988
#> [1989] 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002
#> [2003] 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016
#> [2017] 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026 2027 2028 2029 2030
#> [2031] 2031 2032 2033 2034 2035 2036 2037 2038 2039 2040 2041 2042 2043 2044
#> [2045] 2045 2046 2047 2048 2049 2050 2051 2052 2053 2054 2055 2056 2057 2058
#> [2059] 2059 2060 2061 2062 2063 2064 2065 2066 2067 2068 2069 2070 2071 2072
#> [2073] 2073 2074 2075 2076 2077 2078 2079 2080 2081 2082 2083 2084 2085 2086
#> [2087] 2087 2088 2089 2090 2091 2092 2093 2094 2095 2096 2097 2098 2099 2100
#> [2101] 2101 2102 2103 2104 2105 2106 2107 2108 2109 2110 2111 2112 2113 2114
#> [2115] 2115 2116 2117 2118 2119 2120 2121 2122 2123 2124 2125 2126 2127 2128
#> [2129] 2129 2130 2131 2132 2133 2134 2135 2136 2137 2138 2139 2140 2141 2142
#> [2143] 2143 2144 2145 2146 2147 2148 2149 2150 2151 2152 2153 2154 2155 2156
#> [2157] 2157 2158 2159 2160 2161 2162 2163 2164 2165 2166 2167 2168 2169 2170
#> [2171] 2171 2172 2173 2174 2175 2176 2177 2178 2179 2180 2181 2182 2183 2184
#> [2185] 2185 2186 2187 2188 2189 2190 2191 2192 2193 2194 2195 2196 2197 2198
#> [2199] 2199 2200 2201 2202 2203 2204 2205 2206 2207 2208 2209 2210 2211 2212
#> [2213] 2213 2214 2215 2216 2217 2218 2219 2220 2221 2222 2223 2224 2225 2226
#> [2227] 2227 2228 2229 2230 2231 2232 2233 2234 2235 2236 2237 2238 2239 2240
#> [2241] 2241 2242 2243 2244 2245 2246 2247 2248 2249 2250 2251 2252 2253 2254
#> [2255] 2255 2256 2257 2258 2259 2260 2261 2262 2263 2264 2265 2266 2267 2268
#> [2269] 2269 2270 2271 2272 2273 2274 2275 2276 2277 2278 2279 2280 2281 2282
#> [2283] 2283 2284 2285 2286 2287 2288 2289 2290 2291 2292 2293 2294 2295 2296
#> [2297] 2297 2298 2299 2300 2301 2302 2303 2304 2305 2306 2307 2308 2309 2310
#> [2311] 2311 2312 2313 2314 2315 2316 2317 2318 2319 2320 2321 2322 2323 2324
#> [2325] 2325 2326 2327 2328 2329 2330 2331 2332 2333 2334 2335 2336 2337 2338
#> [2339] 2339 2340 2341 2342 2343 2344 2345 2346 2347 2348 2349 2350 2351 2352
#> [2353] 2353 2354 2355 2356 2357 2358 2359 2360 2361 2362 2363 2364 2365 2366
#> [2367] 2367 2368 2369 2370 2371 2372 2373 2374 2375 2376 2377 2378 2379 2380
#> [2381] 2381 2382 2383 2384 2385 2386 2387 2388 2389 2390 2391 2392 2393 2394
#> [2395] 2395 2396 2397 2398 2399 2400 2401 2402 2403 2404 2405 2406 2407 2408
#> [2409] 2409 2410 2411 2412 2413 2414 2415 2416 2417 2418 2419 2420 2421 2422
#> [2423] 2423 2424 2425 2426 2427 2428 2429 2430 2431 2432 2433 2434 2435 2436
#> [2437] 2437 2438 2439 2440 2441 2442 2443 2444 2445 2446 2447 2448 2449 2450
```

### Check duplicated records in FDI H table

The function `check_RD_FDI_H` check the presence of duplicated records. In particular, it checks whether the combination of the first 15 columns generates duplicate records. The function returns the indices of the duplicated rows.


```r
h_spatial_land <- rbind(fdi_h_spatial_landings,fdi_h_spatial_landings[1,])
check_RD_FDI_H(h_spatial_land)
#> 22 record/s duplicated
#>  [1]  853  881  887  888  923  924 1091 1111 1122 1161 1325 1371 1389 1420 1421
#> [16] 1422 1453 1479 1481 1499 2366 2451
```

## Table I

### Check empty fields in FDI I table

The function `check_EF_FDI_I` checks the presence of not allowed empty data in the given table, according to the 'Fisheries Dependent Information data call 2021 - Annex 1'. A list is returned by the function. The first list's object is a vector containing the number of NA for each reference column. 


```r
check_EF_FDI_I(fdi_i_spatial_effort,verbose=FALSE)[[1]]
#>           country              year           quarter     vessel_length 
#>                 0                 0                 0                 0 
#>      fishing_tech         gear_type target_assemblage   mesh_size_range 
#>                 0                 0               446                 0 
#>            metier      supra_region        sub_region     eez_indicator 
#>                 0                 0                 0                 0 
#>     geo_indicator       specon_tech              deep    rectangle_type 
#>                 0              1138              2436                 0 
#>     rectangle_lat     rectangle_lon          c_square       totfishdays 
#>                 0                 0                 0                 0 
#>      confidential 
#>                 0
```

The second list's object gives the index of each NA in the reference column.


```r
check_EF_FDI_I(fdi_i_spatial_effort,verbose=FALSE)[[2]]
#> $country
#> integer(0)
#> 
#> $year
#> integer(0)
#> 
#> $quarter
#> integer(0)
#> 
#> $vessel_length
#> integer(0)
#> 
#> $fishing_tech
#> integer(0)
#> 
#> $gear_type
#> integer(0)
#> 
#> $target_assemblage
#>   [1]    4    5    6    7    8    9   10   11   12   13   14   15   16   17   18
#>  [16]   19   20   21   22   23   24   25   26   27   28   29  447  448  449  450
#>  [31]  451  452  453  454  455  456  457  458  459  460  461  462  463  464  465
#>  [46]  466  467  468  469  470  471  472  473  474  475  476  477  478  479  480
#>  [61]  481  482  483  484  485  486  487  488  489  490  491  492  493  494  495
#>  [76]  496  497  498  499  500  501  502  503  504  505  506  507  508  509  510
#>  [91]  511  512  513  514  515  516  517  518  519  520  521  522  523  524  525
#> [106]  526  527  528  529  530  657  658  659  660  661  662  663  664  665  666
#> [121]  667  668  669  670  671  672  673  674  675  676  677  678  679  680  681
#> [136]  682  683  684  685  686  687 1730 1731 1732 1733 1734 1735 1736 1737 1738
#> [151] 1739 1740 1741 1742 1743 1744 1745 1746 1747 1748 1749 1750 1751 1752 1753
#> [166] 1754 1755 1756 1757 1758 1759 1760 1761 1762 1763 1764 1765 1766 1767 1768
#> [181] 1769 1770 1771 1772 1773 1774 1775 1776 1777 1778 1779 1780 1781 1782 1783
#> [196] 1784 1785 1786 1787 1788 1789 1790 1791 1792 1793 1794 1795 1796 1797 1798
#> [211] 1799 1800 1801 1802 1803 1804 1805 1806 1807 1808 1809 1810 1811 1812 1813
#> [226] 1814 1815 1816 1817 1818 1819 1820 1821 1822 1823 1824 1825 1826 1827 1828
#> [241] 1829 1830 1831 1832 1833 1834 1868 1869 1870 1871 1872 1873 1874 1875 1876
#> [256] 1877 1878 1879 1880 1881 1882 1883 1884 1885 1886 1887 1888 1909 1910 1911
#> [271] 1912 2082 2083 2084 2085 2086 2087 2088 2089 2090 2091 2092 2093 2133 2134
#> [286] 2135 2136 2137 2138 2139 2140 2141 2142 2143 2144 2145 2146 2147 2148 2149
#> [301] 2150 2151 2152 2153 2154 2155 2156 2312 2313 2314 2315 2316 2317 2318 2319
#> [316] 2320 2321 2322 2323 2324 2325 2326 2327 2328 2329 2330 2331 2332 2333 2334
#> [331] 2335 2336 2337 2338 2339 2340 2341 2342 2343 2344 2345 2346 2347 2348 2349
#> [346] 2350 2351 2352 2353 2354 2355 2356 2357 2358 2359 2360 2361 2362 2363 2364
#> [361] 2365 2366 2367 2368 2369 2370 2371 2372 2373 2374 2375 2376 2377 2378 2379
#> [376] 2380 2381 2382 2383 2384 2385 2386 2387 2388 2389 2390 2391 2392 2393 2394
#> [391] 2395 2396 2397 2398 2399 2400 2401 2402 2403 2404 2405 2406 2407 2408 2409
#> [406] 2410 2411 2412 2413 2414 2415 2416 2417 2418 2419 2420 2421 2422 2423 2424
#> [421] 2425 2426 2427 2428 2429 2430 2431 2432 2433 2434 2435 2436 2437 2438 2439
#> [436] 2440 2441 2442 2443 2444 2445 2446 2447 2448 2449 2450
#> 
#> $mesh_size_range
#> integer(0)
#> 
#> $metier
#> integer(0)
#> 
#> $supra_region
#> integer(0)
#> 
#> $sub_region
#> integer(0)
#> 
#> $eez_indicator
#> integer(0)
#> 
#> $geo_indicator
#> integer(0)
#> 
#> $specon_tech
#>    [1]    1    2    3    4  100  101  102  113  114  115  116  117  118  119
#>   [15]  129  130  131  132  133  150  151  152  160  161  162  163  164  165
#>   [29]  166  177  178  179  180  181  182  193  194  195  196  197  198  199
#>   [43]  200  201  216  226  227  231  232  233  234  235  236  246  247  248
#>   [57]  249  256  257  258  259  260  266  267  268  269  270  271  277  278
#>   [71]  279  280  281  282  283  284  285  289  290  291  292  293  294  297
#>   [85]  298  299  300  301  302  303  307  308  309  310  311  312  320  321
#>   [99]  322  323  324  333  334  335  336  337  338  339  340  341  344  345
#>  [113]  346  347  348  349  350  351  360  361  362  363  364  365  366  367
#>  [127]  379  380  381  382  383  384  385  386  387  398  399  400  401  402
#>  [141]  403  404  408  409  410  411  412  413  414  418  419  420  421  422
#>  [155]  423  424  425  433  434  435  436  437  438  439  448  449  450  451
#>  [169]  452  453  459  460  461  462  463  464  465  466  473  474  475  476
#>  [183]  477  478  479  480  484  485  486  487  488  494  495  496  497  498
#>  [197]  499  500  501  505  506  507  508  509  513  514  515  521  522  523
#>  [211]  524  527  528  529  530  531  532  533  534  535  536  537  538  539
#>  [225]  540  541  542  543  544  549  550  551  552  553  554  555  556  557
#>  [239]  558  559  560  561  562  565  566  567  568  569  570  571  576  577
#>  [253]  578  579  580  581  582  588  589  590  591  592  593  594  595  596
#>  [267]  597  598  599  601  602  603  604  605  606  607  609  610  611  612
#>  [281]  613  614  615  621  622  623  624  625  626  629  630  631  632  633
#>  [295]  635  636  637  638  639  640  641  642  643  644  645  646  647  648
#>  [309]  649  651  652  653  657  658  659  661  662  663  664  666  667  668
#>  [323]  670  671  672  673  674  676  678  679  680  684  685  687  688  689
#>  [337]  690  700  701  702  703  711  712  713  714  715  716  724  725  726
#>  [351]  727  728  735  736  737  742  743  744  745  749  750  751  755  756
#>  [365]  757  758  762  763  764  767  768  770  771  777  778  783  784  785
#>  [379]  787  789  790  792  795  796  798  807  808  810  811  812  813  814
#>  [393]  815  816  817  821  824  825  826  827  828  829  830  831  832  833
#>  [407]  843  848  849  850  851  852  853  854  855  868  869  870  871  872
#>  [421]  873  874  875  889  890  891  892  893  894  895  896  897  898  908
#>  [435]  909  910  911  912  913  914  915  916  917  929  932  933  934  935
#>  [449]  936  937  938  949  950  951  960  961  962  963  964  965  966  967
#>  [463]  968  980  981  982  983  984  985  986 1001 1002 1003 1004 1005 1006
#>  [477] 1007 1008 1024 1025 1026 1027 1028 1029 1041 1042 1043 1044 1045 1046
#>  [491] 1057 1058 1059 1060 1061 1062 1063 1070 1071 1072 1073 1074 1075 1076
#>  [505] 1086 1087 1088 1089 1090 1091 1092 1106 1107 1108 1109 1110 1111 1112
#>  [519] 1113 1124 1125 1126 1127 1128 1129 1130 1143 1144 1145 1146 1147 1148
#>  [533] 1149 1150 1163 1164 1165 1166 1167 1168 1169 1170 1179 1180 1181 1182
#>  [547] 1183 1184 1185 1186 1187 1198 1199 1200 1201 1202 1203 1204 1214 1215
#>  [561] 1216 1217 1218 1219 1229 1230 1231 1232 1233 1234 1235 1236 1245 1246
#>  [575] 1247 1248 1249 1250 1260 1261 1262 1263 1264 1265 1266 1267 1278 1279
#>  [589] 1280 1281 1282 1283 1284 1285 1298 1299 1300 1301 1302 1303 1312 1313
#>  [603] 1314 1315 1316 1317 1318 1328 1329 1330 1331 1332 1333 1334 1335 1336
#>  [617] 1346 1347 1348 1349 1350 1351 1352 1353 1354 1366 1367 1368 1369 1370
#>  [631] 1371 1372 1384 1385 1386 1387 1388 1389 1390 1391 1392 1393 1404 1405
#>  [645] 1406 1407 1408 1409 1410 1411 1412 1428 1429 1430 1431 1432 1433 1434
#>  [659] 1435 1436 1447 1448 1449 1450 1451 1452 1453 1454 1455 1465 1466 1467
#>  [673] 1468 1469 1470 1471 1472 1484 1485 1486 1487 1488 1489 1490 1491 1501
#>  [687] 1502 1503 1504 1600 1601 1602 1613 1614 1615 1616 1617 1618 1619 1629
#>  [701] 1630 1631 1632 1633 1650 1651 1652 1660 1661 1662 1663 1664 1665 1666
#>  [715] 1677 1678 1679 1680 1681 1682 1693 1694 1695 1696 1697 1698 1699 1700
#>  [729] 1701 1716 1726 1727 1731 1732 1733 1734 1735 1736 1746 1747 1748 1749
#>  [743] 1756 1757 1758 1759 1760 1766 1767 1768 1769 1770 1771 1777 1778 1779
#>  [757] 1780 1781 1782 1783 1784 1785 1789 1790 1791 1792 1793 1794 1797 1798
#>  [771] 1799 1800 1801 1802 1803 1807 1808 1809 1810 1811 1812 1820 1821 1822
#>  [785] 1823 1824 1833 1834 1835 1836 1837 1838 1839 1840 1841 1844 1845 1846
#>  [799] 1847 1848 1849 1850 1851 1860 1861 1862 1863 1864 1865 1866 1867 1879
#>  [813] 1880 1881 1882 1883 1884 1885 1886 1887 1898 1899 1900 1901 1902 1903
#>  [827] 1904 1908 1909 1910 1911 1912 1913 1914 1918 1919 1920 1921 1922 1923
#>  [841] 1924 1925 1933 1934 1935 1936 1937 1938 1939 1948 1949 1950 1951 1952
#>  [855] 1953 1959 1960 1961 1962 1963 1964 1965 1966 1973 1974 1975 1976 1977
#>  [869] 1978 1979 1980 1984 1985 1986 1987 1988 1994 1995 1996 1997 1998 1999
#>  [883] 2000 2001 2005 2006 2007 2008 2009 2013 2014 2015 2021 2022 2023 2024
#>  [897] 2027 2028 2029 2030 2031 2032 2033 2034 2035 2036 2037 2038 2039 2040
#>  [911] 2041 2042 2043 2044 2049 2050 2051 2052 2053 2054 2055 2056 2057 2058
#>  [925] 2059 2060 2061 2062 2065 2066 2067 2068 2069 2070 2071 2076 2077 2078
#>  [939] 2079 2080 2081 2082 2088 2089 2090 2091 2092 2093 2094 2095 2096 2097
#>  [953] 2098 2099 2101 2102 2103 2104 2105 2106 2107 2109 2110 2111 2112 2113
#>  [967] 2114 2115 2121 2122 2123 2124 2125 2126 2129 2130 2131 2132 2133 2135
#>  [981] 2136 2137 2138 2139 2140 2141 2142 2143 2144 2145 2146 2147 2148 2149
#>  [995] 2151 2152 2153 2157 2158 2159 2161 2162 2163 2164 2166 2167 2168 2170
#> [1009] 2171 2172 2173 2174 2176 2178 2179 2180 2184 2185 2187 2188 2189 2190
#> [1023] 2200 2201 2202 2203 2211 2212 2213 2214 2215 2216 2224 2225 2226 2227
#> [1037] 2228 2235 2236 2237 2242 2243 2244 2245 2249 2250 2251 2255 2256 2257
#> [1051] 2258 2262 2263 2264 2267 2268 2270 2271 2277 2278 2283 2284 2285 2287
#> [1065] 2289 2290 2292 2295 2296 2298 2307 2308 2310 2311 2312 2313 2314 2315
#> [1079] 2316 2317 2321 2324 2325 2326 2327 2328 2329 2330 2331 2332 2333 2343
#> [1093] 2348 2349 2350 2351 2352 2353 2354 2355 2368 2369 2370 2371 2372 2373
#> [1107] 2374 2375 2389 2390 2391 2392 2393 2394 2395 2396 2397 2398 2408 2409
#> [1121] 2410 2411 2412 2413 2414 2415 2416 2417 2429 2432 2433 2434 2435 2436
#> [1135] 2437 2438 2449 2450
#> 
#> $deep
#>    [1]    1    2    3    4    5    6    7    8    9   10   11   12   13   14
#>   [15]   15   16   17   18   19   20   22   23   24   25   26   27   28   29
#>   [29]   30   31   32   33   34   35   36   37   38   39   40   41   42   43
#>   [43]   44   45   46   47   48   49   50   51   52   53   54   55   56   57
#>   [57]   58   59   60   61   64   65   66   67   69   71   72   73   74   75
#>   [71]   76   77   78   79   80   81   82   84   85   86   87   88   89   90
#>   [85]   91   92   93   94   95   96   97   98   99  100  101  102  103  104
#>   [99]  105  106  107  108  109  110  111  112  113  114  115  116  117  118
#>  [113]  119  120  121  122  123  124  125  126  127  128  129  130  131  132
#>  [127]  133  134  135  136  137  138  139  140  141  142  143  144  145  146
#>  [141]  147  148  149  150  151  152  153  154  155  156  157  158  159  160
#>  [155]  161  162  163  164  165  166  167  168  169  170  171  172  173  174
#>  [169]  175  176  177  178  179  180  181  182  183  184  185  186  187  188
#>  [183]  189  190  191  192  193  194  195  196  197  198  199  200  201  202
#>  [197]  203  204  205  206  207  208  209  211  212  213  214  215  216  217
#>  [211]  218  219  220  221  222  223  224  225  226  227  228  229  230  231
#>  [225]  232  233  234  235  236  237  238  239  240  241  242  243  244  245
#>  [239]  246  247  248  249  250  251  252  253  254  255  256  257  258  259
#>  [253]  260  261  262  263  264  265  266  267  268  269  270  271  272  273
#>  [267]  274  275  276  277  278  279  280  281  282  283  284  285  286  287
#>  [281]  288  289  290  291  292  293  294  295  296  297  298  299  300  301
#>  [295]  302  303  304  305  306  307  308  309  310  311  312  313  314  315
#>  [309]  316  317  318  319  320  321  322  323  324  325  326  327  328  329
#>  [323]  330  331  332  333  334  335  336  337  338  339  340  341  342  343
#>  [337]  344  345  346  347  348  349  350  351  352  353  354  355  356  357
#>  [351]  358  359  360  361  362  363  364  365  366  367  368  369  370  371
#>  [365]  372  373  374  375  376  377  378  379  380  381  382  383  384  385
#>  [379]  386  387  388  389  390  391  392  393  394  395  396  397  398  399
#>  [393]  400  401  402  403  404  405  406  407  408  409  410  411  412  413
#>  [407]  414  415  416  417  418  419  420  421  422  423  424  425  426  427
#>  [421]  428  429  430  431  432  433  434  435  436  437  438  439  440  441
#>  [435]  442  443  444  445  446  447  448  449  450  451  452  453  454  455
#>  [449]  456  457  458  459  460  461  462  463  464  465  466  467  468  469
#>  [463]  470  471  472  473  474  475  476  477  478  479  480  481  482  483
#>  [477]  484  485  486  487  488  489  490  491  492  493  494  495  496  497
#>  [491]  498  499  500  501  502  503  504  505  506  507  508  509  510  511
#>  [505]  512  513  514  515  516  517  518  519  520  521  522  523  524  525
#>  [519]  526  527  528  529  530  531  532  533  534  535  536  537  538  539
#>  [533]  540  541  542  543  544  545  546  547  548  549  550  551  552  553
#>  [547]  554  555  556  557  558  559  560  561  562  563  564  565  566  567
#>  [561]  568  569  570  571  572  573  574  575  576  577  578  579  580  581
#>  [575]  582  583  584  585  586  587  588  589  590  591  592  593  594  595
#>  [589]  596  597  598  599  600  601  602  603  604  605  606  607  608  609
#>  [603]  610  611  612  613  614  615  616  617  618  619  620  621  622  623
#>  [617]  624  625  626  627  628  629  630  631  632  633  634  635  636  637
#>  [631]  638  639  640  641  642  643  644  645  646  647  648  649  650  651
#>  [645]  652  653  654  655  656  657  658  659  660  661  662  663  664  665
#>  [659]  666  667  668  669  670  671  672  673  674  675  676  677  678  679
#>  [673]  680  681  682  683  684  685  686  687  688  689  690  691  692  693
#>  [687]  694  695  696  697  698  699  700  701  702  703  704  705  706  707
#>  [701]  708  709  710  711  712  713  714  715  716  717  718  719  720  721
#>  [715]  722  723  724  725  726  727  728  729  730  731  732  733  734  735
#>  [729]  736  737  738  739  740  741  742  743  744  745  746  747  748  749
#>  [743]  750  751  752  753  754  755  756  757  758  759  760  761  762  763
#>  [757]  764  765  766  767  768  769  770  771  772  773  774  775  776  777
#>  [771]  778  779  780  781  782  783  784  785  786  787  788  789  790  791
#>  [785]  792  793  794  795  796  797  798  799  800  801  802  803  804  805
#>  [799]  806  807  808  809  810  811  812  813  814  815  816  817  818  819
#>  [813]  820  821  822  823  824  825  826  827  828  829  830  831  832  833
#>  [827]  834  835  836  837  838  839  840  841  842  843  844  845  846  847
#>  [841]  848  849  850  851  852  853  854  855  856  857  858  859  860  861
#>  [855]  862  863  864  865  866  867  868  869  870  871  872  873  874  875
#>  [869]  876  877  878  879  880  881  882  883  884  885  886  887  888  889
#>  [883]  890  891  892  893  894  895  896  897  898  899  900  901  902  903
#>  [897]  904  905  906  907  908  909  910  911  912  913  914  915  916  917
#>  [911]  918  919  920  921  922  923  924  925  926  927  928  929  930  931
#>  [925]  932  933  934  935  936  937  938  939  940  941  942  943  944  945
#>  [939]  946  947  948  949  950  951  952  953  954  955  956  957  958  959
#>  [953]  960  961  962  963  964  965  966  967  968  969  970  971  972  973
#>  [967]  974  975  976  977  978  979  980  981  982  983  984  985  986  987
#>  [981]  988  989  990  991  992  993  994  995  996  997  998  999 1000 1001
#>  [995] 1002 1003 1004 1005 1006 1007 1008 1009 1010 1011 1012 1013 1014 1015
#> [1009] 1016 1017 1018 1019 1020 1021 1022 1023 1024 1025 1026 1027 1028 1029
#> [1023] 1030 1031 1032 1033 1034 1035 1036 1037 1038 1039 1040 1041 1042 1043
#> [1037] 1044 1045 1046 1047 1048 1049 1050 1051 1052 1053 1054 1055 1056 1057
#> [1051] 1058 1059 1060 1061 1062 1063 1064 1065 1066 1067 1068 1069 1070 1071
#> [1065] 1072 1073 1074 1075 1076 1077 1078 1079 1080 1081 1082 1083 1084 1085
#> [1079] 1086 1087 1088 1089 1090 1091 1092 1093 1094 1095 1096 1097 1098 1099
#> [1093] 1100 1101 1102 1103 1104 1105 1106 1107 1108 1109 1110 1111 1112 1113
#> [1107] 1114 1115 1116 1117 1118 1119 1120 1121 1122 1123 1124 1125 1126 1127
#> [1121] 1128 1129 1130 1131 1132 1133 1134 1135 1136 1137 1138 1139 1140 1141
#> [1135] 1142 1143 1144 1145 1146 1147 1148 1149 1150 1151 1152 1153 1154 1155
#> [1149] 1156 1157 1158 1159 1160 1161 1162 1163 1164 1165 1166 1167 1168 1169
#> [1163] 1170 1171 1172 1173 1174 1175 1176 1177 1178 1179 1180 1181 1182 1183
#> [1177] 1184 1185 1186 1187 1188 1189 1190 1191 1192 1193 1194 1195 1196 1197
#> [1191] 1198 1199 1200 1201 1202 1203 1204 1205 1206 1207 1208 1209 1210 1211
#> [1205] 1212 1213 1214 1215 1216 1217 1218 1219 1220 1221 1222 1223 1224 1225
#> [1219] 1226 1227 1228 1229 1230 1231 1232 1233 1234 1235 1236 1237 1238 1239
#> [1233] 1240 1241 1242 1243 1244 1245 1246 1247 1248 1249 1250 1251 1252 1253
#> [1247] 1254 1255 1256 1257 1258 1259 1260 1261 1262 1263 1264 1265 1266 1267
#> [1261] 1268 1269 1270 1271 1272 1273 1274 1275 1276 1277 1278 1279 1280 1281
#> [1275] 1282 1283 1284 1285 1286 1287 1288 1289 1290 1291 1292 1293 1294 1295
#> [1289] 1296 1297 1298 1299 1300 1301 1302 1303 1304 1305 1306 1307 1308 1309
#> [1303] 1310 1311 1312 1313 1314 1315 1316 1317 1318 1319 1320 1321 1322 1323
#> [1317] 1324 1325 1326 1327 1328 1329 1330 1331 1332 1333 1334 1335 1336 1337
#> [1331] 1338 1339 1340 1341 1342 1343 1344 1345 1346 1347 1348 1349 1350 1351
#> [1345] 1352 1353 1354 1355 1356 1357 1358 1359 1360 1361 1362 1363 1364 1365
#> [1359] 1366 1367 1368 1369 1370 1371 1372 1373 1374 1375 1376 1377 1378 1379
#> [1373] 1380 1381 1382 1383 1384 1385 1386 1387 1388 1389 1390 1391 1392 1393
#> [1387] 1394 1395 1396 1397 1398 1399 1400 1401 1402 1403 1404 1405 1406 1407
#> [1401] 1408 1409 1410 1411 1412 1413 1414 1415 1416 1417 1418 1419 1420 1421
#> [1415] 1422 1423 1424 1425 1426 1427 1428 1429 1430 1431 1432 1433 1434 1435
#> [1429] 1436 1437 1438 1439 1440 1441 1442 1443 1444 1445 1446 1447 1448 1449
#> [1443] 1450 1451 1452 1453 1454 1455 1456 1457 1458 1459 1460 1461 1462 1463
#> [1457] 1464 1465 1466 1467 1468 1469 1470 1471 1472 1473 1474 1475 1476 1477
#> [1471] 1478 1479 1480 1481 1482 1483 1484 1485 1486 1487 1488 1489 1490 1491
#> [1485] 1492 1493 1494 1495 1496 1497 1498 1499 1500 1501 1502 1503 1504 1505
#> [1499] 1506 1507 1508 1509 1510 1511 1512 1513 1514 1515 1516 1517 1518 1519
#> [1513] 1520 1522 1523 1524 1525 1526 1527 1528 1529 1530 1531 1532 1533 1534
#> [1527] 1535 1536 1537 1538 1539 1540 1541 1542 1543 1544 1545 1546 1547 1548
#> [1541] 1549 1550 1551 1552 1553 1554 1555 1556 1557 1558 1559 1560 1561 1564
#> [1555] 1565 1566 1567 1569 1571 1572 1573 1574 1575 1576 1577 1578 1579 1580
#> [1569] 1581 1582 1584 1585 1586 1587 1588 1589 1590 1591 1592 1593 1594 1595
#> [1583] 1596 1597 1598 1599 1600 1601 1602 1603 1604 1605 1606 1607 1608 1609
#> [1597] 1610 1611 1612 1613 1614 1615 1616 1617 1618 1619 1620 1621 1622 1623
#> [1611] 1624 1625 1626 1627 1628 1629 1630 1631 1632 1633 1634 1635 1636 1637
#> [1625] 1638 1639 1640 1641 1642 1643 1644 1645 1646 1647 1648 1649 1650 1651
#> [1639] 1652 1653 1654 1655 1656 1657 1658 1659 1660 1661 1662 1663 1664 1665
#> [1653] 1666 1667 1668 1669 1670 1671 1672 1673 1674 1675 1676 1677 1678 1679
#> [1667] 1680 1681 1682 1683 1684 1685 1686 1687 1688 1689 1690 1691 1692 1693
#> [1681] 1694 1695 1696 1697 1698 1699 1700 1701 1702 1703 1704 1705 1706 1707
#> [1695] 1708 1709 1711 1712 1713 1714 1715 1716 1717 1718 1719 1720 1721 1722
#> [1709] 1723 1724 1725 1726 1727 1728 1729 1730 1731 1732 1733 1734 1735 1736
#> [1723] 1737 1738 1739 1740 1741 1742 1743 1744 1745 1746 1747 1748 1749 1750
#> [1737] 1751 1752 1753 1754 1755 1756 1757 1758 1759 1760 1761 1762 1763 1764
#> [1751] 1765 1766 1767 1768 1769 1770 1771 1772 1773 1774 1775 1776 1777 1778
#> [1765] 1779 1780 1781 1782 1783 1784 1785 1786 1787 1788 1789 1790 1791 1792
#> [1779] 1793 1794 1795 1796 1797 1798 1799 1800 1801 1802 1803 1804 1805 1806
#> [1793] 1807 1808 1809 1810 1811 1812 1813 1814 1815 1816 1817 1818 1819 1820
#> [1807] 1821 1822 1823 1824 1825 1826 1827 1828 1829 1830 1831 1832 1833 1834
#> [1821] 1835 1836 1837 1838 1839 1840 1841 1842 1843 1844 1845 1846 1847 1848
#> [1835] 1849 1850 1851 1852 1853 1854 1855 1856 1857 1858 1859 1860 1861 1862
#> [1849] 1863 1864 1865 1866 1867 1868 1869 1870 1871 1872 1873 1874 1875 1876
#> [1863] 1877 1878 1879 1880 1881 1882 1883 1884 1885 1886 1887 1888 1889 1890
#> [1877] 1891 1892 1893 1894 1895 1896 1897 1898 1899 1900 1901 1902 1903 1904
#> [1891] 1905 1906 1907 1908 1909 1910 1911 1912 1913 1914 1915 1916 1917 1918
#> [1905] 1919 1920 1921 1922 1923 1924 1925 1926 1927 1928 1929 1930 1931 1932
#> [1919] 1933 1934 1935 1936 1937 1938 1939 1940 1941 1942 1943 1944 1945 1946
#> [1933] 1947 1948 1949 1950 1951 1952 1953 1954 1955 1956 1957 1958 1959 1960
#> [1947] 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974
#> [1961] 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988
#> [1975] 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002
#> [1989] 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016
#> [2003] 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026 2027 2028 2029 2030
#> [2017] 2031 2032 2033 2034 2035 2036 2037 2038 2039 2040 2041 2042 2043 2044
#> [2031] 2045 2046 2047 2048 2049 2050 2051 2052 2053 2054 2055 2056 2057 2058
#> [2045] 2059 2060 2061 2062 2063 2064 2065 2066 2067 2068 2069 2070 2071 2072
#> [2059] 2073 2074 2075 2076 2077 2078 2079 2080 2081 2082 2083 2084 2085 2086
#> [2073] 2087 2088 2089 2090 2091 2092 2093 2094 2095 2096 2097 2098 2099 2100
#> [2087] 2101 2102 2103 2104 2105 2106 2107 2108 2109 2110 2111 2112 2113 2114
#> [2101] 2115 2116 2117 2118 2119 2120 2121 2122 2123 2124 2125 2126 2127 2128
#> [2115] 2129 2130 2131 2132 2133 2134 2135 2136 2137 2138 2139 2140 2141 2142
#> [2129] 2143 2144 2145 2146 2147 2148 2149 2150 2151 2152 2153 2154 2155 2156
#> [2143] 2157 2158 2159 2160 2161 2162 2163 2164 2165 2166 2167 2168 2169 2170
#> [2157] 2171 2172 2173 2174 2175 2176 2177 2178 2179 2180 2181 2182 2183 2184
#> [2171] 2185 2186 2187 2188 2189 2190 2191 2192 2193 2194 2195 2196 2197 2198
#> [2185] 2199 2200 2201 2202 2203 2204 2205 2206 2207 2208 2209 2210 2211 2212
#> [2199] 2213 2214 2215 2216 2217 2218 2219 2220 2221 2222 2223 2224 2225 2226
#> [2213] 2227 2228 2229 2230 2231 2232 2233 2234 2235 2236 2237 2238 2239 2240
#> [2227] 2241 2242 2243 2244 2245 2246 2247 2248 2249 2250 2251 2252 2253 2254
#> [2241] 2255 2256 2257 2258 2259 2260 2261 2262 2263 2264 2265 2266 2267 2268
#> [2255] 2269 2270 2271 2272 2273 2274 2275 2276 2277 2278 2279 2280 2281 2282
#> [2269] 2283 2284 2285 2286 2287 2288 2289 2290 2291 2292 2293 2294 2295 2296
#> [2283] 2297 2298 2299 2300 2301 2302 2303 2304 2305 2306 2307 2308 2309 2310
#> [2297] 2311 2312 2313 2314 2315 2316 2317 2318 2319 2320 2321 2322 2323 2324
#> [2311] 2325 2326 2327 2328 2329 2330 2331 2332 2333 2334 2335 2336 2337 2338
#> [2325] 2339 2340 2341 2342 2343 2344 2345 2346 2347 2348 2349 2350 2351 2352
#> [2339] 2353 2354 2355 2356 2357 2358 2359 2360 2361 2362 2363 2364 2365 2366
#> [2353] 2367 2368 2369 2370 2371 2372 2373 2374 2375 2376 2377 2378 2379 2380
#> [2367] 2381 2382 2383 2384 2385 2386 2387 2388 2389 2390 2391 2392 2393 2394
#> [2381] 2395 2396 2397 2398 2399 2400 2401 2402 2403 2404 2405 2406 2407 2408
#> [2395] 2409 2410 2411 2412 2413 2414 2415 2416 2417 2418 2419 2420 2421 2422
#> [2409] 2423 2424 2425 2426 2427 2428 2429 2430 2431 2432 2433 2434 2435 2436
#> [2423] 2437 2438 2439 2440 2441 2442 2443 2444 2445 2446 2447 2448 2449 2450
#> 
#> $rectangle_type
#> integer(0)
#> 
#> $rectangle_lat
#> integer(0)
#> 
#> $rectangle_lon
#> integer(0)
#> 
#> $c_square
#> integer(0)
#> 
#> $totfishdays
#> integer(0)
#> 
#> $confidential
#> integer(0)
```

### Check duplicated records in FDI I table

The function `check_RD_FDI_I` check the presence of duplicated records. In particular, it checks whether the combination of the first 15 columns generates duplicate records. The function returns the indices of the duplicated rows.


```r
i_spatial_fe <- rbind(fdi_i_spatial_effort,fdi_i_spatial_effort[1,])
check_RD_FDI_I(i_spatial_fe)
#> 150 record/s duplicated
#>   [1]   44   45   53   54   55   61   69   81   82   84   85   87   89   91   93
#>  [16]   94   95  139  145  155  156  165  198  255  308  357  365  366  373  374
#>  [31]  375  446  541  831  832  833  840  853  861  862  881  887  888  907  914
#>  [46]  915  916  917  923  924  925  926  927  997  998  999 1017 1018 1046 1053
#>  [61] 1091 1092 1098 1099 1100 1101 1111 1112 1113 1122 1141 1142 1161 1162 1170
#>  [76] 1177 1196 1197 1273 1293 1309 1317 1318 1325 1326 1327 1334 1335 1336 1342
#>  [91] 1362 1371 1383 1389 1401 1402 1403 1409 1410 1411 1412 1418 1419 1420 1421
#> [106] 1422 1423 1424 1425 1426 1427 1444 1446 1453 1472 1479 1481 1499 1554 1555
#> [121] 1556 1576 1592 1599 1665 1699 1832 1932 1953 1965 1972 1978 1979 1980 2035
#> [136] 2044 2054 2055 2056 2126 2209 2333 2339 2341 2366 2375 2394 2395 2396 2451
```

## Table J

### Check empty fields in FDI J table

The function `check_EF_FDI_J` checks the presence of not allowed empty data in the given table, according to the Fisheries Dependent Information data call 2021 - Annex 1. A list is returned by the function. The first list's object is a vector containing the number of NA for each reference column.


```r
check_EF_FDI_J(fdi_j_capacity, verbose=FALSE)[[1]]
#>              country                 year        vessel_length 
#>                    0                    0                    0 
#>         fishing_tech         supra_region        geo_indicator 
#>                    0                    0                    0 
#> principal_sub_region             tottrips                totkw 
#>                    0                    0                    0 
#>                totgt               totves               avgage 
#>                    0                    0                    0 
#>               avgloa           maxseadays 
#>                    0                    0
```

The second list's object gives the index of each NA in the reference column.


```r
check_EF_FDI_J(fdi_j_capacity, verbose=FALSE)[[2]]
#> $country
#> integer(0)
#> 
#> $year
#> integer(0)
#> 
#> $vessel_length
#> integer(0)
#> 
#> $fishing_tech
#> integer(0)
#> 
#> $supra_region
#> integer(0)
#> 
#> $geo_indicator
#> integer(0)
#> 
#> $principal_sub_region
#> integer(0)
#> 
#> $tottrips
#> integer(0)
#> 
#> $totkw
#> integer(0)
#> 
#> $totgt
#> integer(0)
#> 
#> $totves
#> integer(0)
#> 
#> $avgage
#> integer(0)
#> 
#> $avgloa
#> integer(0)
#> 
#> $maxseadays
#> integer(0)
```

### Check duplicated records in FDI J table

The function `check_RD_FDI_J` check the presence of duplicated records. In particular, it checks whether the combination of the first 15 columns generates duplicate records. The function returns the indices of the duplicated rows.


```r
j_capacity <- rbind(fdi_j_capacity,fdi_j_capacity[1,])
check_RD_FDI_J(j_capacity)
#> 2239 record/s duplicated
#>    [1]    2    3   14   22   33   34   35   36   42   43   44   45   46   52
#>   [15]   53   54   55   56   57   58   60   61   62   63   64   65   66   67
#>   [29]   68   69   70   71   72   73   74   75   76   77   78   79   80   81
#>   [43]   82   83   84   85   86   87   88   89   90   91   92   93   94   95
#>   [57]   96   97   98   99  100  101  102  103  104  105  106  107  108  109
#>   [71]  110  111  112  113  114  115  116  117  118  119  120  121  122  123
#>   [85]  124  125  126  127  128  129  130  131  132  133  134  135  136  137
#>   [99]  139  140  141  142  143  144  145  146  147  148  149  150  151  152
#>  [113]  153  155  156  157  158  159  160  161  162  163  164  165  166  167
#>  [127]  168  169  170  171  172  173  174  175  176  177  178  179  180  181
#>  [141]  182  183  184  185  186  187  188  189  190  191  192  193  194  195
#>  [155]  196  197  198  199  200  201  202  203  204  205  206  207  208  209
#>  [169]  210  211  212  213  214  215  216  217  218  219  220  221  222  223
#>  [183]  224  225  226  227  228  229  230  231  232  233  234  235  236  237
#>  [197]  238  239  240  241  242  243  244  245  246  247  248  249  250  251
#>  [211]  252  253  254  255  256  257  258  259  260  261  262  263  264  265
#>  [225]  266  267  268  269  270  271  272  273  274  275  276  277  278  279
#>  [239]  280  281  282  283  284  285  286  287  288  289  290  291  292  293
#>  [253]  294  295  296  297  298  299  300  301  302  303  304  305  306  307
#>  [267]  308  309  310  311  312  313  314  315  316  317  318  319  320  321
#>  [281]  323  324  325  326  327  328  329  330  331  332  333  334  335  336
#>  [295]  337  338  339  340  341  342  343  344  345  346  347  348  349  350
#>  [309]  351  352  353  354  355  356  357  358  359  360  361  362  363  364
#>  [323]  365  366  367  368  369  370  371  372  373  374  375  376  377  378
#>  [337]  379  380  381  382  383  384  385  386  387  388  389  390  391  392
#>  [351]  393  394  395  396  397  398  399  400  401  402  403  404  405  406
#>  [365]  407  408  409  410  411  412  413  414  415  416  417  418  419  420
#>  [379]  421  422  423  424  425  426  427  428  429  430  431  432  433  434
#>  [393]  435  436  437  438  439  440  441  442  443  444  446  447  448  449
#>  [407]  450  451  452  453  454  455  456  457  458  459  460  461  462  463
#>  [421]  464  465  466  467  468  469  470  471  472  473  474  475  476  477
#>  [435]  478  479  480  481  482  483  484  485  486  487  488  489  490  491
#>  [449]  492  493  494  495  496  497  498  499  500  501  502  503  504  505
#>  [463]  506  507  508  509  510  511  512  513  514  515  516  517  518  519
#>  [477]  520  521  522  523  524  525  526  527  528  529  530  531  532  533
#>  [491]  534  535  536  537  538  539  540  541  542  543  544  545  546  547
#>  [505]  548  549  550  551  552  553  554  555  556  557  558  559  560  561
#>  [519]  562  563  564  565  566  567  568  569  570  571  572  573  574  575
#>  [533]  576  577  578  579  580  581  582  583  584  585  586  587  588  589
#>  [547]  590  591  592  593  594  595  596  597  598  599  600  601  602  603
#>  [561]  604  605  606  607  608  609  610  611  612  613  614  615  616  617
#>  [575]  618  619  620  621  622  623  624  625  626  627  628  629  630  631
#>  [589]  632  633  634  635  636  637  638  639  640  641  642  643  644  645
#>  [603]  646  647  648  649  650  651  652  653  654  655  656  666  667  668
#>  [617]  674  680  686  687  693  694  695  696  702  703  704  705  706  707
#>  [631]  708  709  710  712  713  714  715  716  717  718  719  720  721  722
#>  [645]  723  724  725  726  727  728  729  730  731  732  733  734  735  736
#>  [659]  737  738  739  740  741  742  743  744  745  746  747  748  749  750
#>  [673]  751  752  753  754  755  756  757  758  759  760  761  762  763  764
#>  [687]  765  766  767  768  769  770  771  772  773  774  775  776  777  778
#>  [701]  779  780  781  782  783  784  785  786  787  788  789  790  791  792
#>  [715]  793  794  795  796  797  798  799  800  801  802  803  804  805  806
#>  [729]  807  808  809  810  811  812  813  814  815  816  817  818  819  820
#>  [743]  821  822  823  824  825  826  827  828  829  830  831  832  833  834
#>  [757]  835  836  837  838  839  840  841  842  843  844  845  846  847  848
#>  [771]  849  850  851  852  853  854  855  856  857  858  859  860  861  862
#>  [785]  863  864  865  866  867  868  869  870  871  872  873  874  875  876
#>  [799]  877  878  879  880  881  882  883  884  885  886  887  888  889  890
#>  [813]  891  892  893  894  895  896  897  898  899  900  901  902  903  904
#>  [827]  905  906  907  908  909  910  911  912  913  914  915  916  917  918
#>  [841]  919  920  921  922  923  924  925  926  927  928  929  930  931  932
#>  [855]  933  934  935  936  937  938  939  940  941  942  943  944  945  946
#>  [869]  947  948  949  950  951  952  953  954  955  956  957  958  959  960
#>  [883]  961  962  963  964  965  966  967  968  969  970  971  972  973  974
#>  [897]  975  976  977  978  979  980  981  982  983  984  985  986  987  988
#>  [911]  989  990  991  992  993  994  995  996  997  998  999 1000 1001 1002
#>  [925] 1003 1004 1005 1006 1007 1008 1009 1010 1011 1012 1013 1014 1015 1016
#>  [939] 1017 1018 1019 1020 1021 1022 1023 1024 1025 1026 1027 1028 1029 1030
#>  [953] 1031 1032 1033 1034 1035 1036 1037 1038 1039 1040 1041 1042 1043 1044
#>  [967] 1045 1046 1047 1048 1049 1050 1051 1052 1053 1054 1055 1056 1057 1058
#>  [981] 1059 1060 1061 1062 1063 1064 1065 1066 1067 1068 1069 1070 1071 1072
#>  [995] 1073 1074 1075 1076 1077 1078 1079 1080 1081 1082 1083 1084 1085 1086
#> [1009] 1087 1088 1089 1090 1091 1092 1093 1094 1095 1096 1097 1098 1099 1100
#> [1023] 1101 1102 1103 1104 1105 1106 1107 1108 1109 1110 1111 1112 1113 1114
#> [1037] 1115 1116 1117 1118 1119 1120 1121 1122 1123 1124 1125 1126 1127 1128
#> [1051] 1129 1130 1131 1132 1133 1134 1135 1136 1137 1138 1139 1140 1141 1142
#> [1065] 1143 1144 1145 1146 1147 1148 1149 1150 1151 1152 1153 1154 1155 1156
#> [1079] 1157 1158 1159 1160 1161 1162 1163 1164 1165 1166 1167 1168 1169 1170
#> [1093] 1171 1172 1173 1174 1175 1176 1177 1178 1179 1180 1181 1182 1183 1184
#> [1107] 1185 1186 1187 1188 1189 1190 1191 1192 1193 1194 1195 1196 1197 1198
#> [1121] 1199 1200 1201 1202 1203 1204 1205 1206 1207 1208 1209 1210 1211 1212
#> [1135] 1213 1214 1215 1216 1217 1218 1219 1220 1221 1222 1223 1224 1225 1226
#> [1149] 1227 1228 1229 1230 1231 1232 1233 1234 1235 1236 1237 1238 1239 1240
#> [1163] 1241 1242 1243 1244 1245 1246 1247 1248 1249 1250 1251 1252 1253 1254
#> [1177] 1255 1256 1257 1258 1259 1260 1261 1262 1263 1264 1265 1266 1267 1268
#> [1191] 1269 1270 1271 1272 1273 1274 1275 1276 1277 1278 1279 1280 1281 1282
#> [1205] 1283 1284 1285 1286 1287 1288 1289 1290 1291 1292 1293 1294 1295 1296
#> [1219] 1297 1298 1299 1300 1301 1302 1303 1304 1305 1306 1307 1308 1309 1310
#> [1233] 1311 1312 1313 1314 1315 1316 1317 1318 1319 1320 1321 1322 1323 1324
#> [1247] 1325 1326 1327 1328 1329 1330 1331 1332 1333 1334 1335 1336 1337 1338
#> [1261] 1339 1340 1341 1342 1343 1344 1345 1346 1347 1348 1349 1350 1351 1352
#> [1275] 1353 1354 1355 1356 1357 1358 1359 1360 1361 1362 1363 1364 1365 1366
#> [1289] 1367 1368 1369 1370 1371 1372 1373 1374 1375 1376 1377 1378 1379 1380
#> [1303] 1381 1382 1383 1384 1385 1386 1387 1388 1389 1390 1391 1392 1393 1394
#> [1317] 1395 1396 1397 1398 1399 1400 1401 1402 1403 1404 1405 1406 1407 1408
#> [1331] 1409 1410 1411 1412 1413 1414 1415 1416 1417 1418 1419 1420 1421 1422
#> [1345] 1423 1424 1425 1426 1427 1428 1429 1430 1431 1432 1433 1434 1435 1436
#> [1359] 1437 1438 1439 1440 1441 1442 1443 1444 1445 1446 1447 1448 1449 1450
#> [1373] 1451 1452 1453 1454 1455 1456 1457 1458 1459 1460 1461 1462 1463 1464
#> [1387] 1465 1466 1467 1468 1469 1470 1471 1472 1473 1474 1475 1476 1477 1478
#> [1401] 1479 1480 1481 1482 1483 1484 1485 1486 1487 1488 1489 1490 1491 1492
#> [1415] 1493 1494 1495 1496 1497 1498 1499 1500 1501 1502 1503 1504 1505 1506
#> [1429] 1507 1508 1509 1510 1511 1512 1513 1514 1515 1516 1517 1518 1519 1520
#> [1443] 1521 1522 1523 1524 1525 1526 1527 1528 1529 1530 1531 1532 1533 1534
#> [1457] 1535 1536 1537 1538 1539 1540 1541 1542 1543 1544 1545 1546 1547 1548
#> [1471] 1549 1550 1551 1552 1553 1554 1555 1556 1557 1558 1559 1560 1561 1562
#> [1485] 1563 1564 1565 1566 1567 1568 1569 1570 1571 1572 1573 1574 1575 1576
#> [1499] 1577 1578 1579 1580 1581 1582 1583 1584 1585 1586 1587 1588 1589 1590
#> [1513] 1591 1592 1593 1594 1595 1596 1597 1598 1599 1600 1601 1602 1603 1604
#> [1527] 1605 1606 1607 1608 1609 1610 1611 1612 1613 1614 1615 1616 1617 1618
#> [1541] 1619 1620 1621 1622 1623 1624 1625 1626 1627 1628 1629 1630 1631 1632
#> [1555] 1633 1634 1635 1636 1637 1638 1639 1640 1641 1642 1643 1644 1645 1646
#> [1569] 1647 1648 1649 1650 1651 1652 1653 1654 1655 1656 1657 1658 1659 1660
#> [1583] 1661 1662 1663 1664 1665 1666 1667 1668 1669 1670 1671 1672 1673 1674
#> [1597] 1675 1676 1677 1678 1679 1680 1681 1682 1683 1684 1685 1686 1687 1688
#> [1611] 1689 1690 1691 1692 1693 1694 1695 1696 1697 1698 1699 1700 1701 1702
#> [1625] 1703 1704 1705 1706 1707 1708 1709 1710 1711 1712 1713 1714 1715 1716
#> [1639] 1717 1718 1719 1720 1721 1722 1723 1724 1725 1726 1727 1728 1729 1730
#> [1653] 1731 1732 1733 1734 1735 1736 1737 1738 1739 1740 1741 1742 1743 1744
#> [1667] 1745 1746 1747 1748 1749 1750 1751 1752 1753 1754 1755 1756 1757 1758
#> [1681] 1759 1760 1761 1762 1763 1764 1765 1766 1767 1768 1769 1770 1771 1772
#> [1695] 1773 1774 1775 1776 1777 1778 1779 1780 1781 1782 1783 1784 1785 1786
#> [1709] 1787 1788 1789 1790 1791 1792 1793 1794 1795 1796 1797 1798 1799 1800
#> [1723] 1801 1802 1803 1804 1805 1806 1807 1808 1809 1810 1811 1812 1813 1814
#> [1737] 1815 1816 1817 1818 1819 1820 1821 1822 1823 1824 1825 1826 1827 1828
#> [1751] 1829 1830 1831 1832 1833 1834 1835 1836 1837 1838 1839 1840 1841 1842
#> [1765] 1843 1844 1845 1846 1847 1848 1849 1850 1851 1852 1853 1854 1855 1856
#> [1779] 1857 1858 1859 1860 1861 1862 1863 1864 1865 1866 1867 1877 1878 1879
#> [1793] 1880 1881 1887 1888 1889 1890 1894 1896 1897 1898 1904 1910 1923 1924
#> [1807] 1925 1926 1932 1933 1934 1935 1936 1942 1943 1944 1945 1951 1952 1953
#> [1821] 1959 1965 1966 1967 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978
#> [1835] 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992
#> [1849] 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006
#> [1863] 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020
#> [1877] 2021 2022 2023 2024 2025 2026 2027 2028 2029 2030 2031 2032 2033 2034
#> [1891] 2035 2036 2037 2038 2039 2040 2041 2042 2043 2044 2045 2046 2047 2048
#> [1905] 2049 2050 2051 2052 2053 2054 2055 2056 2057 2058 2059 2060 2061 2062
#> [1919] 2063 2064 2065 2066 2067 2068 2069 2070 2071 2072 2073 2074 2075 2076
#> [1933] 2077 2078 2079 2080 2081 2090 2091 2092 2093 2099 2100 2101 2102 2103
#> [1947] 2109 2110 2111 2112 2118 2119 2120 2126 2132 2133 2139 2145 2146 2147
#> [1961] 2148 2154 2155 2156 2157 2158 2164 2165 2166 2167 2173 2174 2175 2181
#> [1975] 2187 2188 2189 2190 2191 2192 2193 2194 2195 2196 2197 2198 2199 2200
#> [1989] 2201 2202 2203 2204 2205 2206 2207 2208 2209 2210 2211 2212 2213 2214
#> [2003] 2215 2216 2217 2218 2219 2220 2221 2222 2223 2224 2225 2226 2227 2228
#> [2017] 2229 2230 2231 2232 2233 2234 2235 2236 2237 2238 2239 2240 2241 2242
#> [2031] 2243 2244 2245 2246 2247 2248 2249 2250 2251 2252 2253 2254 2255 2256
#> [2045] 2257 2258 2259 2260 2261 2262 2263 2264 2265 2266 2267 2268 2269 2270
#> [2059] 2271 2272 2273 2274 2275 2276 2277 2278 2279 2280 2281 2282 2283 2284
#> [2073] 2285 2286 2287 2288 2289 2290 2291 2292 2293 2294 2295 2296 2297 2298
#> [2087] 2299 2300 2301 2302 2303 2304 2305 2306 2307 2308 2309 2310 2311 2312
#> [2101] 2313 2314 2315 2316 2317 2318 2319 2320 2321 2322 2323 2324 2325 2326
#> [2115] 2327 2328 2329 2330 2331 2332 2333 2334 2335 2336 2337 2338 2339 2340
#> [2129] 2341 2342 2343 2344 2345 2346 2347 2348 2349 2350 2351 2352 2353 2354
#> [2143] 2355 2356 2357 2358 2359 2360 2361 2362 2363 2364 2365 2366 2367 2368
#> [2157] 2369 2370 2371 2372 2373 2374 2375 2376 2377 2378 2379 2380 2381 2382
#> [2171] 2383 2384 2385 2386 2387 2388 2389 2390 2391 2392 2393 2394 2395 2396
#> [2185] 2397 2398 2399 2400 2401 2402 2403 2404 2405 2406 2407 2408 2409 2410
#> [2199] 2411 2412 2413 2414 2415 2416 2417 2418 2419 2420 2421 2422 2423 2424
#> [2213] 2425 2426 2427 2428 2429 2430 2431 2432 2433 2434 2435 2436 2437 2438
#> [2227] 2439 2440 2441 2442 2443 2444 2445 2446 2447 2448 2449 2450 2451
```

# GFCM data format

## Task II.2 table

### Check empty fields in GFCM Task II.2 table

The function `check_EF_taskII2` checks the presence of not allowed empty data in the given table, according to the GFCM Data Collection Reference Framework (DCRF, V. 20.1). The function returns two lists. The first list gives the number of NA for each reference column. 


```r
check_EF_taskII2(task_ii2, verbose=FALSE)[[1]]
#> Reference_Year            CPC            GSA        Segment        Species 
#>              0              0              0              0              0 
#>        Landing          Catch 
#>              0              0
```

The second list returns the index of each NA in the reference column.


```r
check_EF_taskII2(task_ii2, verbose=FALSE)[[2]]
#> $Reference_Year
#> integer(0)
#> 
#> $CPC
#> integer(0)
#> 
#> $GSA
#> integer(0)
#> 
#> $Segment
#> integer(0)
#> 
#> $Species
#> integer(0)
#> 
#> $Landing
#> integer(0)
#> 
#> $Catch
#> integer(0)
```

### Check of missing combination GSA/Fleet segment per year

Function `check_presence_taskII2` allows to verify the completeness of the GSA/Fleet segments in Task II.2 table, as reported in the combination_taskII2 table. The output is a list of missing combinations GSA/Fleet segment per year.


```r
check_presence_taskII2(task_ii2,combination_taskII2,MS="ITA",GSA="18")
#> No reference values for the following years: 2017.
```

### Check duplicated records in GFCM Task II.2 table

The function `check_RD_taskII2` checks the presence of duplicated records. In particular, it checks whether the combination of the first 5 columns generates duplicate records. The function returns the indices of the duplicated rows, checking the unique combinations of the first 5 columns of the Task II.2 table.


```r
ii2 <- rbind(task_ii2,task_ii2[1,])
check_RD_taskII2(ii2)
#> 1 record/s duplicated
#> [1] 6
```

## Task III table

### Check empty fields in GFCM Task III table

The function `check_EF_taskIII` checks the presence of not allowed empty data in the given table, according to the GFCM Data Collection Reference Framework (DCRF, V. 20.1). The function returns two lists. The first list gives the number of NA for each reference column. 


```r
check_EF_taskIII(task_iii,verbose=FALSE)[[1]]
#> Reference_Year            CPC            GSA        Segment          Group 
#>              0              0              0              0              0 
#>           Date         Source   NumberCaught 
#>              0              0              0
```

The second list returns the index of each NA in the reference column.


```r
check_EF_taskIII(task_iii,verbose=FALSE)[[2]]
#> $Reference_Year
#> integer(0)
#> 
#> $CPC
#> integer(0)
#> 
#> $GSA
#> integer(0)
#> 
#> $Segment
#> integer(0)
#> 
#> $Group
#> integer(0)
#> 
#> $Date
#> integer(0)
#> 
#> $Source
#> integer(0)
#> 
#> $NumberCaught
#> integer(0)
```

### Check duplicated records in GFCM Task III table

The function `check_RD_taskIII` checks the presence of duplicated records. In particular, it checks whether the combination of the first 10 columns generates duplicate records. The function returns the indices of the duplicated rows, checking the unique combinations of the first 10 columns of the Task Task III table.


```r
check_RD_taskIII(task_iii)
#> no duplicated lines in the data frame
#> integer(0)
```

## Task VII.2 table

### Check empty fields in GFCM Task VII.2 table

The function `check_EF_taskVII2` checks the presence of not allowed empty data in the given table, according to the GFCM Data Collection Reference Framework (DCRF, V. 20.1). The function returns two lists. The first list gives the number of NA for each reference column.


```r
check_EF_taskVII2(task_vii2, verbose=FALSE)[[1]]
#>            Reference_Year                       CPC                       GSA 
#>                         0                         0                         0 
#>                    Source                SurveyName                   Segment 
#>                         0                         0                         0 
#>                   Species                LengthUnit                    Length 
#>                         0                         0                         0 
#> NumberIndividualsMeasured  WeightIndividualsSampled NumberIndividualsExpanded 
#>                         0                         0                         0
```

The second list returns the index of each NA in the reference column.


```r
check_EF_taskVII2(task_vii2, verbose=FALSE)[[2]]
#> $Reference_Year
#> integer(0)
#> 
#> $CPC
#> integer(0)
#> 
#> $GSA
#> integer(0)
#> 
#> $Source
#> integer(0)
#> 
#> $SurveyName
#> integer(0)
#> 
#> $Segment
#> integer(0)
#> 
#> $Species
#> integer(0)
#> 
#> $LengthUnit
#> integer(0)
#> 
#> $Length
#> integer(0)
#> 
#> $NumberIndividualsMeasured
#> integer(0)
#> 
#> $WeightIndividualsSampled
#> integer(0)
#> 
#> $NumberIndividualsExpanded
#> integer(0)
```

### Check duplicated records in GFCM Task VII.2 table

The function `check_RD_taskVII2` checks the presence of duplicated records. In particular, it checks whether the combination of the first 9 columns generates duplicate records. The function returns the indices of the duplicated rows, checking the unique combinations of the first 9 columns of the Task VII.2 table.


```r
check_RD_taskVII2(task_vii2)
#> no duplicated lines in the data frame
#> integer(0)
```

### Comparison between min/max lengths observed for each species with theoretical values

The function `check_minmaxl_TaskVII.2` allows to verify the consistency of the lengths reported in the TaskVII.2 table with the theoretical values reported in the minmaxLtaskVII2 table. The function allows to identify the records in which the observed lengths are greater or lower than the expected ones.


```r
check_minmaxl_TaskVII.2(task_vii2,minmaxLtaskVII2,MS="ITA",GSA="18")
#>   Species min_observed max_observed min_theoretical max_theoretical check_min
#> 1     BOG          8.5           18               5             100          
#>   check_max
#> 1
```

### Plot of the relationship length weight for each species

The function `check_lw_TaskVII.2` allows to check the consistency of length-weight relationship in the GFCM Task VII.2 table by species. The function returns a plot of the length weight relationship per species.


```r
check_lw_TaskVII.2(task_vii2, MS = "ITA", GSA = "18", SP = "BOG")
```

![plot of chunk check_lw_TaskVII.2](figure/check_lw_TaskVII.2-1.png)



## Task VII.3.1 table

### Check empty fields in GFCM Task VII.3.1 table

The function `check_EF_TaskVII31` checks the presence of not allowed empty data in the given table, according to the GFCM Data Collection Reference Framework (DCRF, V. 20.1). The function returns two lists. The first list gives the number of NA for each reference column.


```r
check_EF_TaskVII31(task_vii31, verbose=FALSE)[[1]]
#> Reference_Year            CPC            GSA        Species            Sex 
#>              0              0              0              0              0 
#>            L50 
#>              0
```

The second list returns the index of each NA in the reference column.


```r
check_EF_TaskVII31(task_vii31, verbose=FALSE)[[2]]
#> $Reference_Year
#> integer(0)
#> 
#> $CPC
#> integer(0)
#> 
#> $GSA
#> integer(0)
#> 
#> $Species
#> integer(0)
#> 
#> $Sex
#> integer(0)
#> 
#> $L50
#> integer(0)
```

### Comparison between min/max L50 observed for each species and sex with theoretical values

The function `check_minmaxl50_TaskVII.3.1` allows to verify the consistency of L50 reported in the TaskVII.3.1 table with the theoretical values reported in the minmaxLtaskVII31 table. The function allows to identify the records in which the observed L50 are greater or lower than the expected ones.
The function returns a table with the comparison between min/max L50 observed for each species and sex with theoretical values. The field check_max of the returned data frame will contain "Warning" in case of L50 outliers.


```r
check_minmaxl50_TaskVII.3.1(task_vii31,minmaxLtaskVII31,MS="ITA",GSA="19")
#>   Species Sex min_observed max_observed min_theoretical max_theoretical
#> 1     HKE   F         33.6         33.6               5             100
#> 2     HKE   M         17.8         17.8               5             100
#> 3     MTS   F         20.3         20.3               5             100
#> 4     MUT   F         11.4         11.4               5             100
#> 5     MUT   M         10.4         10.4               5             100
#>   check_min check_max
#> 1                    
#> 2                    
#> 3                    
#> 4                    
#> 5
```

### Check duplicated records in GFCM Task VII.3.1 table

The function `check_RD_taskVII31` checks the presence of duplicated records. In particular, it checks whether the combination of the first 5 columns generates duplicate records. The function returns the indices of the duplicated rows, checking the unique combinations of the first 5 columns of the Task VII.3.1 table.


```r
check_RD_taskVII31(task_vii31)
#> no duplicated lines in the data frame
#> integer(0)
```

## Task VII.3.2 table

### Check empty fields in GFCM Task VII.3.2 table

The function `check_EF_TaskVII31` checks the presence of not allowed empty data in the given table, according to the GFCM Data Collection Reference Framework (DCRF, V. 20.1). The function returns two lists. The first list gives the number of NA for each reference column.


```r
check_EF_TaskVII32(task_vii32, verbose=FALSE)[[1]]
#>            Reference_Year                       CPC                       GSA 
#>                         0                         0                         0 
#>                    Source                SurveyName                   Segment 
#>                         0                         0                         0 
#>                   Species                LengthUnit                    Length 
#>                         0                         0                         0 
#>                       Sex                  Maturity NumberIndividualsMeasured 
#>                         0                         0                         0 
#>  WeightIndividualsSampled NumberIndividualsExpanded 
#>                         0                         0
```

The second list returns the index of each NA in the reference column.


```r
check_EF_TaskVII32(task_vii32, verbose=FALSE)[[2]]
#> $Reference_Year
#> integer(0)
#> 
#> $CPC
#> integer(0)
#> 
#> $GSA
#> integer(0)
#> 
#> $Source
#> integer(0)
#> 
#> $SurveyName
#> integer(0)
#> 
#> $Segment
#> integer(0)
#> 
#> $Species
#> integer(0)
#> 
#> $LengthUnit
#> integer(0)
#> 
#> $Length
#> integer(0)
#> 
#> $Sex
#> integer(0)
#> 
#> $Maturity
#> integer(0)
#> 
#> $NumberIndividualsMeasured
#> integer(0)
#> 
#> $WeightIndividualsSampled
#> integer(0)
#> 
#> $NumberIndividualsExpanded
#> integer(0)
```


### Check duplicated records in GFCM Task VII.3.2 table

The function `check_RD_TaskVII32` checks the presence of duplicated records. In particular, it checks whether the combination of the first 10 columns generates duplicate records. The function returns the indices of the duplicated rows, checking the unique combinations of the first 10 columns of the Task VII.3.2 table.


```r
check_RD_TaskVII32(task_vii32)
#> no duplicated lines in the data frame
#> integer(0)
```

### Check mismatching species/Catfau and Sex per maturity stages for Task VII.3.2 table

The function `check_species_catfau_TaskVII.3.2` allows to check the correct codification of faunistic category according to species and sex in Task VII.3.2 table.
Two vectors are returned by the function. The first provides the list of mismatching combination of species/faunistic categories. 


```r
check_species_catfau_TaskVII.3.2(task_vii32,catfau_check,sex_mat, MS="ITA",GSA="18")[[1]]
#> character(0)
```

The second vector provides the list of mismatching combination of sex/maturity stages.


```r
check_species_catfau_TaskVII.3.2(task_vii32,catfau_check,sex_mat, MS="ITA",GSA="18")[[2]]
#> character(0)
```

### Plot of the maturity stages per length for each sex and species

Function `check_lmat_TaskVII.3.2` plots the lengths at maturity stages by species and sex to easily identify outliers. The function return a plot of the maturity stages per length and sex per species.


```r
check_lmat_TaskVII.3.2(task_vii32)
```

![plot of chunk check_lmat_TaskVII.3.2](figure/check_lmat_TaskVII.3.2-1.png)
