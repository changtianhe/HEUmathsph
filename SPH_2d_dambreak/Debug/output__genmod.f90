        !COMPILER-GENERATED INTERFACE MODULE: Fri Nov 05 10:12:24 2021
        MODULE OUTPUT__genmod
          INTERFACE 
            SUBROUTINE OUTPUT(X,VX,MASS,RHO,P,U,C,ITYPE,HSML,NTOTAL,    &
     &NVIRT,ITIMESTEP)
              REAL(KIND=8) :: X(3,100000)
              REAL(KIND=8) :: VX(3,100000)
              REAL(KIND=8) :: MASS(100000)
              REAL(KIND=8) :: RHO(100000)
              REAL(KIND=8) :: P(100000)
              REAL(KIND=8) :: U(100000)
              REAL(KIND=8) :: C(100000)
              INTEGER(KIND=4) :: ITYPE(100000)
              REAL(KIND=8) :: HSML(100000)
              INTEGER(KIND=4) :: NTOTAL
              INTEGER(KIND=4) :: NVIRT
              INTEGER(KIND=4) :: ITIMESTEP
            END SUBROUTINE OUTPUT
          END INTERFACE 
        END MODULE OUTPUT__genmod
