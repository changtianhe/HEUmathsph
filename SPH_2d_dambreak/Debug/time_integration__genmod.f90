        !COMPILER-GENERATED INTERFACE MODULE: Fri Nov 05 10:12:28 2021
        MODULE TIME_INTEGRATION__genmod
          INTERFACE 
            SUBROUTINE TIME_INTEGRATION(X,VX,MASS,RHO,P,U,C,S,E,ITYPE,  &
     &HSML,NTOTAL,NVIRT,MAXTIMESTEP,DT)
              REAL(KIND=8) :: X(3,100000)
              REAL(KIND=8) :: VX(3,100000)
              REAL(KIND=8) :: MASS(100000)
              REAL(KIND=8) :: RHO(100000)
              REAL(KIND=8) :: P(100000)
              REAL(KIND=8) :: U(100000)
              REAL(KIND=8) :: C(100000)
              REAL(KIND=8) :: S(100000)
              REAL(KIND=8) :: E(100000)
              INTEGER(KIND=4) :: ITYPE(100000)
              REAL(KIND=8) :: HSML(100000)
              INTEGER(KIND=4) :: NTOTAL
              INTEGER(KIND=4) :: NVIRT
              INTEGER(KIND=4) :: MAXTIMESTEP
              REAL(KIND=8) :: DT
            END SUBROUTINE TIME_INTEGRATION
          END INTERFACE 
        END MODULE TIME_INTEGRATION__genmod
