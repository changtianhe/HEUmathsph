        !COMPILER-GENERATED INTERFACE MODULE: Wed Nov 03 21:40:38 2021
        MODULE ART_VISC__genmod
          INTERFACE 
            SUBROUTINE ART_VISC(NTOTAL,HSML,MASS,X,VX,NIAC,RHO,C,PAIR_I,&
     &PAIR_J,W,DWDX,DVXDT,DEDT)
              INTEGER(KIND=4) :: NTOTAL
              REAL(KIND=8) :: HSML(100000)
              REAL(KIND=8) :: MASS(100000)
              REAL(KIND=8) :: X(3,100000)
              REAL(KIND=8) :: VX(3,100000)
              INTEGER(KIND=4) :: NIAC
              REAL(KIND=8) :: RHO(100000)
              REAL(KIND=8) :: C(100000)
              INTEGER(KIND=4) :: PAIR_I(10000000)
              INTEGER(KIND=4) :: PAIR_J(10000000)
              REAL(KIND=8) :: W(10000000)
              REAL(KIND=8) :: DWDX(3,10000000)
              REAL(KIND=8) :: DVXDT(3,100000)
              REAL(KIND=8) :: DEDT(100000)
            END SUBROUTINE ART_VISC
          END INTERFACE 
        END MODULE ART_VISC__genmod
