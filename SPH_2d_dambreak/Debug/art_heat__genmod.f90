        !COMPILER-GENERATED INTERFACE MODULE: Thu Oct 21 16:19:35 2021
        MODULE ART_HEAT__genmod
          INTERFACE 
            SUBROUTINE ART_HEAT(NTOTAL,HSML,MASS,X,VX,NIAC,RHO,U,C,     &
     &PAIR_I,PAIR_J,W,DWDX,DEDT)
              INTEGER(KIND=4) :: NTOTAL
              REAL(KIND=8) :: HSML(100000)
              REAL(KIND=8) :: MASS(100000)
              REAL(KIND=8) :: X(3,100000)
              REAL(KIND=8) :: VX(3,100000)
              INTEGER(KIND=4) :: NIAC
              REAL(KIND=8) :: RHO(100000)
              REAL(KIND=8) :: U(100000)
              REAL(KIND=8) :: C(100000)
              INTEGER(KIND=4) :: PAIR_I(20000000)
              INTEGER(KIND=4) :: PAIR_J(20000000)
              REAL(KIND=8) :: W(20000000)
              REAL(KIND=8) :: DWDX(3,20000000)
              REAL(KIND=8) :: DEDT(100000)
            END SUBROUTINE ART_HEAT
          END INTERFACE 
        END MODULE ART_HEAT__genmod
