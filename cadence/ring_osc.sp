* SPICE NETLIST
***************************************

.SUBCKT INVD1 vi vss! vdd! vo
** N=4 EP=4 IP=0 FDC=2
M0 vo vi vss! vss! NMOS_VTL L=5e-08 W=3e-07 AD=3.3e-14 AS=3.3e-14 PD=8.2e-07 PS=8.2e-07 $X=275 $Y=-400 $D=1
M1 vo vi vdd! vdd! PMOS_VTL L=5e-08 W=4e-07 AD=4.4e-14 AS=4.4e-14 PD=1.02e-06 PS=1.02e-06 $X=275 $Y=170 $D=0
.ENDS
***************************************
.SUBCKT ring_osc osc_out osc_en vss! vdd!
** N=13 EP=4 IP=32 FDC=20
M0 13 osc_en vss! vss! NMOS_VTL L=5e-08 W=3e-07 AD=4.35e-14 AS=3.3e-14 PD=8.9e-07 PS=8.2e-07 $X=275 $Y=300 $D=1
M1 2 osc_out 13 vss! NMOS_VTL L=5e-08 W=3e-07 AD=3.3e-14 AS=4.35e-14 PD=8.2e-07 PS=8.9e-07 $X=470 $Y=300 $D=1
M2 2 osc_en vdd! vdd! PMOS_VTL L=5e-08 W=2.5e-07 AD=3.625e-14 AS=2.75e-14 PD=7.9e-07 PS=7.2e-07 $X=275 $Y=1000 $D=0
M3 vdd! osc_out 2 vdd! PMOS_VTL L=5e-08 W=2.5e-07 AD=2.75e-14 AS=3.625e-14 PD=7.2e-07 PS=7.9e-07 $X=470 $Y=1000 $D=0
X4 2 vss! vdd! 3 INVD1 $T=575 700 0 0 $X=575 $Y=0
X5 3 vss! vdd! 4 INVD1 $T=955 700 0 0 $X=955 $Y=0
X6 4 vss! vdd! 5 INVD1 $T=1335 700 0 0 $X=1335 $Y=0
X7 5 vss! vdd! 6 INVD1 $T=1715 700 0 0 $X=1715 $Y=0
X8 6 vss! vdd! 7 INVD1 $T=2095 700 0 0 $X=2095 $Y=0
X9 7 vss! vdd! 8 INVD1 $T=2475 700 0 0 $X=2475 $Y=0
X10 8 vss! vdd! 9 INVD1 $T=2855 700 0 0 $X=2855 $Y=0
X11 9 vss! vdd! osc_out INVD1 $T=3235 700 0 0 $X=3235 $Y=0
.ENDS
***************************************
