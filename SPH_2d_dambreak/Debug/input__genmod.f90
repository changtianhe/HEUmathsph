        !COMPILER-GENERATED INTERFACE MODULE: Fri Nov 05 10:12:23 2021
        MODULE INPUT__genmod
          INTERFACE 
            SUBROUTINE INPUT(X,VX,MASS,RHO,P,U,ITYPE,HSML,NTOTAL)
              REAL(KIND=8) :: X(3,100000)
              REAL(KIND=8) :: VX(3,100000)
              REAL(KIND=8) :: MASS(100000)
              REAL(KIND=8) :: RHO(100000)
              REAL(KIND=8) :: P(100000)
              REAL(KIND=8) :: U(100000)
              INTEGER(KIND=4) :: ITYPE(100000)
              REAL(KIND=8) :: HSML(100000)
              INTEGER(KIND=4) :: NTOTAL
            END SUBROUTINE INPUT
          END INTERFACE 
        END MODULE INPUT__genmod
