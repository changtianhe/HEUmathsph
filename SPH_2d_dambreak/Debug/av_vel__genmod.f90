        !COMPILER-GENERATED INTERFACE MODULE: Wed Nov 03 21:40:37 2021
        MODULE AV_VEL__genmod
          INTERFACE 
            SUBROUTINE AV_VEL(NTOTAL,MASS,NIAC,PAIR_I,PAIR_J,W,VX,RHO,AV&
     &)
              INTEGER(KIND=4) :: NTOTAL
              REAL(KIND=8) :: MASS(100000)
              INTEGER(KIND=4) :: NIAC
              INTEGER(KIND=4) :: PAIR_I(10000000)
              INTEGER(KIND=4) :: PAIR_J(10000000)
              REAL(KIND=8) :: W(10000000)
              REAL(KIND=8) :: VX(3,100000)
              REAL(KIND=8) :: RHO(100000)
              REAL(KIND=8) :: AV(3,100000)
            END SUBROUTINE AV_VEL
          END INTERFACE 
        END MODULE AV_VEL__genmod
