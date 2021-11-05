        !COMPILER-GENERATED INTERFACE MODULE: Fri Nov 05 10:12:27 2021
        MODULE SINGLE_STEP__genmod
          INTERFACE 
            SUBROUTINE SINGLE_STEP(ITIMESTEP,DT,NTOTAL,HSML,MASS,X,VX,U,&
     &S,RHO,P,T,TDSDT,DX,DVX,DU,DS,DRHO,ITYPE,AV,NVIRT)
              INTEGER(KIND=4) :: ITIMESTEP
              REAL(KIND=8) :: DT
              INTEGER(KIND=4) :: NTOTAL
              REAL(KIND=8) :: HSML(100000)
              REAL(KIND=8) :: MASS(100000)
              REAL(KIND=8) :: X(3,100000)
              REAL(KIND=8) :: VX(3,100000)
              REAL(KIND=8) :: U(100000)
              REAL(KIND=8) :: S(100000)
              REAL(KIND=8) :: RHO(100000)
              REAL(KIND=8) :: P(100000)
              REAL(KIND=8) :: T(100000)
              REAL(KIND=8) :: TDSDT(100000)
              REAL(KIND=8) :: DX(3,100000)
              REAL(KIND=8) :: DVX(3,100000)
              REAL(KIND=8) :: DU(100000)
              REAL(KIND=8) :: DS(100000)
              REAL(KIND=8) :: DRHO(100000)
              INTEGER(KIND=4) :: ITYPE(100000)
              REAL(KIND=8) :: AV(3,100000)
              INTEGER(KIND=4) :: NVIRT
            END SUBROUTINE SINGLE_STEP
          END INTERFACE 
        END MODULE SINGLE_STEP__genmod
