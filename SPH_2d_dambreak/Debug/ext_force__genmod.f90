        !COMPILER-GENERATED INTERFACE MODULE: Fri Nov 05 10:12:27 2021
        MODULE EXT_FORCE__genmod
          INTERFACE 
            SUBROUTINE EXT_FORCE(NTOTAL,MASS,X,NIAC,PAIR_I,PAIR_J,ITYPE,&
     &HSML,DVXDT)
              INTEGER(KIND=4) :: NTOTAL
              REAL(KIND=8) :: MASS(100000)
              REAL(KIND=8) :: X(3,100000)
              INTEGER(KIND=4) :: NIAC
              INTEGER(KIND=4) :: PAIR_I(10000000)
              INTEGER(KIND=4) :: PAIR_J(10000000)
              INTEGER(KIND=4) :: ITYPE(100000)
              REAL(KIND=8) :: HSML(100000)
              REAL(KIND=8) :: DVXDT(3,100000)
            END SUBROUTINE EXT_FORCE
          END INTERFACE 
        END MODULE EXT_FORCE__genmod
