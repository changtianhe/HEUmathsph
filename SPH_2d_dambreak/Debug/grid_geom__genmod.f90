        !COMPILER-GENERATED INTERFACE MODULE: Wed Nov 03 21:40:38 2021
        MODULE GRID_GEOM__genmod
          INTERFACE 
            SUBROUTINE GRID_GEOM(I,X,NGRIDX,MAXGRIDX,MINGRIDX,DGEOMX,   &
     &XGCELL)
              INTEGER(KIND=4) :: I
              REAL(KIND=8) :: X(3)
              INTEGER(KIND=4) :: NGRIDX(3)
              REAL(KIND=8) :: MAXGRIDX(3)
              REAL(KIND=8) :: MINGRIDX(3)
              REAL(KIND=8) :: DGEOMX(3)
              INTEGER(KIND=4) :: XGCELL(3)
            END SUBROUTINE GRID_GEOM
          END INTERFACE 
        END MODULE GRID_GEOM__genmod
