      subroutine input(x, vx, mass, rho, p, u, itype, hsml, ntotal)
      
c----------------------------------------------------------------------
c     Subroutine for loading or generating initial particle information

c     x-- coordinates of particles                                 [out]
c     vx-- velocities of particles                                 [out]
c     mass-- mass of particles                                     [out]
c     rho-- dnesities of particles                                 [out]
c     p-- pressure  of particles                                   [out]
c     u-- internal energy of particles                             [out]
c     itype-- types of particles                                   [out]
c     hsml-- smoothing lengths of particles                        [out]
c     ntotal-- total particle number                               [out]

      implicit none     
      include 'param.inc'

      integer itype(maxn), ntotal       
      double precision x(maxdim, maxn), vx(maxdim, maxn), mass(maxn), 
     &                 p(maxn), u(maxn), hsml(maxn), rho(maxn)
      integer i, d, im       

c     load initial particle information from external disk file

      if(config_input) then    
                        
        open(1,file="data\f_xv0.dat")
        open(2,file="data\f_state0.dat")
        open(3,file="data\f_other0.dat")        
      
        write(*,*)'  **************************************************'
        write(*,*)'      Loading initial particle configuration...   '       
	  read (1,*) ntotal 
        write(*,*)'      Total number of particles   ', ntotal    	
        write(*,*)'  **************************************************'	
        do i = 1, ntotal         
          read(1,*)im, (x(d, i),d = 1, dim), (vx(d, i),d = 1, dim)                     
c         read(2,*)im, mass(i), rho(i), p(i), u(i) 
          read(2,*)im, mass(i), rho(i), p(i)
          read(3,*)im, itype(i), hsml(i)                                        
        enddo          
          
      else 
          
        open(1,file="data\f_xv0.dat")
        open(3,file="data\f_other0.dat") 
       
!      if (shocktube) call shock_tube(x, vx, mass, rho, p, u, 
!     &                    itype, hsml, ntotal)                
!
!      if (shearcavity) call shear_cavity(x, vx, mass, rho, p, u, 
!     &                      itype, hsml, ntotal)
!
!      if (poiseuille) call poiseuille_flow(x, vx, mass, rho, p, u, 
!     &                      itype, hsml, ntotal)
      if (dambreak_2d) call dam_break_2d(x, vx, mass, rho, p, u, 
     &                      itype, hsml, ntotal)
      write(11,*)'TITLE="fluid particles"'
      write(11,*)'VARIABLES="i","X","Y","VX","VY","mass","density",
     &"pressure"'
      write(11,*)' ZONE I=100,J= 50, F=POINT'
        do i = 1, ntotal 
          write(1,1001) i, (x(d, i),d = 1, dim), (vx(d, i),d = 1, dim)        
          write(3,1003) i, itype(i), hsml(i)    
        enddo   
1001    format(1x, I6, 7(2x, e16.8)) 
1003    format(1x, I5, 2x, I2, 2x, e16.8) 
        write(*,*)'  **************************************************'
        write(*,*)'      Initial particle configuration generated   '       
        write(*,*)'      Total number of particles   ', ntotal    	
        write(*,*)'  **************************************************' 

      endif

      close(1)
      close(3) 

      end              
 
      subroutine dam_break_2d(x, vx, mass, rho, p, u, 
     &                        itype, hsml, ntotal)

c----------------------------------------------------------------------     
c     This subroutine is used to generate initial data for the 
c     2 d dambreak problem with Re = 2.5e-2
c     x-- coordinates of particles                                 [out]
c     vx-- velocities of particles                                 [out]
c     mass-- mass of particles                                     [out]
c     rho-- dnesities of particles                                 [out]
c     p-- pressure  of particles                                   [out]
c     u-- internal energy of particles                             [out]
c     itype-- types of particles                                   [out]
c          =2   water
c     h-- smoothing lengths of particles                           [out]
c     ntotal-- total particle number                               [out]

      implicit none     
      include 'param.inc'
      
      integer itype(maxn), ntotal
      double precision x(maxdim, maxn), vx(maxdim, maxn), mass(maxn),
     &     rho(maxn), p(maxn), u(maxn), hsml(maxn)
      integer i, j, d, m, n, mp, np, k
      double precision xl,y1, dx, dy, h_swl

c     Giving mass and smoothing length as well as other data.

      m = 101
      n = 51
      mp = m-1
      np = n-1
      ntotal = mp * np
      xl = 2.
      y1 = 1.
      dx = xl/mp
      dy = y1/np
       h_swl = y1 - dy

      do i = 1, mp
	do j = 1, np
	  k = j + (i-1)*np
	  x(1, k) = (i-1)*dx + dx/2.
	  x(2, k) = (j-1)*dy + dy/2.
        enddo
      enddo

      do i = 1, mp*np
	vx(1, i) = 0.
	vx(2, i) = 0.  
       p(i)= 1000.*9.81*(h_swl - x(2,i)) 
c     rho (i)= 1000.
      rho (i)= 1000.*(1+7*p(i)/(1000.*(100*sqrt(9.81*h_swl)**2)))**(1/7)  
       mass(i) = dx*dy*rho (i) 
       u(i)=357.1
       itype(i) = 2
c      hsml(i) = 2. * sqrt(2 * dx**2 )
       hsml(i) = 1.4 *dx
      enddo  

      end	