# utl-count-the-number-of-ones-in-an-array-peek-addr
Count the number of ones in an array peek addr.
    Count the number of ones in an array peek addr                                                                
                                                                                                                  
    Elegant way to treat an array of numbers like a character string                                              
    and count the number of times a number > 0 appears in the array.                                              
    Looping is not required.                                                                                      
                                                                                                                  
    This has other applications.                                                                                  
                                                                                                                  
    SAS Forum                                                                                                     
    https://tinyurl.com/y9qcpmtx                                                                                  
    https://communities.sas.com/t5/SAS-Programming/Count-number-of-categories-across-multiple-columns/m-p/509879  
                                                                                                                  
    Novinosrin profile                                                                                            
    https://communities.sas.com/t5/user/viewprofilepage/user-id/138205                                            
                                                                                                                  
                                                                                                                  
                                                                                                                  
    INPUT                                                                                                         
    =====                                                                                                         
                                                                                                                  
     WORK.HAVE total obs=20                                                                                       
                                                           |  RULES                                               
                                                           |                                                      
       ZIP     NUM_PCB    NUM_P    NUM_V    NUM_B    NUM_C |  cntNonZro                                           
                                                           |                                                      
      10013       0         0        7        1        4   |      3  Non zero numbers                             
      10031       0         0        1        0        0   |      1  Non Zero                                     
      10037       0         0        1        0        1   |      2                                               
      10040       0         0        3        0        3   |      2                                               
     ....                                                                                                         
                                                                                                                  
                                                                                                                  
    EXAMPLE OUTPUT                                                                                                
    ==============                                                                                                
                                                                                                                  
     WORK.HAVE_WITHOUT_LOOP total obs=20                                                                          
                                                                                                                  
      ZIP     NUM_PCB    NUM_P    NUM_V    NUM_B    NUM_C    cntNonZro                                            
                                                                                                                  
     10013       0         0        7        1        4          3                                                
     10031       0         0        1        0        0          1                                                
     10037       0         0        1        0        1          2                                                
     10040       0         0        3        0        3          2                                                
     10301       1         1        1        0        1          4                                                
     10309       1         1        1        0        0          3                                                
                                                                                                                  
    PROCESS                                                                                                       
    =======                                                                                                       
                                                                                                                  
    data have_without_loop(drop=_t);                                                                              
        input zip num_PCB num_P num_V num_B num_C;                                                                
        _t = put (0, rb8.) ;                                                                                      
        array nums(*) num_:;                                                                                      
        cntNonZro = n(of nums(*))-count(put(peekclong (addrlong(nums[1]), 40), $40.),_t) ;                        
        cards;                                                                                                    
    10013 0 0 7 1 4                                                                                               
    10031 0 0 1 0 0                                                                                               
    10037 0 0 1 0 1                                                                                               
    10040 0 0 3 0 3                                                                                               
    10301 1 1 1 0 1                                                                                               
    10309 1 1 1 0 0                                                                                               
    10312 0 0 2 1 1                                                                                               
    10314 1 1 3 0 2                                                                                               
    10461 1 1 0 0 0                                                                                               
    10474 0 0 6 0 1                                                                                               
    10475 0 0 3 1 1                                                                                               
    10504 0 0 1 0 1                                                                                               
    10505 0 0 2 0 2                                                                                               
    10506 0 0 6 1 5                                                                                               
    10509 0 0 3 0 2                                                                                               
    10512 0 0 3 0 3                                                                                               
    10516 0 0 0 0 0                                                                                               
    10519 1 1 0 0 0                                                                                               
    10520 0 0 3 0 2                                                                                               
    10543 0 0 5 0 3                                                                                               
    ;                                                                                                             
    run;                                                                                                          
                                                                                                                  
                                                                                                                  
                                                                                                                  
