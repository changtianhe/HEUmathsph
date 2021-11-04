        !COMPILER-GENERATED INTERFACE MODULE: Wed Nov 03 21:40:36 2021
        MODULE VIRT_PART__genmod
          INTERFACE 
            SUBROUTINE VIRT_PART(ITIMESTEP,NTOTAL,NVIRT,HSML,MASS,X,VX, &
     &RHO,U,P,ITYPE)
              INTEGER(KIND=4) :: ITIMESTEP
              INTEGER(KIND=4) :: NTOTAL
              INTEGER(KIND=4) :: NVIRT
              REAL(KIND=8) :: HSML(100000)
              REAL(KIND=8) :: MASS(100000)
              REAL(KIND=8) :: X(3,100000)
              REAL(KIND=8) :: VX(3,100000)
              REAL(KIND=8) :: RHO(100000)
              REAL(KIND=8) :: U(100000)
              REAL(KIND=8) :: P(100000)
              INTEGER(KIND=4) :: ITYPE(100000)
            END SUBROUTINE VIRT_PART
          END INTERFACE 
        END MODULE VIRT_PART__genmod
