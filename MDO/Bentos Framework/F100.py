import numpy as np 
import matplotlib as plt
# Constants and conversion factors
nm2km   = 1.852 # Fator de conversao de milha nautica para km
ft2m    = 0.3048
m2ft    = 1./ft2m
kts2ms  = 0.514444
rad     = np.pi/180
kg2lb   = 2.2046
lb2kg   = 1./kg2lb
g       = 9.8065

# ***********************  Airplane VARIABLES *****************************
# Fuselage 
widthreiratio       = 1.0 # Fuselage height-to-width ratio
NPax                = 100 # single class
NAisle              = 1   
NSeat               = 5   # Seating abreast
SeatPitch           = 0.8128 # Distance between seats [m]
# Wing --------------------------------------------------------------------
wS                  = 93.5  # Wing reference area [m2]
wAR                 = 8.43  # Wing aspect ratio
wTR                 = 0.235 # Wing taper ratio
wSweep14            = 17.45 # Quarter-chord wing sweepback angle
wTwist              = -3.5
Kink_semispan       = 0.32
longtras            = 0.75 # Fraction of chord where the rear spar is located
# Engine data  ------------------------------------------------------------
PEng                = 2 # Engine location (=1 underwing ~=1 rear fuselage)
ne                  = 2 # Number of engines
Engine_choice       = 1
if Engine_choice == 1:
    ne                  = 2 # Number of engines
    ebypass             = 3.04  # Engine by-pass ratio 
    ediam               = 1.14  # Engine diameter [m]
    T0                  = 13850 # Static single engine thrust at sea level [lb]
    ctref               = 0.69 # consumo especifico do motor em cruzeiro na altitude
    H_engref            = 31000 # Altitude for which TSFC is referenced [ft]
    Mach_engref         = 0.73 # Mach number for which TSFC is referenced
    Engine_Weight       = 1445 # [kg]
elif Engine_choice == 2:
    ebypass             = 5.10  # Engine by-pass ratio 
    ediam               = 1.42  # Engine diameter [m]
    T0                  = 17640 # Static single engine thrust at sea level [lb]
    ctref               = 0.65 # consumo especifico do motor em cruzeiro na altitude
    H_engref            = 35000 # Altitude for which TSFC is referenced [ft]
    Mach_engref         = 0.75 # Mach number for which TSFC is referenced
    Engine_Weight       = 1678 # [kg]

# HT and VT ---------------------------------------------------------------
VTAR                = 0.89 # Vertical tail aspect ratio
VTTR                = 0.74 # Vertical tail taper ratio
VTArea              = 12.3
VTSweep             = 41.0 # Quarter-chord sweepback angle of VT
HTAR                = 4.64
HTTR                = 0.39
HTarea              = 21.72
# Airfoils ----------------------------------------------------------------
PROOT               = 'PR1.dat'
PKINK               = 'PQ1.dat'
PTIP                = 'PT4.dat'
# Performance and operation -----------------------------------------------
AirportElevation    = 0# [m]
VRVS                = 1.10 # Stall margin to VR (Takeoff)
V2VS                = 1.20 # Stall margin to V2 (Takeoff)
Takeofffl           = 1900 # [m]
Landfl              = 1500 
MMO                 = 0.77
CruiseMach          = MMO - 0.02
Ceiling_ft          = 35000
HCruzi              = 35000
Machesp             = 0.55 # Numero de Mach na espera
altEsp              = 1500 # ALtitude da espera (Loiter) em pes
wfuelmanobra        = 500 # Additional fuel for manouvering [kg]
rangealt            = 200 # Distance to alternate airport [nm]
altAlt              = 25000 # Altitude to fly to altenate destination [ft]
tempespera          = 45 # Tempo espera [min]
cruiseprof          = 1 # Cruise profile (1= long-range cruise  ~= 1 Fixed Mach)
# AERODYNAMICS ------------------------------------------------------------
dflecflaptakeoff    = 32 
dflecflapland       = 45  
bflap               = 0.58
posaileron          = bflap + 0.02
inc_root            = 2
inc_kink            = 0
inc_tip             = inc_root + wTwist
slat                = 0
# WINGLET ----------------------------------------------------------------- 
wlet_present        = 0 # = 1 it is then incorporated into the configuration
wlet_sweepLE        = 35 # Leading-edge sweepback angle
wlet_AR             = 2.75 # Aspect ratio
wlet_TR             = 0.25 # Taper ratio
wlet_CantAngle      = 60 # Dihedral angle relative to horizontal plane
wlet_Twist          = -4 # Winglet twist angle
wlet_gamma          = 0 # Winglet overall incidence to freestream 
#   CONFIGURATION FLAGS ---------------------------------------------------
PWing               = 1    # Wing vertical location (1= low ~=1 high)
PHT                 = 2  # Horizontal tail location (=1 fuselage, 2= "T" tail)
# Payload range available combinations ------------------------------------
wmpayload           = 7980 # Maximum payload [kg]
rangenm             = 1766 # Maximum range with payload wmpayloadP3 [nm]
# AIRFRAME PARAMETERS -----------------------------------------------------
bW                  = np.sqrt(wAR*wS) # wingspan [m]
flap_env_m          = bW*bflap
#---------------------  Print Airplane Data -------------------------------
print(' *********************************************************** ')
print('  Candidate-airplane characteristics follow                   ')
print('                        Wing area: m2                  ',wS)
print('                Wing aspect ratio:                      ',wAR)
print('                 Wing taper ratio:                      ',wTR)
print('                       Wing twist: degree(s)          ',wTwist)
print('         Wing quarter-chord sweep: degrees           ',wSweep14 )
print('      Wing break station location: fraction of semispan ',Kink_semispan)
print('                  Engine diameter: [m]                ',ediam)
print('             Engine by-pass ratio:                      ',ebypass)
print('                       Engine Config:                   ',PEng)
print(' #i PAX single class @ #i inch pitch:                   ',NPax, round(SeatPitch*100/2.54))
print('                  Seating abreast:                      ',NSeat)
print('                  HT aspect ratio:                       ',HTAR)
print('                   HT taper ratio:                       ',HTTR)
print(' ************************************************************ ')

#-------------------- Airfoils coefficients -------------------------------
if PWing == 1:
    diedro          = 3.0
else:
    diedro          = -3.0


static_margin      = 0.15
htac_rel           = 0.25
vtac_rel           = 0.25
wingac_rel         = 0.25
# +++++  FUSELAGE PARAMETERS
# Escolha do tipo de container de acordo com o n�mero de passageiros
nt   = 3 # Number of transitions in pax number
t = np.array([[170,               # First transition point
               177]]).T           # Second transition point
classifica = 0
for i in range (1,nt):
    rastreia = NPax - t[i] 
    if rastreia < 0:
        classifica = i
    break


if classifica == 0:
    classifica = nt

if classifica == 1:
    container_type     = 'None'
elif classifica == 2:
        container_type     = 'LD3-45W'
elif classifica == 3:
        container_type     = 'LD3-45'

NCorr              = NAisle
ncrew              = 2 + 1 + round((NPax-50)/50)
SEATwid            = 0.44
AisleWidth_i       = 0.45
NSeat_i            = NSeat
CabHeightm_i       = 1.8   

fus_width = 5
fus_height = 5
FUSELAGE_Dz_floor = 3

if PWing == 2 or PEng == 2:
  PHT =2


tcroot       = 0.1
tcbreak      = 0.1
tctip        = 0.1

# *********************** WETTED AREA CALCULATION *************************
tcmed        = (0.50*(tcroot+tcbreak) + 0.50*(tcbreak+tctip))/2 # average section max. thickness of the wing
#
FusDiam      = np.sqrt(fus_width*fus_height)


Swet_tot = 1.
wingSwet = 1.
FusSwet_m2 = 1.
ESwet = 1.
lf = 1.
lco = 1.
ltail = 1.
EnginLength_m = 1.
wYMAC  = 1.
wMAC = 1.
wSweepLE = 1.
wSweepC2 = 1.
ht = 1.
vt = 1.
pylon = 1.
Ccentro = 1.
Craiz = 1.
Cquebra = 1.
Cponta = 1.
xutip = 1.
yutip = 1.
xltip = 1.
yltip = 1.
xukink = 1.
yukink = 1.
xlkink = 1.
ylkink = 1.
xuroot = 1.
yuroot = 1.
xlroot = 1.
ylroot = 1.
PHTout = 1.

clmax_airfoil = 2.
xle = 0.48*lf


CD0_Wing =  0.03
K_IND = 1.
CLALFA_rad = 5.
CLMAX = 2.
estaestol = 0.2

if PEng == 2: 
    AirplaneCLmaxClean = CLMAX # engines do not disturb wing airflow
elif PEng == 1:
    AirplaneCLmaxClean  = 0.90*CLMAX # penalization due to engines
else:
    AirplaneCLmaxClean  = 0.10 # in the event of first run does not bring anything

Oswald = 1/(wAR*np.pi*K_IND)


# ******* CLmax de decolagem
# extensao do flape interno
fe_i=Kink_semispan-((0.90*FusDiam/2)/(0.50*bW))
# extensao do flape externo
fe_e=bflap-fe_i
# tc media do flape interno
tc_i = (tcroot + tcbreak)/2
slop=(tctip-tcbreak)/(1-Kink_semispan)
tc_flap_end=tcbreak + slop*(bflap-Kink_semispan)
# tc media do flape externo
tc_e = (tcbreak + tc_flap_end)/2
# area da forma em planta coberta pelo flape
slop =(Cponta - Cquebra)/(1 - Kink_semispan)
Cflap_e    = Cquebra + slop*(bflap - Kink_semispan)
Areaflap_e = (Cflap_e + Cponta)*(1-bflap)*0.50*bW/2
fSwS   = (wS-2*Areaflap_e)/wS
DCLMAX_i= 0.5
DCLMAX_e= 0.5
#
AirplaneCLmaxTakeo  = AirplaneCLmaxClean + (DCLMAX_i*fe_i + DCLMAX_e*fe_e)/bflap
# ******* CLmax de pouso
DCLMAX_i=0.5
DCLMAX_e=0.5
AirplaneCLmaxLandi  = AirplaneCLmaxClean + (DCLMAX_i*fe_i + DCLMAX_e*fe_e)/bflap



PHT = PHTout
wingfuelcapacity_kg = 1

wcrew        = ncrew*91 # Crew mass (kg)
ctloiter     = 1 # Specific fuel comsumption at loiter
T0_tot_lb    = ne*T0 # Total takeoff thrust [lb]

RangeCruise_nm=0.975*rangenm


if PEng == 1:
    nedebasa     = ne
else:
    nedebasa = 0

# Fracoes de massa -- Standard mass fractions for some flight phases

ftakeoff   = 0.995
fclimb     = 0.980
fdesc      = 0.990
fland      = 0.998
#
mtow       = 65000 # MTOW Initial guess
deltamtow  = 1E06
rangem     = RangeCruise_nm*nm2km*1000 # (m)
rangealtm  = rangealt*nm2km*1000*0.975 # (m)
# 
print('\n ***** MTOW estimation **** \n')  
#
ncont      = 1

interplo = []
mtowplo = []
iterplo = 1
mtowplo = mtow

#**************************************************************************
# ---------------- MTOW calculation iteration procedure -------------------
#**************************************************************************

# while deltamtow > 1:

#     print(deltamtow)
#     mtowlb=mtow*kg2lb # [lb]
#     # fracao peso vazio/MTOW
#     TW=T0_tot_lb/mtowlb
#     WS=mtow/wS
#     #
#     wefrac=1
#     #
#     print('\n Iteration: #g  ==> MTOW: #4.3f kg \n',ncont, mtowlb/kg2lb)
#     #
#     masscruzi = mtow*ftakeoff*fclimb
#     mcombIniCruz=mtow-masscruzi

#     #   **** Fuel burned to perform the cruise flight phase ****
#     #    Calculo do combustivel no primeiro quarto do cruzeiro

#     BlockTime_cruise = 0

#     if cruiseprof == 1:
#         mcombc1 = 1
#         BlockTime1 = 1
#         masscruziseg14 = masscruzi - mcombc1
#         nseg=6
#         masscruz34 = masscruziseg14
#         rangemseg= (3*rangem/4)/nseg
#         BlockTime_cruise = BlockTime_cruise + BlockTime1
#         for i in range(0,nseg):
#         # Calculo do combustivel no restante do cruzeiro
#             mcombc2 = 1
#             BlockTime2 = 1
#             masscruz34=masscruz34-mcombc2
#             BlockTime_cruise = BlockTime_cruise + BlockTime2
        
#         massfinalcruz=masscruz34
#         mcombc=masscruzi-massfinalcruz
#     else:
#         mcombc1 = 2
#         masscruziseg14 = masscruzi - mcombc1
#         nseg           = 5
#         masscruz34     = masscruziseg14
#         rangemseg      = (3*rangem/4)/nseg
#         for i in range(0,nseg):
#             mcombc2=1
#             masscruz34=masscruz34-mcombc2


#         massfinalcruz=masscruz34
#         mcombc=masscruzi-massfinalcruz

#         # **** descida ****
#         massafinaldescida=massfinalcruz*fdesc
#         mcombDes=(1-fdesc)*massfinalcruz
#         # **** Fuel burn during loiter ****
#         mfuelloiter=1
#         massafinalesp = massafinaldescida-mfuelloiter

#         # Subida para destino alternativo, cruzeiro alternativo e descida ****
#         mcombSubAlt=massafinalesp - massafinalesp*fclimb
#         massInicialCruzAlt=massafinalesp*fclimb
#         #
#         mcombCruzAlt= 1 
#         massafinalCruzAlt=massInicialCruzAlt-mcombCruzAlt
#         #
#         mcombDesAlt=(1-fdesc)*massafinalCruzAlt
#         mcombAlt=mcombSubAlt+mcombCruzAlt+mcombDesAlt
#         # *** Landing ***
#         mcombLand=massafinalCruzAlt*(1-fland)
#         #massafinalpouso=massafinalCruzAlt-mcombDesAlt
#         # ------ Fracao de combustivel consumido na missao
#         mfuel =mcombIniCruz + mcombc + mcombDes + mcombAlt + mcombLand + wfuelmanobra
#         mfuel = mfuel*1.0015 # 0.2# of trapped fuel
#         wfuelfrac=mfuel/mtow 
#         # *** Recalculo do MTOW ***
#         mtownew        = (wcrew+wmpayload)/(1-(wefrac+wfuelfrac))
#         deltamtow      = abs(mtownew-mtow)
#         mtow           = 0.50*(mtow+mtownew)
#         ncont          = ncont +1
#         iterplo        = [iterplo,ncont]
#         mtowplo        = [ mtowplo,mtow]

#--------------------------------------------------------------------------
CD0=0.02
#--------------------------------------------------------------------------
# print('--------------------------------------------------------------\n')
# print('\n ----- Estimated MTOW = #6.0f kg ----- \n',mtow)
# print(' ----- Estimated fuel mass = #6.0f kg ----- \n',mfuel)
# print('                   fuel for Cruise = #6.0f kg ----- \n',mcombc)
# print('                   fuel for Loiter = #6.0f kg ----- \n',mfuelloiter)
# print('                  fuel for Descent = #6.0f kg ----- \n',mcombDes)
# print('                fuel for Alternate = #6.0f kg ----- \n',mcombAlt)
# print('                  fuel for Landing = #6.0f kg ----- \n',mcombLand)
# print('              fuel for Maneuvering = #6.0f kg ----- \n',wfuelmanobra)
# print(' ----- Estimated CD0 @ cruise = #g counts ----- \n',CD0*10000)
# print('\n Time spent for the cruise  = #5.2f h  \n',BlockTime_cruise)
# print(' -------------- Estimated OEW = #6.0f  kg ----- \n',wefrac*mtow)
# print(' -------------- Payload       = #6.0f  kg ----- \n',wmpayload)
# print(' -------------- Crew          = #6.0f  kg ----- \n',wcrew)
# print('--------------------------------------------------------------\n')
# print('Wing fuel capacity = #6.0f kg   \n',wingfuelcapacity_kg)

# plt.plot(interplo,mtowplo/1000)
mfuel = 10
masscruziseg14 = 10
mcombAlt = 1
BlockTime_cruise = 1
# ******************* Check requirements **********************************
# Second segment climb ----------------------------------------------------
T0_2seg_lb  = T0 # [lb]
ToW_2seg    =  (ne*T0_2seg_lb)/(mtow*kg2lb)
#
tcmed = (0.50*(tcroot+tcbreak) + 0.50*(tcbreak+tctip))/2 # average section max. thickness of the wing
#einc  = oswaldf(0.2,wAR,wSweep14,wTR,tcmed,nedebasa)
eincf = Oswald*0.925 # deflected flap degration on Oswald's factor
k_ind_inc = 1/(np.pi*wAR*eincf)
#
TW_2seg_req = 1
#
flag2seg = 0
if TW_2seg_req > ToW_2seg:
    flag2seg = 1 # if TW_2seg
#------------------ End 2nd segment climb ---------------------------------
#------------------ Fuel storage check ------------------------------------
flagfuel = 0

if mfuel > wingfuelcapacity_kg:
    flagfuel = 1  # if TW_2seg
#------------------ End fuel storage check --------------------------------
#----------------- Balanced field length ----------------------------------
atm              = 1
rho              = 1 # densidade [kg/m�]
sigma            = rho/1.225
CL2              = AirplaneCLmaxTakeo/1.44
V2               = np.sqrt((mtow*ftakeoff*g)/(0.50*rho*wS))
q                = (1/2)*rho*V2*V2    # Dynamic pressure
CDi              = k_ind_inc*(CL2**2)
CD0              = 0.01
dcdflapetakeoff  = 0.01
dcdrudder        = 0.0020*np.cos(rad*VTSweep)*(VTArea/wS) 
dcdwindmilli     = 0.01
#dcdLDG           = DCD_LDG(mtow,wS,dflecflaptakeoff,dflecflapland)
CD2              = CD0 + CDi + dcdflapetakeoff + dcdrudder + dcdwindmilli
hto              = 35*ft2m
DSTO             = 200
T_avg            = 0.75*T0*ne*((5+ebypass)/(4+ebypass)) # [lb]
mi_linha         = 0.01*AirplaneCLmaxTakeo + 0.02
if ne == 2:
    g2min = 0.024
elif ne == 3:
    g2min = 0.027
elif ne == 4:
    g2min = 0.030

TOEI             = T0*(ne-1)  # [lb]
D2_lb            = (CD2/CL2)*mtow*ftakeoff*kg2lb
# CORREGIRRRRR arcsin np.arcsin((TOEI-D2_lb)/(mtow*ftakeoff*kg2lb))
GAMA2            = ((TOEI-D2_lb)/(mtow*ftakeoff*kg2lb))
DGAMA2           = GAMA2 - g2min
T1               = (hto + mtow/(rho*wS*CL2))
T2               = 2.7 + 1/((T_avg/(mtow*kg2lb)) - mi_linha)
BFL              = (0.863/(1+2.3*DGAMA2))*T1*T2 + DSTO/np.sqrt(sigma)
flagtakeoff      = 0
if BFL > Takeofffl:
    flagtakeoff  = 1

#------------------ End BFL calculation -----------------------------------
#----------------- Takeoff Climb (FAR 25.121) -----------------------------
grad_req         = 0.021
gama             = np.arctan(grad_req)
CL               = 0.86*AirplaneCLmaxLandi/2.25
dcdflapeapproac  = 0.1
mlw              = 0.1
dcdLDG           = 0.1
eincfa           = Oswald*0.91
CDi              = CL**2/(np.pi*wAR*eincfa)
CD               = CD0 + CDi + dcdflapeapproac + dcdLDG + dcdwindmilli
LD               = CL/CD
TW_req           = ((ne)/(ne-1))*(1/LD + np.sin(gama))
TW_avail         = (ne*T0)/(mlw*kg2lb)
flag_121         = 0
if TW_avail < TW_req:
    flag_121 = 1

#------------------ End FAR 25.121 ----------------------------------------
#------------------ Begin Landing field length ----------------------------
kL                = 0.119
MR                = mlw/mtow
WS_land_req       = kL*sigma*AirplaneCLmaxLandi*Landfl/MR
WS_exis           = mtow/wS
flag_land         = 0
if WS_exis > WS_land_req:
    flag_land = 1

#----------------  End Landing Field Length Check  ------------------------
#------------- Begin check where stall starts on wing ---------------------
flag_stall        = 0
if estaestol > (bflap + (0.90*FusDiam/2)):
    flag_stall    = 1

#------------------- End stall check --------------------------------------
#-------------------- Begin check for cruise speed   ----------------------
massa   = masscruziseg14
atm     = 1
Veloc   = MMO*1
q       = (1/2)*1*(Veloc**2)
CL      = massa*g/(q*wS)
CD0     = 0.1
ecruise = 0.9
CDI     = CL**2/(ecruise*wAR*np.pi)
CDW     = 0.02
CD      = CD0 + CDI + CDW
Drag_N  = CD*q*wS
T_Cruz  =1000
T_Cruz  = T_Cruz*4.44822 # [N]
flag_cruz = 0
if T_Cruz < Drag_N:
    flag_cruz = 1
#--------------------- End cruise check -----------------------------------
Flags=0
Issue = 0
edges=[-1, 0.01, 1]
Status='ok'
T = 1
#**************************************************************************
#---------------------  DOC Calculation -----------------------------------
Cons_Block = mfuel - mcombAlt
BlockTime_takeoff = 5/60
# ==> Time to climb to cruise altitude
fclimb2 = 1- (1-fclimb)/2
massa   = mtow*ftakeoff*fclimb2
atm     = 1
T_climb = 2000
T_climb = T_climb*4.44822 # [N]
V_climb  = 250 # [KAS]
V_climb  = V_climb*kts2ms
q        = (1/2)*1*V_climb*V_climb
CL       = (massa*g)/(q*wS)
M_climb  = V_climb/1
CD0      = 0.01
e_climb  = 1
CDI     = CL**2/(e_climb*wAR*np.pi)
CD      = CD0 + CDI
D       = CD*q*wS
ROC     = ((T_climb-D)/(massa*g))*V_climb # [m/s]
ROC     = ROC*m2ft*60         # [ft/min]
#Rate_climb = 2000  # [ft/min]
Deltah_ft = HCruzi - AirportElevation*m2ft
BlockTime_climb   =  (Deltah_ft/ROC)/60 # [h]
# <== Climb
BlockTime_descent = 30/60
Time_Block = 60*(BlockTime_takeoff + BlockTime_climb + BlockTime_cruise + BlockTime_descent)
DOCcalc = 15
#-------------------- End DOC Calculation ---------------------------------
# tempoP=toc
# print('\n Tempo de processamento: #5.2f s \n',tempoP)
#--------------------------------------------------------------------------
#                     Desenha Vista em planta
#--------------------------------------------------------------------------

# fuselage.lco=lco
# fuselage.lcab=lf-(lco+ltail)
# fuselage.length=lf
# fuselage.df=fus_width
# wing.b=bW
# wing.c0=Ccentro
# wing.ct=Cponta
# wing.cq=Cquebra
# wing.crank=Kink_semispan
# wing.xle=lco+0.40*(lf-(lco+ltail))
# wing.sweepLE=wSweepLE
# engine.length=EnginLength_m
# engine.de=ediam
# engine.PEng=PEng
# wlet.present=wlet_present
# wlet.sweepLE=wlet_sweepLE
# wlet.dihedral=wlet_CantAngle
# wlet.TR=wlet_TR
# wlet.AR=wlet_AR

#--------------------------------------------------------------------------