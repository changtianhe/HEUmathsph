        !COMPILER-GENERATED INTERFACE MODULE: Thu Oct 21 16:19:32 2021
        MODULE AV_VEL__genmod
          INTERFACE 
            SUBROUTINE AV_VEL(NTOTAL,MASS,NIAC,PAIR_I,PAIR_J,W,VX,RHO,AV&
     &)
              INTEGER(KIND=4) :: NTOTAL
              REAL(KIND=8) :: MASS(100000)
              INTEGER(KIND=4) :: NIAC
              INTEGER(KIND=4) :: PAIR_I(20000000)
              INTEGER(KIND=4) :: PAIR_J(20000000)
              REAL(KIND=8) :: W(20000000)
              REAL(KIND=8) :: VX(3,100000)
              REAL(KIND=8) :: RHO(100000)
              REAL(KIND=8) :: AV(3,100000)
            END SUBROUTINE AV_VEL
          END INTERFACE 
        END MODULE AV_VEL__genmod
