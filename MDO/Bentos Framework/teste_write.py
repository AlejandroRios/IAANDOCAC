import numpy as np

FCONT = 2
T8 = 2.0
nvisc = 8.0
CL = 2.0

# Stations for viscous calculation
nvisc_i=4
nvisc_e=5
stavi=0.13353192688137014
stabreak=4.491998219055747/14.491998219055747
zvisc_internal=np.linspace(stavi,stabreak,nvisc_i)
zvisc_external=np.linspace(stabreak+0.1,1.,nvisc_e)
zvisc=[zvisc_internal, zvisc_external]

zvisc = np.concatenate([zvisc_internal,zvisc_external])
nvisc=nvisc_i+nvisc_e

fid = open('fpwb_run_file',"w")




fid.write('          AVAER FULL POTENTIAL ANALYSIS                                           \n')
fid.write('    NX   ><   NY   ><   NZ   ><   NT   ><  FCONT >                                \n')
fid.write('    48.        12.        10.     5.       %2.0f                                 \n' % FCONT)
fid.write('  FPICT1 >< FPICT2 >< FPICT3 >< FPICT4 >< FPICT5 ><        ><        >< tecplot>  \n')
fid.write('    0.         0.        0.        0.       0.0                           0.      \n')
fid.write('   XMIN  ><  XMAX  ><  YMIN  ><  YMAX  ><  ZMIN  ><  ZMAX  >                      \n')
fid.write('    -.1       1.7      -.9        .9       .0        2.7                          \n')
fid.write('    EX   ><   EY   ><   EZ   >                                                    \n')
fid.write('   -5.        5.        10.                                                       \n')
fid.write('    NP   ><  ETAE  ><   T8   ><   PR   ><   PRT  ><   RRR  ><   VGL  ><   VGT  >  \n')
fid.write('    21.       4.      %4.0f      .753       .90        1.      1.26      1.26     \n' % T8)
fid.write('    NTR  ><  AL_CL ><   CL   >< DCL/DA >                                          \n')
for jvisc in range(nvisc):
    fid.write(' %9.4f      0.05      0.05    \n' % zvisc[jvisc])                                     
fid.close()