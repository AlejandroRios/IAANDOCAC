"""" 
Title     : Input fpwb 
Written by: Alejandro Rios
Date      : 18/11/19
Language  : Python
Aeronautical Institute of Technology


Inputs:
MTOW

Outputs:
Cap_Sal
FO_Sal
"""

########################################################################################
"""Importing Modules"""
########################################################################################
import numpy as np
import os
import subprocess
########################################################################################


def read_fpwb_output(ybreaksta,diamfus,meia_env,clmax_airfoil):
    #   Leitura do CD, Momento Fletor e Calculo do CLMAX
    #clc
    CLMAX      = 0
    CLALFA_rad = 0
    nstat      = 21
    K_IND      = 1000
    CD0        = 1E06
    estaestol = 1 # estacao da envergadura onde ocorre o inicio do estol (fracao da enverghadura)
    #
    #ybreaksta = dist_quebra/(meia_env)
    # estacao da ponta
    #yetaponta=(env/2)/(env/2+envergadurarake) # with raked wingtip
    yetaponta=1 # with no raked wingtip
    #
    #  calcula clmax da asa-fuselagem
    # Inicialmente faz leitura da saida do BLWF para a primeira condicao
    #
    error1 = 1
    error2 = 1
    #
    arq_output = 'fpwbclm1.out'
    with open(arq_output) as fp:

        while True:
            linha = fgetl(fid)
            search = findstr('The end',linha)
            if(~(isempty(search)))
                error1 = 0

        fclose(fid)

        if (error1 == 1)
        return
        else
            
            fid = fopen(arq_output)

            while (isempty(findstr('MACH',linha)))
                    linha = fgetl(fid)
            end
        linhamach = fgetl(fid)
        READ = strread(linhamach)
        ALFA1=READ(2)
            while (isempty(findstr('CHORD',linha)))
                    linha = fgetl(fid)
            end

            for k=1:nstat
                linha = fgetl(fid)
                READ = strread(linha)
                Zestacao1(k) = READ(2)
                CLestacao1(k) = READ(3)
                Chordestacao1(k) =READ(12)
            end
        #
            while (isempty(findstr('CDIND',linha)))
                    linha = fgetl(fid)
            end
        #
            linha = fgetl(fid)
            READ = strread(linha)
            CL1  = READ(1)
            CD1 = READ(2) + READ(3) + READ(6)
        end
        fclose(fid)
        clear fid
    #=================================================================
    # Leitura da distribuicao de cl para alpha2
    if error1 == 0
    #
    arq_output = ['fpwbclm2.out']
    fid = fopen(arq_output)
    #
    while (~feof(fid))
        linha = fgetl(fid)
        search = findstr('The end',linha)
        if(~(isempty(search)))
            error2 = 0
        end
    end

    fclose(fid)
    clear fid
    #
    if (error2 == 1)
    return
    else
        fid = fopen(arq_output)

        while (isempty(findstr('MACH',linha)))
                linha = fgetl(fid)
        end
    linhamach = fgetl(fid)
    READ = strread(linhamach)
    ALFA2=READ(2)
        while (isempty(findstr('CHORD',linha)))
                linha = fgetl(fid)
        end
    #
        for k=1:nstat
            linha = fgetl(fid)
            READ             = strread(linha)
            Zestacao2(k)     = READ(2)
            CLestacao2(k)    = READ(3)
            Chordestacao2(k) = READ(12)
        end

        while (isempty(findstr('CDIND',linha)))
                linha = fgetl(fid)
        end

        linha = fgetl(fid)
        READ = strread(linha)
        CL2 = READ(1)
        CD2 = READ(2) + READ(3) + READ(6)
        CLALFA_rad = ((CL2-CL1)/(ALFA2-ALFA1))*180/pi
        for k=1:nstat
            Clalfa(k)=(CLestacao2(k)-CLestacao1(k))/(ALFA2-ALFA1)
            Clzero(k)=CLestacao2(k)-Clalfa(k)*ALFA2
        end
    fclose(fid)
    clear fid
    # Arrassto CD0 e fator k dor arrasto induzido CD=CD0 + k*CL^2
        K_IND = (CD1-CD2)/(CL1^2-CL2^2)
        CD0   = CD1-K_IND*(CL1^2)
        # descobre o menor alfa no qual uma estacao atinge o cl maximo 2D
        alfamin=10000
        clr=clmax_airfoil(1)
        clq=clmax_airfoil(2)
        clp=clmax_airfoil(3)
        #alfacomp=zeros(1,nstat)
        for k=1:nstat
        if Zestacao2(k) > yetaponta
        alfa=10000
        else
            if Zestacao2(k) <= ybreaksta
                gradcl        = (clr-clq)/(0-ybreaksta)
                Clcomp        = clr+gradcl*(Zestacao2(k)-0)
                #gradalfa_airf =(inc_root-inc_kink)/(0-ybreaksta)
                #alfa0         = inc_root
                #alfacomp(k)   = alfa0 + gradalfa_airf*(Zestacao2(k)-0)
            else
                gradcl        = (clq-clp)/(ybreaksta-yetaponta)
                Clcomp        = clq+gradcl*(Zestacao2(k)-ybreaksta)
                #gradalfa_airf = (inc_kink-inc_tip)/(ybreaksta-1)
                #alfa0         = inc_kink
                #alfacomp(k)   = alfa0 + gradalfa_airf*(Zestacao2(k)-ybreaksta)
            end
    #
        alfa=(Clcomp-Clzero(k))/Clalfa(k)
        end  
        if alfa < alfamin
        alfamin = alfa
        estaestol = Zestacao2(k)
        end
        end
    #    Extrapolacao do cl na linha de centro
        cl1 = Clzero(1)   + Clalfa(1)*alfamin
        cl2 = Clzero(2)   + Clalfa(2)*alfamin
        inclina = (cl2-cl1)/(Zestacao2(2)-Zestacao2(1))
        clcentro=cl1 + inclina*(0-Zestacao2(1))
        CLMAX=0.50*(clcentro + Clzero(1) + Clalfa(1)*alfamin)*Zestacao2(1)
        # Calculo do Cl no restante da asa
        for k=1:(nstat-1)
            cl1=Clzero(k)   + Clalfa(k)*alfamin
            cl2=Clzero(k+1) + Clalfa(k+1)*alfamin
            CLMAX=CLMAX     + 0.50*(cl1+cl2)*(Zestacao2(k+1)-Zestacao2(k))
        end
    #
    end
    end

    #
    figure(13)
    hold on
    xclmax(1)=0
    xclmax(2)=(diamfus/2)/(meia_env)
    xclmax(3)=ybreaksta
    xclmax(4)=1
    yclmax(1)=clr
    yclmax(2)=clr
    yclmax(3)=clq
    yclmax(4)=clp
    #
    xistosclmaxairfoil=clmax_airfoil
    xistosxclmax=xclmax
    xistosyclmax=yclmax
    #
    plot(xclmax,yclmax,'-gs')
    # hold on
    xclmax=[0 Zestacao1]
    yclmax=[clcentro (Clzero(1:21)+Clalfa(1:21)*alfamin)]
    plot(xclmax,yclmax,'--rs')
    title('Wing-body CLmax Calculation with FPWB')
    xlabel('eta')
    ylabel('Cl')
    clmaxstr1=num2str(CLMAX,'#4.2f')
    clmaxstr2='CLMAX = '
    clmaxstr=[clmaxstr2 clmaxstr1]
    text(0.50,1.4,clmaxstr)
    #
    if exist('cldistribution.jpg') > 0 ##ok<EXIST>
    delete ('cldistribution.jpg')
    end
    #
    nomeclmax='cldistspan.jpg'
    #print(hfig13,nomeclmax,'-djpeg','-r300')
    print -djpeg -f13 -r300 '../Figures/cldistribution.jpg'
    close(figure(13))
    clear xclmax yclmax Clzero Clalfa Zestacao2
    clear clmaxstr1 clmaxstr2 clmaxstr CD1 CD2
    end # function

    return(CD0_Wing, K_IND, CLALFA_rad, CLMAX, estaestol,error1,error2)