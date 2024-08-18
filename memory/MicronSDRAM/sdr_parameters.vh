
//*************************************************************************************
// W9825G6DH, speed grade -6 (-6/-6C/-6I/-75/75I)
// 166MHz/CL3 or 133MHz/CL2
// 4M words × 4 banks × 16 bits
// Row Address:    A0-A12 --> 2^13 = 8192
// Column Address: A0-A8  --> 2^9  = 512
`ifdef W9825G6DH_6
    ////////////////////////////////////////////////////////////////////////////
    parameter tCK   =   6.0; //  ns    CLK Cycle Time (CL = 3 -> 6ns) (CL = 2 -> 7.5ns)
    parameter tAC3  =   5.0; //  ns    Access time from CLK (posedge) (CL = 3)
    parameter tAC2  =   6.0; //  ns    Access time from CLK (posedge) (CL = 2)
    parameter tAC1  =   0.0; //! ns    Access time from CLK (posedge) (CL = 1) (not supported)
    parameter tHZ3  =   5.4; //  ns    Data Out High Z time (CL = 3)
    parameter tHZ2  =   5.4; //  ns    Data Out High Z time (CL = 2)
    parameter tHZ1  =   0.0; //! ns    Data Out High Z time (CL = 1) (not supported)
    parameter tOH   =   3.0; //  ns    Data Out Hold time
    parameter tMRD  =   2  ; //  tCK   Load Mode Register command cycle time (tRSC - Register Set Cycle Time)
    parameter tRAS  =  42.0; //  ns    Active to Precharge command time
    parameter tRC   =  60.0; //  ns    Active to Active/Auto Refresh command time
    parameter tRFC  =  64.0; //? ns    Refresh to Refresh Command interval time
    parameter tRCD  =  15.0; //  ns    Active to Read/Write command time
    parameter tRP   =  15.0; //  ns    Precharge command period
    parameter tRRD  =   2  ; //  tCK   Active bank a to Active bank b command time
    parameter tWRa  =   7.0; //? ns    Write recovery time (auto-precharge mode - must add 1 CLK)
    parameter tWRm  =  12.0; //  ns    Write recovery time (2 * tCK)

    ////////////////////////////////////////////////////////////////////////////
    parameter tCCD  =   6.0; //  ns    Read/Write(a) to Read/Write(b) Command Period (1 * tCK)
    parameter tLZ   =   0.0; //  ns    Output Data Low Impedance Time
    parameter tSB   =   7.0; //  ns    Power Down Mode Entry Time
    parameter tT    =   1.0; //  ns    Transition Time of CLK (Rise and Fall)
    parameter tREF  =  64.0; //  ms    Refresh cycle time
    parameter tXSR  =  72.0; //  ns    Exit self refresh to ACTIVE command

    ////////////////////////////////////////////////////////////////////////////
    parameter ADDR_BITS        =      13; // Set this parameter to control how many Address bits are used
    parameter ROW_BITS         =      13; // Set this parameter to control how many Row bits are used
    parameter COL_BITS         =       9; // Set this parameter to control how many Column bits are used
    parameter DQ_BITS          =      16; // Set this parameter to control how many Data bits are used
    parameter DM_BITS          =       2; // Set this parameter to control how many DM bits are used
    parameter BA_BITS          =       2; // Bank bits

`elsif Micron_SG6A_256Mb_x16
    parameter tCK              =   6.0; // tCK    ns    Nominal Clock Cycle Time
    parameter tAC3             =   5.4; // tAC3   ns    Access time from CLK (pos edge) CL = 3
    parameter tAC2             =   7.5; // tAC2   ns    Access time from CLK (pos edge) CL = 2
    parameter tAC1             =  17.0; // tAC1   ns    Parameter definition for compilation - CL = 1 illegal for sg75
    parameter tHZ3             =   5.4; // tHZ3   ns    Data Out High Z time - CL = 3
    parameter tHZ2             =   7.5; // tHZ2   ns    Data Out High Z time - CL = 2
    parameter tHZ1             =  17.0; // tHZ1   ns    Parameter definition for compilation - CL = 1 illegal for sg75
    parameter tOH              =   3.0; // tOH    ns    Data Out Hold time
    parameter tMRD             =   2.0; // tMRD   tCK   Load Mode Register command cycle time (2 * tCK)
    parameter tRAS             =  42.0; // tRAS   ns    Active to Precharge command time
    parameter tRC              =  60.0; // tRC    ns    Active to Active/Auto Refresh command time
    parameter tRFC             =  60.0; // tRFC   ns    Refresh to Refresh Command interval time
    parameter tRCD             =  18.0; // tRCD   ns    Active to Read/Write command time
    parameter tRP              =  18.0; // tRP    ns    Precharge command period
    parameter tRRD             =   2.0; // tRRD   tCK   Active bank a to Active bank b command time (2 * tCK)
    parameter tWRa             =   6.0; // tWR    ns    Write recovery time (auto-precharge mode - must add 1 CLK)
    parameter tWRm             =  12.0; // tWR    ns    Write recovery time

    parameter ADDR_BITS        =      13; // Set this parameter to control how many Address bits are used
    parameter ROW_BITS         =      13; // Set this parameter to control how many Row bits are used
    parameter COL_BITS         =       9; // Set this parameter to control how many Column bits are used
    parameter DQ_BITS          =      16; // Set this parameter to control how many Data bits are used
    parameter DM_BITS          =       2; // Set this parameter to control how many DM bits are used
    parameter BA_BITS          =       2; // Bank bits
`elsif Micron_SG75_256Mb_x16
    parameter tCK              =     7.5; // tCK    ns    Nominal Clock Cycle Time
    parameter tAC3             =     5.4; // tAC3   ns    Access time from CLK (pos edge) CL = 3
    parameter tAC2             =     6.0; // tAC2   ns    Access time from CLK (pos edge) CL = 2
    parameter tAC1             =     0.0; // tAC1   ns    Parameter definition for compilation - CL = 1 illegal for sg75
    parameter tHZ3             =     5.4; // tHZ3   ns    Data Out High Z time - CL = 3
    parameter tHZ2             =     6.0; // tHZ2   ns    Data Out High Z time - CL = 2
    parameter tHZ1             =     0.0; // tHZ1   ns    Parameter definition for compilation - CL = 1 illegal for sg75
    parameter tOH              =     2.7; // tOH    ns    Data Out Hold time
    parameter tMRD             =     2.0; // tMRD   tCK   Load Mode Register command cycle time (2 * tCK)
    parameter tRAS             =    44.0; // tRAS   ns    Active to Precharge command time
    parameter tRC              =    66.0; // tRC    ns    Active to Active/Auto Refresh command time
    parameter tRFC             =    66.0; // tRFC   ns    Refresh to Refresh Command interval time
    parameter tRCD             =    20.0; // tRCD   ns    Active to Read/Write command time
    parameter tRP              =    20.0; // tRP    ns    Precharge command period
    parameter tRRD             =     2.0; // tRRD   tCK   Active bank a to Active bank b command time (2 * tCK)
    parameter tWRa             =     7.5; // tWR    ns    Write recovery time (auto-precharge mode - must add 1 CLK)
    parameter tWRm             =    15.0; // tWR    ns    Write recovery time

    parameter ADDR_BITS        =      13; // Set this parameter to control how many Address bits are used
    parameter ROW_BITS         =      13; // Set this parameter to control how many Row bits are used
    parameter COL_BITS         =       9; // Set this parameter to control how many Column bits are used
    parameter DQ_BITS          =      16; // Set this parameter to control how many Data bits are used
    parameter DM_BITS          =       2; // Set this parameter to control how many DM bits are used
    parameter BA_BITS          =       2; // Bank bits

`elsif W9825G6DH_6l
    //! Code someday
`elsif W9825G6DH_7
    //! Code someday
`endif

parameter mem_sizes = 2**(ROW_BITS+COL_BITS) - 1;
