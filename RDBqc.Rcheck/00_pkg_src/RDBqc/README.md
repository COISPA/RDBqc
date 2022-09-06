Quality checks on RDBFIS data formats
================

RDBqc allows to carry out a set of *a priori* quality checks on detailed
sampling data and on aggregated landing data, and *a posteriori* quality
check on MEDBS, FDI and GFCM data call formats.

The supported quality checks in version 0.0.8 are:

### *A priori* quality checks

-   RCG CS - biological sampling data
-   RCG CL - aggregated landing data

### *A posteriori* quality checks

-   MEDBS - catch data
-   MEDBS - discard data
-   MEDBS - landing data
-   MEDBS - GP table
-   MEDBS - LW table
-   MEDBS - MA table
-   MEDBS - ML table
-   MEDBS - SA table
-   MEDBS - SL table
-   FDI tables (G, H, I and J)
-   GFCM - Task II.2 table
-   GFCM - Task III table
-   GFCM - Task VII.2 table
-   GFCM - Task VII.3.1 table
-   GFCM - Task VII.3.2 table

# Checks on RCG

Example of Regional Coordination Group Mediterranean & Black Sea data
formats:

**CS table**

``` r
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

``` r
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

This function `RCG_check_LFD` returns an empty data frame if all the
lengths collected are within the length range min_len-max_len; if some
lengths are outside this range, the corresponding records are returned
as a data frame.

``` r
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

``` r
RCG_check_LFD(data_ex,MS="ITA",GSA="GSA99", SP="Mullus barbatus",min_len=6,max_len=250)[[2]]
#> [1] No individual length classes out of the expected range
```

![](README_files/figure-gfm/RCG_check_LFD2-1.png)<!-- -->

### check LFD by commercial categories

This function `RCG_check_LFD_comm_cat` reports for each year and
commercial category the minimum and maximum lengths in the dataset.

``` r
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

A plot of the length distributions by year and commercial category is
also returned:

``` r
RCG_check_LFD_comm_cat(data_ex,MS="ITA",GSA="GSA99", SP="Mullus barbatus")[[2]]
```

![](README_files/figure-gfm/RCG_check_LFD_comm_cat2-1.png)<!-- -->

### Check AL

This function `RCG_check_AL` reports for each year and length class the
number of age measurements in the dataset, providing a summary data
frame.

``` r
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

Moreover, the function detects if the age data are in the range
min_age-max_age, reporting the list of the trip codes including
outliers.

``` r
RCG_check_AL(data_ex,MS="ITA",GSA="GSA99",SP="Mullus barbatus",min_age=0,max_age=5)[[2]]
#> NA included in the 'Age' field have been removed from the analysis.
#> NA included in the 'Length_class' field have been removed from the analysis.
#>  [1] "01_18_2016" "02_18_2016" "05_18_2015" "07_18_2016" "08_18_2016"
#>  [6] "12_18_2015" "17_18_2014" "31_18_2017" "34_18_2016" "4_18_2014" 
#> [11] "57_18_2017" "66_18_2017"
```

A plot of the age/length relationship by sex and year is outputted for
the selected species

``` r
RCG_check_AL(data_ex,MS="ITA",GSA="GSA99",SP="Mullus barbatus",min_age=0,max_age=5)[[3]]
#> NA included in the 'Age' field have been removed from the analysis.
#> NA included in the 'Length_class' field have been removed from the analysis.
```

![](README_files/figure-gfm/RCG_check_AL3-1.png)<!-- -->

### Check lw

This function `RCG_check_lw` plots for each year and sex the
length-weight scatter plot

``` r
RCG_check_lw(data_ex,MS="ITA",GSA="GSA99", SP="Mullus barbatus",Min=0,Max=200)[[2]]
```

![](README_files/figure-gfm/RCG_check_lw2-1.png)<!-- -->

Furthermore, it checks if the weight data are within the boundaries in
input, providing the data frame of the records with the outliers

``` r
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

This function `RCG_check_mat` plots for each year and sex the
length-maturity stage scatter plot

``` r
RCG_check_mat(data_ex,MS="ITA",GSA="GSA99",SP="Mullus barbatus")
```

![](README_files/figure-gfm/RCG_check_mat-1.png)<!-- -->

### check matutity ogive

This function `RCG_check_mat_ogive` plots the maturity ogive by sex
derived from the dataset:

``` r
RCG_check_mat_ogive(data_ex,MS="ITA",GSA="GSA99",SP="Mullus barbatus", sex="F",immature_stages=c("0","1","2a"))
#> Warning: glm.fit: fitted probabilities numerically 0 or 1 occurred
```

![](README_files/figure-gfm/RCG_check_mat_ogive-1.png)<!-- -->

### Summarize individual measurements

This function `RCG_summarize_ind_meas` reports for each trip the number
of length sex, maturity, individual weight and age measurements for a
selected species.

``` r
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

This function `RCG_summarize_trips` reports for the selected species the
number of trips in the dataset for each year, area, harbour, metier and
sampling method.

``` r
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

The function `RCG_check_loc` allows to check the spatial distribution of
data using the initial and final coordinates, where available, and the
ports position included in the data.

``` r
RCG_check_loc(data_ex)
```

![](README_files/figure-gfm/RCG_check_loc-1.png)<!-- -->

## Checks on CL

This function `RCG_check_CL` allows to check the data in the CL table
for the selected species. The output is a list of 6 data frames:

1.  Sum of Landings by year, quarter and month;

``` r
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

2.  Sum of Landing value by year, quarter and month;

``` r
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

3.  Sum of landings by LandCtry, VslFlgCtry, Area, Rect, SubRect,
    Harbour;

``` r
RCG_check_CL(data_exampleCL,MS="COUNTRY1",GSA="GSA99",SP="Parapenaeus longirostris")[[3]]
#>   LandCtry VslFlgCtry  Area Rect SubRect Harbour Sum_Landings
#> 1      999   COUNTRY1 GSA99  999     999    Port      1120455
```

4.  Sum of landing value by LandCtry, VslFlgCtry, Area, Rect, SubRect,
    Harbour;

``` r
RCG_check_CL(data_exampleCL,MS="COUNTRY1",GSA="GSA99",SP="Parapenaeus longirostris")[[4]]
#>   LandCtry VslFlgCtry  Area Rect SubRect Harbour Sum_LandingsValue
#> 1      999   COUNTRY1 GSA99  999     999    Port           5596437
```

5.  Sum of landings by Year, Species, foCatEu5, foCatEu6;

``` r
RCG_check_CL(data_exampleCL,MS="COUNTRY1",GSA="GSA99",SP="Parapenaeus longirostris")[[5]]
#>   Year                  Species foCatEu5         foCatEu6 Sum_Landings
#> 1 1900 Parapenaeus longirostris      999 OTB_DEF_>=40_0_0  1018083.081
#> 2 1900 Parapenaeus longirostris      999 OTB_DWS_>=40_0_0     1453.471
#> 3 1900 Parapenaeus longirostris      999 OTB_MDD_>=40_0_0   100918.089
```

6.  Sum of landing value by Year, Species, foCatEu5, foCatEu6.

``` r
RCG_check_CL(data_exampleCL,MS="COUNTRY1",GSA="GSA99",SP="Parapenaeus longirostris")[[6]]
#>   Year                  Species foCatEu5         foCatEu6 Sum_LandingsValue
#> 1 1900 Parapenaeus longirostris      999 OTB_DEF_>=40_0_0       5050728.907
#> 2 1900 Parapenaeus longirostris      999 OTB_DWS_>=40_0_0          7721.884
#> 3 1900 Parapenaeus longirostris      999 OTB_MDD_>=40_0_0        537986.519
```

7.  Plot of the landings by year and foCatEu6

``` r
RCG_check_CL(data_exampleCL,MS="COUNTRY1",GSA="GSA99",SP="Parapenaeus longirostris")[[7]]
#> geom_path: Each group consists of only one observation. Do you need to adjust
#> the group aesthetic?
```

![](README_files/figure-gfm/RCG_check_CL7-1.png)<!-- -->

# Checks on MEDBS tables

*catch table*

``` r
head(Catch_tab_example)
#>                              ID COUNTRY YEAR QUARTER VESSEL_LENGTH GEAR
#> 1       ITA 2008-1GNS-1DEMFSA 9     ITA 2008      -1            -1  GNS
#> 2   ITA 2010-1OTB50D100DWSPSA 9     ITA 2010      -1            -1  OTB
#> 3   ITA 2014-1OTB50D100DWSPSA 9     ITA 2014      -1            -1  OTB
#> 4  ITA 2008-1OTB50D100DEMSPSA 9     ITA 2008      -1            -1  OTB
#> 5 ITA 2008-1OTB50D100MDDWSPSA 9     ITA 2008      -1            -1  OTB
#> 6  ITA 2007-1OTB50D100DEMSPSA 9     ITA 2007      -1            -1  OTB
#>   MESH_SIZE_RANGE FISHERY AREA SPECON SPECIES  LANDINGS DISCARDS
#> 1              -1    DEMF    9     -1     DPS   0.50829       -1
#> 2          50D100    DWSP    9     -1     DPS   9.69116       -1
#> 3          50D100    DWSP    9     -1     DPS   2.11283       -1
#> 4          50D100   DEMSP    9     -1     DPS 187.26219       -1
#> 5          50D100  MDDWSP    9     -1     DPS  66.06531       -1
#> 6          50D100   DEMSP    9     -1     DPS  89.84975       -1
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

*landings table*

``` r
head(Landing_tab_example)
#>                             id country year quarter vessel_length gear
#> 1     ITA 2003 1GTR-1DEMSPSA 9     ITA 2003      -1            -1  GTR
#> 2      ITA 2003 1OTB50D100SA 9     ITA 2003      -1            -1  OTB
#> 3      ITA 2004-1GNS-1DEMFSA 9     ITA 2004      -1            -1  GNS
#> 4     ITA 2004-1GTR-1DEMSPSA 9     ITA 2004      -1            -1  GTR
#> 5 ITA 2004-1OTB50D100DEMSPSA 9     ITA 2004      -1            -1  OTB
#> 6     ITA 2005-1GTR-1DEMSPSA 9     ITA 2005      -1            -1  GTR
#>   mesh_size_range fishery area specon species   landings unit lengthclass0
#> 1              -1   DEMSP    9     -1     DPS   5.933227   mm            0
#> 2          50D100      -1    9     -1     DPS 316.615971   mm            0
#> 3              -1    DEMF    9     -1     DPS   3.628830   mm            0
#> 4              -1   DEMSP    9     -1     DPS   4.177760   mm            0
#> 5          50D100      -1    9     -1     DPS 367.431910   mm            0
#> 6              -1   DEMSP    9     -1     DPS   0.517960   mm            0
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

*discards table*

``` r
head(Discard_tab_example)
#>      id country year quarter vessel_length gear mesh_size_range fishery area
#> 1 44554     ITA 2009      -1            -1  OTB          50D100   DEMSP    9
#> 2 44571     ITA 2010      -1            -1  OTB          50D100   DEMSP    9
#> 3 44583     ITA 2010      -1            -1  OTB          50D100  MDDWSP    9
#> 4 44593     ITA 2011      -1            -1  OTB          50D100   DEMSP    9
#> 5 44603     ITA 2011      -1            -1  OTB          50D100  MDDWSP    9
#> 6 44612     ITA 2012      -1            -1  OTB          50D100   DEMSP    9
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

### Check catches coverage

The function `MEDBS_Catch_coverage` allows to check the coverage in
Catch table by mean of summary tables summarizing both landing and
discard volumes and producing relative plots for the selected species.
In particular:

1.  summary table of landings

``` r
results <- suppressMessages(MEDBS_Catch_coverage(Catch_tab_example,"DPS","ITA","9"))
head(results[[1]])
#>   COUNTRY YEAR QUARTER VESSEL_LENGTH GEAR MESH_SIZE_RANGE FISHERY AREA SPECIES
#> 1     ITA 2004      -1            -1  OTB          50D100      -1    9     DPS
#> 2     ITA 2004      -1            -1  GNS              -1    DEMF    9     DPS
#> 3     ITA 2007      -1            -1  GNS              -1    DEMF    9     DPS
#> 4     ITA 2008      -1            -1  GNS              -1    DEMF    9     DPS
#> 5     ITA 2014      -1            -1  GNS              -1    DEMF    9     DPS
#> 6     ITA 2017       2            -1  GNS              -1    DEMF    9     DPS
#>    LANDINGS
#> 1 367.43191
#> 2   3.62883
#> 3   2.26308
#> 4   0.50829
#> 5   0.02736
#> 6   0.02688
```

2.  summary table of discards

``` r
head(results[[2]])
#>    COUNTRY YEAR QUARTER VESSEL_LENGTH GEAR MESH_SIZE_RANGE FISHERY AREA SPECIES
#> 5      ITA 2014      -1            -1  GNS              -1    DEMF    9     DPS
#> 6      ITA 2017       2            -1  GNS              -1    DEMF    9     DPS
#> 7      ITA 2003      -1            -1  GTR              -1   DEMSP    9     DPS
#> 10     ITA 2012      -1            -1  GTR              -1   DEMSP    9     DPS
#> 11     ITA 2003      -1            -1  OTB              -1   DEMSP    9     DPS
#> 13     ITA 2006      -1            -1  OTB          50D100   DEMSP    9     DPS
#>    DISCARDS
#> 5         0
#> 6         0
#> 7         0
#> 10        0
#> 11        0
#> 13        0
```

3.  Plot of landing volumes in catch table

``` r
results[[3]]
```

![](README_files/figure-gfm/MEDBS_Catch_coverage3-1.png)<!-- -->

4.  Plot of discard volumes in catch table

``` r
results[[4]]
```

![](README_files/figure-gfm/MEDBS_Catch_coverage4-1.png)<!-- -->

## Checks on discard and landing tables

### check duplicated records

The function `MEDBS_check_duplicates` checks the presence of duplicated
rows in both landings

``` r
Landing_tab_example <- rbind(Landing_tab_example,Landing_tab_example[1,])
MEDBS_check_duplicates(data=Landing_tab_example,type="l",MS="ITA",GSA="9",SP="DPS",verbose=TRUE)
#> There is/are 1 replicated row/rows in the data.
#>                          id country year quarter vessel_length gear
#> 58 ITA 2003 1GTR-1DEMSPSA 9     ITA 2003      -1            -1  GTR
#>    mesh_size_range fishery area specon species landings
#> 58              -1   DEMSP    9     -1     DPS 5.933227
```

and discards data

``` r
Discard_tab_example <- rbind(Discard_tab_example,Discard_tab_example[1,])
MEDBS_check_duplicates(data=Discard_tab_example,type="d",MS="ITA",GSA="9",SP="DPS",verbose=TRUE)
#> There is/are 1 replicated row/rows in the data.
#>       id country year quarter vessel_length gear mesh_size_range fishery area
#> 22 44554     ITA 2009      -1            -1  OTB          50D100   DEMSP    9
#>    specon species discards
#> 22     -1     DPS 38.35542
```

## Kolmogorov-Smirnov test

The function `MEDBS_ks` allows to perform the Kolmogorov-Smirnov test on
both landings and discards for a selected species. The function performs
Kolmogorov-Smirnov tests on couples of years to assess if they belong to
the same population, returning a summary data frame. The function
returns also the cumulative length distribution plots by fishery and
year.

``` r
ks <- MEDBS_ks(data=Landing_tab_example, type="l",MS="ITA",GSA="9", SP="DPS",Rt=1)
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

![](README_files/figure-gfm/MEDBS_ks_landing1-1.png)<!-- -->

``` r
results <- ks[[1]]
head(results)
#>            Group  NTot_yr1  NTot_yr2  Dmax      Dcalc H0_p0.05
#> Ds  2003 vs 2004 18516.419 22257.632 0.091 0.01720759 rejected
#> Ds1 2005 vs 2006  6167.447  3434.857 0.728 0.03683212 rejected
#> Ds2 2005 vs 2007  6167.447  7099.281 0.589 0.03011398 rejected
#> Ds3 2005 vs 2008  6167.447 19314.227 0.415 0.02530281 rejected
#> Ds4 2005 vs 2009  6167.447 22104.507 0.445 0.02491328 rejected
#> Ds5 2005 vs 2010  6167.447 36354.889 0.407 0.02382432 rejected
#>                           Comment        ID
#> Ds  not belong to same population    OTB_-1
#> Ds1 not belong to same population OTB_DEMSP
#> Ds2 not belong to same population OTB_DEMSP
#> Ds3 not belong to same population OTB_DEMSP
#> Ds4 not belong to same population OTB_DEMSP
#> Ds5 not belong to same population OTB_DEMSP
```

``` r
# plot(ks[[3]])
```

### Check consistency of length data

The function `MEDBS_length_ind` allows to check the consistency of
length data for a selected species on both landings and discards
returning a summary table of the main length size indicators time series
by fishery.

``` r
results <- MEDBS_length_ind(Discard_tab_example,type="d",MS=c("ITA"),GSA=c("9"),SP="DPS", splines=c(0.2,0.4,0.6,0.8),Xtresholds = c(0.25,0.5,0.75))
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

A plot of the time series of mean length in discards and landings is
returned.

``` r
results[[2]]
```

![](README_files/figure-gfm/MEDBS_length_ind_plot1-1.png)<!-- -->

A plot of the time series of median length in discards and landings is
returned.

``` r
results[[3]]
```

![](README_files/figure-gfm/MEDBS_length_ind_plot2-1.png)<!-- -->

### Check of null individuals in landings and discards

The function `MEDBS_lengthclass_0` checks landings and discards for the
presence of length class filled in having weigth \> 0, returning a data
frame with the rows with 0 values length class having weigth \> 0.

``` r
results <- MEDBS_lengthclass_0(data=Landing_tab_example,type="l",MS="ITA",GSA=9,SP="DPS",verbose=TRUE)
#> 17 cases in which length class number are zero and landings > 0
head(results)
#>                               id country year quarter vessel_length gear
#> 1       ITA 2003 1GTR-1DEMSPSA 9     ITA 2003      -1            -1  GTR
#> 3        ITA 2004-1GNS-1DEMFSA 9     ITA 2004      -1            -1  GNS
#> 4       ITA 2004-1GTR-1DEMSPSA 9     ITA 2004      -1            -1  GTR
#> 6       ITA 2005-1GTR-1DEMSPSA 9     ITA 2005      -1            -1  GTR
#> 10 ITA 2006-1OTB50D100MDDWSPSA 9     ITA 2006      -1            -1  OTB
#> 11       ITA 2007-1GNS-1DEMFSA 9     ITA 2007      -1            -1  GNS
#>    mesh_size_range fishery area specon species   landings ck_0_length
#> 1               -1   DEMSP    9     -1     DPS   5.933227           0
#> 3               -1    DEMF    9     -1     DPS   3.628830           0
#> 4               -1   DEMSP    9     -1     DPS   4.177760           0
#> 6               -1   DEMSP    9     -1     DPS   0.517960           0
#> 10          50D100  MDDWSP    9     -1     DPS 407.103060           0
#> 11              -1    DEMF    9     -1     DPS   2.263080           0
```

### weight 0 in landings and discards

The function `MEDBS_weight_0` checks landings or discards in weight
equal to 0 having length classes filled in, returning the number of rows
with 0 values in weights having length classes filled in.

``` r
MEDBS_weight_0(data=Discard_tab_example,type="d",MS="ITA",GSA=9,SP="DPS", verbose=TRUE)
#> There aren't 0 discards
#> [1] 0
```

### weight -1 in landings and discards

The function `MEDBS_weight_minus1` checks landings in weight equal to -1
having length class filled in, returning the number of rows with -1
values in landing weights having length class filled in.

``` r
MEDBS_weight_minus1(data=Discard_tab_example,type="d",MS="ITA",GSA=9,SP="DPS",verbose=TRUE)
#> There aren't -1 discards
#> [1] 0
```

### Years with missing length distributions

The function `MEDBS_yr_missing_length` checks the presence of years with
missing length distributions in both landings and discards for a
selected species. A data frame of the missing length distributions is
returned.

``` r
results <- MEDBS_yr_missing_length(data=Landing_tab_example,type="l",MS=c("ITA"),GSA=c("9"),SP="DPS")
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

The function `MEDBS_comp_land_Q_VL` allows to perform the comparison of
landings of a selected species aggregated by quarters accounting for the
presence of vessel length. A dataframe for the comparison of landings
aggregated by quarters accounting for the presence of vessel length
information is returned.

``` r
results <- suppressMessages(MEDBS_comp_land_Q_VL(land = Landing_tab_example, 
           MS = "ITA", GSA = 9, SP = "DPS"))
head(results)
#>   year gear quarter    tot_VL tot_NoVL ratio
#> 1 2003  GTR      -1  11.86645       NA    NA
#> 2 2003  OTB      -1 316.61597       NA    NA
#> 3 2004  GNS      -1   3.62883       NA    NA
#> 4 2004  GTR      -1   4.17776       NA    NA
#> 5 2004  OTB      -1 367.43191       NA    NA
#> 6 2005  GTR      -1   0.51796       NA    NA
```

### Comparison between landings in weight by quarter and fishery accounting for vessel length

The function `MEDBS_comp_land_Q_VL_fishery` allows to perform the
comparison of landings of a selected species aggregated by quarters and
fishery accounting for the presence of vessel length. The function
returns a data frame for the comparison of landings aggregated by
quarters and fishery accounting for the presence of vessel length
information.

``` r
results <- suppressMessages(MEDBS_comp_land_Q_VL_fishery(land = Landing_tab_example, 
        MS = "ITA", GSA = 9, SP = "DPS"))
head(results)
#>   year gear fishery quarter    tot_VL tot_NoVL ratio
#> 1 2003  GTR   DEMSP      -1  11.86645       NA    NA
#> 2 2003  OTB      -1      -1 316.61597       NA    NA
#> 3 2004  GNS    DEMF      -1   3.62883       NA    NA
#> 4 2004  GTR   DEMSP      -1   4.17776       NA    NA
#> 5 2004  OTB      -1      -1 367.43191       NA    NA
#> 6 2005  GTR   DEMSP      -1   0.51796       NA    NA
```

### Comparison between landings in weight by quarter and -1

The function `MEDBS_comp_land_YQ` allows to perform the comparison of
landings of a selected species aggregated by quarters and by year. The
function returns a data frame for the comparison of landings aggregated
by quarters and by year.

``` r
MEDBS_comp_land_YQ(land=Landing_tab_example,MS="ITA",GSA=9,SP="DPS")
#>    year gear     tot_q    tot_yr  ratio
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

The function `MEDBS_comp_land_YQ_fishery` allows to perform the
comparison of landings of a selected species aggregated by quarters and
by year and fishery. The function returns a data frame for the
comparison of landings aggregated by quarters and by year and fishery.

``` r
results <- suppressMessages(MEDBS_comp_land_YQ_fishery(land = Landing_tab_example, MS = "ITA", GSA = 9, SP = "DPS"))
head(results)
#>   year gear fishery tot_q    tot_yr ratio
#> 1 2003  GTR   DEMSP    NA  11.86645    NA
#> 2 2003  OTB      -1    NA 316.61597    NA
#> 3 2004  GNS    DEMF    NA   3.62883    NA
#> 4 2004  GTR   DEMSP    NA   4.17776    NA
#> 5 2004  OTB      -1    NA 367.43191    NA
#> 6 2005  GTR   DEMSP    NA   0.51796    NA
```

### Check mean weight by year,gear and fishery aggregation

The function `MEDBS_land_mean_weight` allows to check consistency of
mean landing of a selected species plotting the landings’ weight by
year, gear and fishery. A summary data frame is returned.

``` r
results <- MEDBS_land_mean_weight(land=Landing_tab_example,MS="ITA",GSA=9,SP="DPS")[[1]]
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

The function returns a plot of the mean landing weight by year, gear and
fishery aggregation as well.

``` r
MEDBS_land_mean_weight(land=Landing_tab_example,MS="ITA",GSA=9,SP="DPS")[[2]]
```

![](README_files/figure-gfm/MEDBS_land_mean_weight2-1.png)<!-- -->

### Plot of total landing by gear and fishery

The function `MEDBS_plot_land_vol` allows to visual check the time
series of landing volumes by fishery of a selected species. The function
returns a plot of the total landing time series by fishery and gear.

``` r
MEDBS_plot_land_vol(data=Landing_tab_example,MS="ITA",GSA=9,SP="DPS")
```

![](README_files/figure-gfm/MEDBS_plot_land_vol-1.png)<!-- -->

### Plot of total landing

The function `MEDBS_plot_landing_ts` estimates the total landings time
series by both year and quarters for a selected combination of member
state, GSA and species. The function returns a plot of the total landing
time series by year or by quarters. The plot by year also reports the
landing by gear.

``` r
suppressMessages(MEDBS_plot_landing_ts(land=Landing_tab_example,MS="ITA",GSA=9,SP="DPS",by="quarter"))
```

![](README_files/figure-gfm/MEDBS_plot_landing_ts-1.png)<!-- -->

### check the coverage in Landing table

The function `MEDBS_Landing_coverage` allows to check the coverage in
landing table providing a summary table

``` r
results <- suppressMessages(MEDBS_Landing_coverage(Landing_tab_example,"DPS","ITA","9"))
head(results[[1]])
#>   country year quarter vessel_length gear mesh_size_range fishery area species
#> 1     ITA 2003      -1            -1  OTB          50D100      -1    9     DPS
#> 2     ITA 2004      -1            -1  OTB          50D100      -1    9     DPS
#> 3     ITA 2004      -1            -1  GNS              -1    DEMF    9     DPS
#> 4     ITA 2007      -1            -1  GNS              -1    DEMF    9     DPS
#> 5     ITA 2008      -1            -1  GNS              -1    DEMF    9     DPS
#> 6     ITA 2014      -1            -1  GNS              -1    DEMF    9     DPS
#>    landings
#> 1 316.61597
#> 2 367.43191
#> 3   3.62883
#> 4   2.26308
#> 5   0.50829
#> 6   0.02736
```

a plot of the landing coverage is also provided.

``` r
results[[2]]
```

![](README_files/figure-gfm/MEDBS_Landing_coverage2-1.png)<!-- -->

## Checks on discards

### check the coverage in discard table

The function `MEDBS_discard_coverage` allows to check the coverage of
the time series in discard table for a selected species. The function
returns a summary table.

``` r
results <- suppressMessages(MEDBS_discard_coverage(Discard_tab_example,"DPS","ITA","9"))
head(results[[1]])
#>   country year quarter vessel_length gear mesh_size_range fishery area species
#> 1     ITA 2009      -1            -1  OTB          50D100   DEMSP    9     DPS
#> 2     ITA 2010      -1            -1  OTB          50D100   DEMSP    9     DPS
#> 3     ITA 2011      -1            -1  OTB          50D100   DEMSP    9     DPS
#> 4     ITA 2012      -1            -1  OTB          50D100   DEMSP    9     DPS
#> 5     ITA 2013      -1            -1  OTB          50D100   DEMSP    9     DPS
#> 6     ITA 2014      -1            -1  OTB          50D100   DEMSP    9     DPS
#>    discards
#> 1 76.710840
#> 2 24.396528
#> 3 60.519315
#> 4  6.571266
#> 5 26.761695
#> 6 44.978926
```

A plots of discard time series by year and gear is also provided.

``` r
results[[2]]
```

![](README_files/figure-gfm/MEDBS_discard_coverage2-1.png)<!-- -->

### Comparison between discards in weight by quarter and -1

The function `MEDBS_comp_disc_YQ` allows to compare the discards weights
aggregated by quarter and by year for a selected species at the gear
level. The function returns a data frame for the comparison of discards
aggregated by quarters and by year

``` r
MEDBS_comp_disc_YQ(disc=Discard_tab_example,MS="ITA",GSA=9,SP="DPS")
#>   year gear    tot_q    tot_yr ratio
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

The function `MEDBS_comp_disc_YQ_fishery` allow to estimates the
discards in weight for a selected species by quarter and fishery. The
function returns a data frame for the comparison of discards aggregated
by quarters and by year and fishery

``` r
results <- MEDBS_comp_disc_YQ_fishery(disc=Discard_tab_example,MS="ITA",GSA=9,SP="DPS")
head(results)
#>   year gear fishery tot_q    tot_yr ratio
#> 1 2009  OTB   DEMSP    NA 76.710840    NA
#> 2 2010  OTB   DEMSP    NA 24.396528    NA
#> 3 2010  OTB  MDDWSP    NA  2.703603    NA
#> 4 2011  OTB   DEMSP    NA 60.519315    NA
#> 5 2011  OTB  MDDWSP    NA  2.743526    NA
#> 6 2012  OTB   DEMSP    NA  6.571266    NA
```

### Check mean weight by year,gear and fishery aggregation in discard

The function `MEDBS_disc_mean_weight` allows to check consistency of
mean discard weight of a selected species providing a table of the mean
individual weight by year, gear and fishery.

``` r
results <- MEDBS_disc_mean_weight(disc=Discard_tab_example,MS="ITA",GSA=9,SP="DPS")
head(results[[1]])
#>   year quarter vessel_length gear mesh_size_range fishery     totW       totN
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

The function also returns a plot of the mean discards weight by year,
gear and fishery aggregation.

``` r
results[[2]]
#> geom_path: Each group consists of only one observation. Do you need to adjust
#> the group aesthetic?
#> geom_path: Each group consists of only one observation. Do you need to adjust
#> the group aesthetic?
```

![](README_files/figure-gfm/MEDBS_disc_mean_weight2-1.png)<!-- -->

### Plot of total discards by gear and fishery

The function `MEDBS_plot_disc_vol` allows to visual check the time
series of discard volumes by fishery of a selected species. The function
returns a plot of the total discards time series by fishery and gear.

``` r
MEDBS_plot_disc_vol(data=Discard_tab_example,MS="ITA",GSA=9,SP="DPS")
```

![](README_files/figure-gfm/MEDBS_plot_disc_vol-1.png)<!-- -->

### Plot of total discards time series

The function `MEDBS_plot_discard_ts` estimates the total discard time
series by both year and quarters for a selected combination of member
state, GSA and species. The function returns a plot of the total discard
time series by year or by quarters. The parameter `by="year"` also
reports the landing by gear.

``` r
MEDBS_plot_discard_ts(disc=Discard_tab_example,MS="ITA",GSA=9,SP="DPS",by="quarter")
```

![](README_files/figure-gfm/MEDBS_plot_discard_ts-1.png)<!-- -->

## Other checks

### GP_tab (growth params) table check

The function `GP_check` allows to check the growth parameters by sex and
year for a selected species. The function returns a list of objects
containing a summary table and different plots of the growth curves by
sex

``` r
results <- GP_check(GP_tab_example,"MUT","ITA","18")
results[[1]]
#>    COUNTRY YEAR START_YEAR END_YEAR SPECIES SEX
#> 1      ITA   18       2014     2014     MUT   C
#> 2      ITA   18       2015     2015     MUT   C
#> 3      ITA   18       2016     2016     MUT   C
#> 4      ITA   18       2017     2017     MUT   C
#> 5      ITA   18       2014     2014     MUT   F
#> 6      ITA   18       2015     2015     MUT   F
#> 7      ITA   18       2016     2016     MUT   F
#> 8      ITA   18       2017     2017     MUT   F
#> 9      ITA   18       2014     2014     MUT   M
#> 10     ITA   18       2015     2015     MUT   M
#> 11     ITA   18       2016     2016     MUT   M
#> 12     ITA   18       2017     2017     MUT   M
print(names(results)[1])
#> [1] "summary table"
```

``` r
print(names(results)[2])
#> [1] "VBGF _ MUT _ ITA _ 18"
results[[2]]
```

![](README_files/figure-gfm/GP_check2-1.png)<!-- -->

``` r
print(names(results)[3])
#> [1] "VBGF_year _ MUT _ ITA _ 18 _ F"
results[[3]]
```

![](README_files/figure-gfm/GP_check3-1.png)<!-- -->

``` r
print(names(results)[4])
#> [1] "VBGF_year _ MUT _ ITA _ 18 _ M"
results[[4]]
```

![](README_files/figure-gfm/GP_check4-1.png)<!-- -->

``` r
print(names(results)[5])
#> [1] "VBGF_year _ MUT _ ITA _ 18 _ C"
results[[5]]
```

![](README_files/figure-gfm/GP_check-1.png)<!-- -->

``` r
print(names(results)[6])
#> [1] "VBGF_cum _ MUT _ ITA _ 18 _ F"
results[[6]]
```

![](README_files/figure-gfm/GP_check6-1.png)<!-- -->

``` r
print(names(results)[7])
#> [1] "VBGF_cum _ MUT _ ITA _ 18 _ M"
results[[7]]
```

![](README_files/figure-gfm/GP_check7-1.png)<!-- -->

``` r
print(names(results)[8])
#> [1] "VBGF_cum _ MUT _ ITA _ 18 _ C"
results[[8]]
```

![](README_files/figure-gfm/GP_check8-1.png)<!-- -->

### LW params in GP_tab in table check

The function `MEDBS_LW_check` allows to check the length-weight
parameters included in the GP table for a selected species. The function
returns a summary table.

``` r
results <- MEDBS_LW_check(GP_tab_example,"MUT","ITA","18")
results[[1]]
#>    COUNTRY AREA START_YEAR END_YEAR SPECIES SEX NA
#> 1      ITA   18       2014     2014     MUT   C  1
#> 2      ITA   18       2015     2015     MUT   C  1
#> 3      ITA   18       2016     2016     MUT   C  1
#> 4      ITA   18       2017     2017     MUT   C  1
#> 5      ITA   18       2014     2014     MUT   F  1
#> 6      ITA   18       2015     2015     MUT   F  1
#> 7      ITA   18       2016     2016     MUT   F  1
#> 8      ITA   18       2017     2017     MUT   F  1
#> 9      ITA   18       2014     2014     MUT   M  1
#> 10     ITA   18       2015     2015     MUT   M  1
#> 11     ITA   18       2016     2016     MUT   M  1
#> 12     ITA   18       2017     2017     MUT   M  1
```

plots of the length-weigth relationships for the selected species by
year and sex are also returned.

``` r
results[[2]]
```

![](README_files/figure-gfm/MEDBS_LW_check2-1.png)<!-- -->

``` r
results[[3]]
```

![](README_files/figure-gfm/MEDBS_LW_check2-2.png)<!-- -->

``` r
results[[4]]
```

![](README_files/figure-gfm/MEDBS_LW_check2-3.png)<!-- -->

``` r
results[[5]]
```

![](README_files/figure-gfm/MEDBS_LW_check2-4.png)<!-- -->

``` r
results[[6]]
```

![](README_files/figure-gfm/MEDBS_LW_check2-5.png)<!-- -->

``` r
results[[7]]
```

![](README_files/figure-gfm/MEDBS_LW_check2-6.png)<!-- -->

``` r
results[[8]]
```

![](README_files/figure-gfm/MEDBS_LW_check2-7.png)<!-- -->

### MA_tab (maturity at age) table check

The function `MEDBS_MA_check` allows to check the maturity at age (MA)
table providing a summary table of the data coverage.

``` r
results <- MEDBS_MA_check(MA_tab_example,"DPS","ITA","9")
results[[1]]
#>    COUNTRY YEAR START_YEAR END_YEAR SPECIES SEX
#> 1      ITA    9       2006     2006     DPS   F
#> 2      ITA    9       2007     2007     DPS   F
#> 3      ITA    9       2008     2008     DPS   F
#> 4      ITA    9       2009     2009     DPS   F
#> 5      ITA    9       2010     2010     DPS   F
#> 6      ITA    9       2011     2011     DPS   F
#> 7      ITA    9       2012     2012     DPS   F
#> 8      ITA    9       2013     2013     DPS   F
#> 9      ITA    9       2014     2014     DPS   F
#> 10     ITA    9       2015     2015     DPS   F
#> 11     ITA    9       2016     2016     DPS   F
#> 12     ITA    9       2017     2016     DPS   F
```

The function also provides plots for the selected species of the
proportion of matures for age class by sex and year.

``` r
results[[2]]
```

![](README_files/figure-gfm/MEDBS_MA_check2-1.png)<!-- -->

``` r
results[[3]]
```

![](README_files/figure-gfm/MEDBS_MA_check2-2.png)<!-- -->

### ML_tab (maturity at length) table check

The function `MEDBS_ML_check` allows to check the maturity at length
(ML) table providing a summary table of the data coverage for the
selected species of the proportion of matures for age class by sex and
year.

``` r
results <- MEDBS_ML_check(ML_tab_example, "DPS", "ITA", "9")
```

![](README_files/figure-gfm/MEDBS_ML_check1-1.png)<!-- -->![](README_files/figure-gfm/MEDBS_ML_check1-2.png)<!-- -->

``` r
results[[1]]
#>    COUNTRY YEAR START_YEAR END_YEAR SPECIES SEX
#> 1      ITA    9       2006     2006     DPS   F
#> 2      ITA    9       2007     2007     DPS   F
#> 3      ITA    9       2008     2008     DPS   F
#> 4      ITA    9       2009     2009     DPS   F
#> 5      ITA    9       2010     2010     DPS   F
#> 6      ITA    9       2011     2011     DPS   F
#> 7      ITA    9       2012     2012     DPS   F
#> 8      ITA    9       2013     2013     DPS   F
#> 9      ITA    9       2014     2014     DPS   F
#> 10     ITA    9       2015     2015     DPS   F
#> 11     ITA    9       2016     2016     DPS   F
#> 12     ITA    9       2017     2017     DPS   F
```

Plots for the selected species of the proportion of matures for age
class by sex and year are also returned.

``` r
results[[2]]
```

![](README_files/figure-gfm/MEDBS_ML_check2-1.png)<!-- -->

``` r
results[[3]]
```

![](README_files/figure-gfm/MEDBS_ML_check2-2.png)<!-- -->

### SA_tab (sex ratio at age) table check

The function `MEDBS_SA_check` allows to check the sex ratio at age (SA)
table providing a summary table of the data coverage for the selected
species of the proportion of sex ratio for age class by year.

``` r
results <- MEDBS_SA_check(SA_tab_example, "DPS", "ITA", "9")
results[[1]]
#>    COUNTRY YEAR START_YEAR END_YEAR SPECIES
#> 1      ITA    9       2003     2005     DPS
#> 2      ITA    9       2006     2006     DPS
#> 3      ITA    9       2007     2007     DPS
#> 4      ITA    9       2008     2008     DPS
#> 5      ITA    9       2009     2009     DPS
#> 6      ITA    9       2010     2010     DPS
#> 7      ITA    9       2011     2011     DPS
#> 8      ITA    9       2012     2012     DPS
#> 9      ITA    9       2013     2013     DPS
#> 10     ITA    9       2014     2014     DPS
#> 11     ITA    9       2015     2015     DPS
#> 12     ITA    9       2016     2016     DPS
#> 13     ITA    9       2017     2017     DPS
```

Plots for the selected species of the proportion of sex ratio for age
class by year are also returned.

``` r
results[[2]]
```

![](README_files/figure-gfm/MEDBS_SA_check2-1.png)<!-- -->

``` r
results[[3]]
```

![](README_files/figure-gfm/MEDBS_SA_check2-2.png)<!-- -->

### SL_tab (sex ratio at length) table check

The function `MEDBS_SL_check` allows to check the sex ratio at length
(SL) table providing a summary table of the data coverage for the
selected species of the proportion of sex ratio for length class by
year.

``` r
results <- MEDBS_SL_check(SL_tab_example,"DPS","ITA","9")
results[[1]]
#>    COUNTRY YEAR START_YEAR END_YEAR SPECIES
#> 1      ITA    9       2003     2005     DPS
#> 2      ITA    9       2006     2006     DPS
#> 3      ITA    9       2007     2007     DPS
#> 4      ITA    9       2008     2008     DPS
#> 5      ITA    9       2009     2009     DPS
#> 6      ITA    9       2010     2010     DPS
#> 7      ITA    9       2011     2011     DPS
#> 8      ITA    9       2012     2012     DPS
#> 9      ITA    9       2013     2013     DPS
#> 10     ITA    9       2014     2014     DPS
#> 11     ITA    9       2015     2015     DPS
#> 12     ITA    9       2016     2016     DPS
#> 13     ITA    9       2017     2017     DPS
```

Plots for the selected species of the proportion of sex ratio for length
class by year are returned.

``` r
results[[2]]
```

![](README_files/figure-gfm/MEDBS_SL_check2-1.png)<!-- -->

``` r
results[[3]]
```

![](README_files/figure-gfm/MEDBS_SL_check2-2.png)<!-- -->

# Checks on FDI tables

## Table G

### Check empty fields in FDI G table

The function `check_EF_FDI_G` checks the presence of not allowed empty
data in the given table, according to the ‘Fisheries Dependent
Information data call 2021 - Annex 1’. A list is returned by the
function. The first list’s object is a vector containing the number of
NA for each reference column.

``` r
check_EF_FDI_G(fdi_g_effort, verbose=FALSE)[[1]]
#>           country              year           quarter     vessel_length 
#>                 0                 0                 0                 0 
#>      fishing_tech         gear_type target_assemblage   mesh_size_range 
#>                 0                 0                 0                 0 
#>            metier      supra_region        sub_region     eez_indicator 
#>                 0                 0                 0                 0 
#>     geo_indicator       specon_tech              deep        totseadays 
#>                 0                 0                 0                 0 
#>    totkwdaysatsea    totgtdaysatsea       totfishdays     totkwfishdays 
#>                 0                 0                 0                 0 
#>     totgtfishdays             hrsea           kwhrsea           gthrsea 
#>                 0                 0                 0                 0 
#>            totves      confidential 
#>                 0                 0
```

The second list’s object gives the index of each NA in the reference
column.

``` r
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
#> integer(0)
#> 
#> $totfishdays
#> integer(0)
#> 
#> $totkwfishdays
#> integer(0)
#> 
#> $totgtfishdays
#> integer(0)
#> 
#> $hrsea
#> integer(0)
#> 
#> $kwhrsea
#> integer(0)
#> 
#> $gthrsea
#> integer(0)
#> 
#> $totves
#> integer(0)
#> 
#> $confidential
#> integer(0)
```

### Check duplicated records in FDI G table

The function `check_RD_FDI_G` check the presence of duplicated records.
In particular, it checks whether the combination of the first 15 columns
generates duplicate records. The function returns the indices of the
duplicated rows.

``` r
g_effort <- rbind(fdi_g_effort,fdi_g_effort[1,])
check_RD_FDI_G(g_effort)
#> 1 record/s duplicated
#> [1] 6
```

## Table H

### Check empty fields in FDI H table

The function `check_EF_FDI_H` checks the presence of not allowed empty
data in the given table, according to the ‘Fisheries Dependent
Information data call 2021 - Annex 1’. A list is returned by the
function. The first list’s object is a vector containing the number of
NA for each reference column.

``` r
check_EF_FDI_H(fdi_h_spatial_land, verbose=FALSE)[[1]]
#>           country              year           quarter     vessel_length 
#>                 0                 0                 0                 0 
#>      fishing_tech         gear_type target_assemblage   mesh_size_range 
#>                 0                 0                 0                 0 
#>            metier      supra_region        sub_region     eez_indicator 
#>                 0                 0                 0                 0 
#>     geo_indicator       specon_tech              deep    rectangle_type 
#>                 0                 0                 0                 0 
#>     rectangle_lat     rectangle_lon          c_square           species 
#>                 0                 0                 0                 0 
#>      totwghtlandg       totvallandg      confidential 
#>                 0                 0                 0
```

The second list’s object gives the index of each NA in the reference
column.

``` r
check_EF_FDI_H(fdi_h_spatial_land, verbose=FALSE)[[2]]
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
#> integer(0)
#> 
#> $deep
#> integer(0)
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
#> integer(0)
```

### Check duplicated records in FDI H table

The function `check_RD_FDI_H` check the presence of duplicated records.
In particular, it checks whether the combination of the first 15 columns
generates duplicate records. The function returns the indices of the
duplicated rows.

``` r
h_spatial_land <- rbind(fdi_h_spatial_land,fdi_h_spatial_land[1,])
check_RD_FDI_H(h_spatial_land)
#> 1 record/s duplicated
#> [1] 6
```

## Table I

### Check empty fields in FDI I table

The function `check_EF_FDI_I` checks the presence of not allowed empty
data in the given table, according to the ‘Fisheries Dependent
Information data call 2021 - Annex 1’. A list is returned by the
function. The first list’s object is a vector containing the number of
NA for each reference column.

``` r
check_EF_FDI_I(fdi_i_spatial_effort,verbose=FALSE)[[1]]
#>           country              year           quarter     vessel_length 
#>                 0                 0                 0                 0 
#>      fishing_tech         gear_type target_assemblage   mesh_size_range 
#>                 0                 0                 0                 0 
#>            metier      supra_region        sub_region     eez_indicator 
#>                 0                 0                 0                 0 
#>     geo_indicator       specon_tech              deep    rectangle_type 
#>                 0                 0                 0                 0 
#>     rectangle_lat     rectangle_lon          c_square       totfishdays 
#>                 0                 0                 0                 0 
#>      confidential 
#>                 0
```

The second list’s object gives the index of each NA in the reference
column.

``` r
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
#> integer(0)
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
#> integer(0)
#> 
#> $deep
#> integer(0)
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

The function `check_RD_FDI_I` check the presence of duplicated records.
In particular, it checks whether the combination of the first 15 columns
generates duplicate records. The function returns the indices of the
duplicated rows.

``` r
i_spatial_fe <- rbind(fdi_i_spatial_effort,fdi_i_spatial_effort[1,])
check_RD_FDI_I(i_spatial_fe)
#> 1 record/s duplicated
#> [1] 6
```

## Table J

### Check empty fields in FDI J table

The function `check_EF_FDI_J` checks the presence of not allowed empty
data in the given table, according to the Fisheries Dependent
Information data call 2021 - Annex 1. A list is returned by the
function. The first list’s object is a vector containing the number of
NA for each reference column.

``` r
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

The second list’s object gives the index of each NA in the reference
column.

``` r
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

The function `check_RD_FDI_J` check the presence of duplicated records.
In particular, it checks whether the combination of the first 15 columns
generates duplicate records. The function returns the indices of the
duplicated rows.

``` r
j_capacity <- rbind(fdi_j_capacity,fdi_j_capacity[1,])
check_RD_FDI_J(j_capacity)
#> 1 record/s duplicated
#> [1] 6
```

# GFCM data format

## Task II.2 table

### Check empty fields in GFCM Task II.2 table

The function `check_EF_taskII2` checks the presence of not allowed empty
data in the given table, according to the GFCM Data Collection Reference
Framework (DCRF, V. 20.1). The function returns two lists. The first
list gives the number of NA for each reference column.

``` r
check_EF_taskII2(task_ii2, verbose=FALSE)[[1]]
#> Reference_Year            CPC            GSA        Segment        Species 
#>              0              0              0              0              0 
#>        Landing          Catch 
#>              0              0
```

The second list returns the index of each NA in the reference column.

``` r
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

Function `check_presence_taskII2` allows to verify the completeness of
the GSA/Fleet segments in Task II.2 table, as reported in the
combination_taskII2 table. The output is a list of missing combinations
GSA/Fleet segment per year.

``` r
check_presence_taskII2(task_ii2,combination_taskII2,MS="ITA",GSA="18")
#> No reference values for the following years: 2017.
```

### Check duplicated records in GFCM Task II.2 table

The function `check_RD_taskII2` checks the presence of duplicated
records. In particular, it checks whether the combination of the first 5
columns generates duplicate records. The function returns the indices of
the duplicated rows, checking the unique combinations of the first 5
columns of the Task II.2 table.

``` r
ii2 <- rbind(task_ii2,task_ii2[1,])
check_RD_taskII2(ii2)
#> 1 record/s duplicated
#> [1] 6
```

## Task III table

### Check empty fields in GFCM Task III table

The function `check_EF_taskIII` checks the presence of not allowed empty
data in the given table, according to the GFCM Data Collection Reference
Framework (DCRF, V. 20.1). The function returns two lists. The first
list gives the number of NA for each reference column.

``` r
check_EF_taskIII(task_iii,verbose=FALSE)[[1]]
#> Reference_Year            CPC            GSA        Segment          Group 
#>              0              0              0              0              0 
#>           Date         Source   NumberCaught 
#>              0              0              0
```

The second list returns the index of each NA in the reference column.

``` r
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

The function `check_RD_taskIII` checks the presence of duplicated
records. In particular, it checks whether the combination of the first
10 columns generates duplicate records. The function returns the indices
of the duplicated rows, checking the unique combinations of the first 10
columns of the Task Task III table.

``` r
check_RD_taskIII(task_iii)
#> no duplicated lines in the data frame
#> integer(0)
```

## Task VII.2 table

### Check empty fields in GFCM Task VII.2 table

The function `check_EF_taskVII2` checks the presence of not allowed
empty data in the given table, according to the GFCM Data Collection
Reference Framework (DCRF, V. 20.1). The function returns two lists. The
first list gives the number of NA for each reference column.

``` r
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

``` r
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

The function `check_RD_taskVII2` checks the presence of duplicated
records. In particular, it checks whether the combination of the first 9
columns generates duplicate records. The function returns the indices of
the duplicated rows, checking the unique combinations of the first 9
columns of the Task VII.2 table.

``` r
check_RD_taskVII2(task_vii2)
#> no duplicated lines in the data frame
#> integer(0)
```

### Comparison between min/max lengths observed for each species with theoretical values

The function `check_minmaxl_TaskVII.2` allows to verify the consistency
of the lengths reported in the TaskVII.2 table with the theoretical
values reported in the minmaxLtaskVII2 table. The function allows to
identify the records in which the observed lengths are greater or lower
than the expected ones.

``` r
check_minmaxl_TaskVII.2(task_vii2,minmaxLtaskVII2,MS="ITA",GSA="18")
#>   Species min_observed max_observed min_theoretical max_theoretical check_min
#> 1     BOG          8.5           18               5             100          
#>   check_max
#> 1
```

### Plot of the relationship length weight for each species

The function `check_lw_TaskVII.2` allows to check the consistency of
length-weight relationship in the GFCM Task VII.2 table by species. The
function returns a plot of the length weight relationship per species.

``` r
check_lw_TaskVII.2(task_vii2, MS = "ITA", GSA = "18", SP = "BOG")
```

![](README_files/figure-gfm/check_lw_TaskVII.2-1.png)<!-- -->

## Task VII.3.1 table

### Check empty fields in GFCM Task VII.3.1 table

The function `check_EF_TaskVII31` checks the presence of not allowed
empty data in the given table, according to the GFCM Data Collection
Reference Framework (DCRF, V. 20.1). The function returns two lists. The
first list gives the number of NA for each reference column.

``` r
check_EF_TaskVII31(task_vii31, verbose=FALSE)[[1]]
#> Reference_Year            CPC            GSA        Species            Sex 
#>              0              0              0              0              0 
#>            L50 
#>              0
```

The second list returns the index of each NA in the reference column.

``` r
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

The function `check_minmaxl50_TaskVII.3.1` allows to verify the
consistency of L50 reported in the TaskVII.3.1 table with the
theoretical values reported in the minmaxLtaskVII31 table. The function
allows to identify the records in which the observed L50 are greater or
lower than the expected ones. The function returns a table with the
comparison between min/max L50 observed for each species and sex with
theoretical values. The field check_max of the returned data frame will
contain “Warning” in case of L50 outliers.

``` r
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

The function `check_RD_taskVII31` checks the presence of duplicated
records. In particular, it checks whether the combination of the first 5
columns generates duplicate records. The function returns the indices of
the duplicated rows, checking the unique combinations of the first 5
columns of the Task VII.3.1 table.

``` r
check_RD_taskVII31(task_vii31)
#> no duplicated lines in the data frame
#> integer(0)
```

## Task VII.3.2 table

### Check empty fields in GFCM Task VII.3.2 table

The function `check_EF_TaskVII31` checks the presence of not allowed
empty data in the given table, according to the GFCM Data Collection
Reference Framework (DCRF, V. 20.1). The function returns two lists. The
first list gives the number of NA for each reference column.

``` r
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

``` r
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

The function `check_RD_TaskVII32` checks the presence of duplicated
records. In particular, it checks whether the combination of the first
10 columns generates duplicate records. The function returns the indices
of the duplicated rows, checking the unique combinations of the first 10
columns of the Task VII.3.2 table.

``` r
check_RD_TaskVII32(task_vii32)
#> no duplicated lines in the data frame
#> integer(0)
```

### Check mismatching species/Catfau and Sex per maturity stages for Task VII.3.2 table

The function `check_species_catfau_TaskVII.3.2` allows to check the
correct codification of faunistic category according to species and sex
in Task VII.3.2 table. Two vectors are returned by the function. The
first provides the list of mismatching combination of species/faunistic
categories.

``` r
check_species_catfau_TaskVII.3.2(task_vii32,catfau_check,sex_mat, MS="ITA",GSA="18")[[1]]
#> character(0)
```

The second vector provides the list of mismatching combination of
sex/maturity stages.

``` r
check_species_catfau_TaskVII.3.2(task_vii32,catfau_check,sex_mat, MS="ITA",GSA="18")[[2]]
#> character(0)
```

### Plot of the maturity stages per length for each sex and species

Function `check_lmat_TaskVII.3.2` plots the lengths at maturity stages
by species and sex to easily identify outliers. The function return a
plot of the maturity stages per length and sex per species.

``` r
check_lmat_TaskVII.3.2(task_vii32)
```

![](README_files/figure-gfm/check_lmat_TaskVII.3.2-1.png)<!-- -->
