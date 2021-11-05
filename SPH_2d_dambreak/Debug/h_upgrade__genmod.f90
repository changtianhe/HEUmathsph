        !COMPILER-GENERATED INTERFACE MODULE: Fri Nov 05 10:12:25 2021
        MODULE H_UPGRADE__genmod
          INTERFACE 
            SUBROUTINE H_UPGRADE(DT,NTOTAL,MASS,VX,RHO,NIAC,PAIR_I,     &
     &PAIR_J,DWDX,HSML)
              REAL(KIND=8) :: DT
              INTEGER(KIND=4) :: NTOTAL
              REAL(KIND=8) :: MASS(100000)
              REAL(KIND=8) :: VX(3,100000)
              REAL(KIND=8) :: RHO(100000)
              INTEGER(KIND=4) :: NIAC
              INTEGER(KIND=4) :: PAIR_I(10000000)
              INTEGER(KIND=4) :: PAIR_J(10000000)
              REAL(KIND=8) :: DWDX(3,10000000)
              REAL(KIND=8) :: HSML(100000)
            END SUBROUTINE H_UPGRADE
          END INTERFACE 
        END MODULE H_UPGRADE__genmod
