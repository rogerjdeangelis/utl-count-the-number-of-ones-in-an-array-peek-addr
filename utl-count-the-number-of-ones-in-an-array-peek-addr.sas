Count the number of ones in an array peek addr    

See insights by Mark and Paul on end of this message                                          
                                                                                              
Paul Dorfman                                                                                  
sashole@bellsouth.net                                                                         
                                                                                              
Mark Keintz                                                                                   
mkeintz@wharton.upenn.edu   
                                                                                                                     
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


*____                ___     __  __            _                                              
|  _ \ __ _ _   _   ( _ )   |  \/  | __ _ _ __| | __                                          
| |_) / _` | | | |  / _ \/\ | |\/| |/ _` | '__| |/ /                                          
|  __/ (_| | |_| | | (_>  < | |  | | (_| | |  |   <                                           
|_|   \__,_|\__,_|  \___/\/ |_|  |_|\__,_|_|  |_|\_\                                          
                                                                                              
;                                                                                             
                                                                                              
                                                                                              
See insights by Mark and Paul on end of this message                                          
                                                                                              
Paul Dorfman                                                                                  
sashole@bellsouth.net                                                                         
                                                                                              
Mark Keintz                                                                                   
mkeintz@wharton.upenn.edu                                                                     
                                                                                              
                                                                                              
If PEEKCLONG response is assigned to a variable with a previously undefined length,           
the variable gets sized as $200 by default. In this case, PUT with the long enough $w.        
would be needed to avoid chopping the extracted value off if the second argument of           
PEEKCLONG were longer than 200. Since in this situation we only have 40, it's of no concern.  
                                                                                              
Furthermore, in our present situation, PEEKCLONG is nested within COUNT. Due to               
the nesting, COUNT works with the entire PEEKCLONG buffer, whose length is set                
to the value of its second argument (all the way to 32767, if need be). Thus,                 
your variation doing away with PUT will work even if the second argument                      
were longer than 200, let alone 40.                                                           
                                                                                              
                                                                                              

                                                                                                                     
                                                                                                                     
