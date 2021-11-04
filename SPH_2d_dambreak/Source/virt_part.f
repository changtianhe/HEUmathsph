      subroutine virt_part(itimestep, ntotal,nvirt,hsml,mass,x,vx,
     &           rho,u,p,itype) 

c----------------------------------------------------------------------
c   Subroutine to determine the information of virtual particles
c   Here only the Monaghan type virtual particles for the 2D dambreak problem are generated.
c     itimestep : Current time step                                 [in]
c     ntotal : Number of particles                                  [in]
c     nvirt  : Number of virtual particles                         [out]
c     hsml   : Smoothing Length                                 [in|out]
c     mass   : Particle masses                                  [in|out]
c     x      : Coordinates of all particles                     [in|out]
c     vx     : Velocities of all particles                      [in|out]
c     rho    : Density                                          [in|out]
c     u      : internal energy                                  [in|out]
c     itype   : type of particles -2                            [in|out]

      implicit none
      include 'param.inc'
      integer itimestep, ntotal, nvirt, itype(maxn)
      double precision hsml(maxn),mass(maxn),x(maxdim,maxn),
     &                  vx(maxdim,maxn),
     &                 rho(maxn), u(maxn), p(maxn)
      integer i, j, d, im, mb, nb
      double precision xl,y1, dx, v_inf, h_swl
      character(len=30) string_name,virtnumber

      if (vp_input) then          
                        
        open(1,file="data\xv_vp.dat")
        open(2,file="data\state_vp.dat")
        open(3,file="data\other_vp.dat")            
        read(1,*) nvirt
        do j = 1, nvirt   
          i = ntotal + j      
          read(1,*)im, (x(d, i),d = 1, dim), (vx(d, i),d = 1, dim)                     
c         read(2,*)im, mass(i), rho(i), p(i), u(i)   
          read(2,*)im, mass(i), rho(i), p(i)     
          read(3,*)im, itype(i), hsml(i)                            
        enddo  
        close(1)
        close(2) 
        close(3) 
      
	else 
       
	nvirt = 0
        mb = 200
        nb = 100
	xl = 4.
      y1 = 2.
      h_swl = 1.

	dx = xl / mb
      
	v_inf = 0.

c     Monaghan type virtual particle on the Upper side

c        do i = 1, 4*mb+1
c   	  nvirt = nvirt + 1
c	  x(1, ntotal + nvirt) = (i-1)*dx/2 
c          x(2, ntotal + nvirt) = y1  
c          vx(1, ntotal + nvirt) = v_inf
c	  vx(2, ntotal + nvirt) = 0.
c        enddo

c     Monaghan type virtual particle on the Lower side

        do i = 1, mb+1
   	  nvirt = nvirt + 1
	  x(1, ntotal + nvirt) = (i-1)*dx 
          x(2, ntotal + nvirt) = 0.  
          vx(1, ntotal + nvirt) = 0.
	  vx(2, ntotal + nvirt) = 0.
        enddo 

c     Monaghan type virtual particle on the Left side

        do i = 1, nb
   	  nvirt = nvirt + 1
	  x(1, ntotal + nvirt) = 0. 
          x(2, ntotal + nvirt) = (i-1)*dx + dx
          vx(1, ntotal + nvirt) = 0.
	  vx(2, ntotal + nvirt) = 0.
        enddo

c     Monaghan type virtual particle on the Right side

        do i = 1, nb
   	  nvirt = nvirt + 1
	  x(1, ntotal + nvirt) = xl  
          x(2, ntotal + nvirt) = (i-1)*dx + dx 
          vx(1, ntotal + nvirt) = 0.
	  vx(2, ntotal + nvirt) = 0.
        enddo

c   底部第二层
      do i = 1, mb+2
   	  nvirt = nvirt + 1
	  x(1, ntotal + nvirt) = (i-1)*dx - dx/2.
          x(2, ntotal + nvirt) = -dx/2.  
          vx(1, ntotal + nvirt) = 0.
	  vx(2, ntotal + nvirt) = 0.
        enddo 
        
c     左边界第二层
        do i = 1, nb
   	  nvirt = nvirt + 1
	  x(1, ntotal + nvirt) = -dx/2. 
          x(2, ntotal + nvirt) = (i-1)*dx + dx/2.
          vx(1, ntotal + nvirt) = 0.
	  vx(2, ntotal + nvirt) = 0.
        enddo 
c     右边界第二层
        do i = 1, nb
   	  nvirt = nvirt + 1
	  x(1, ntotal + nvirt) = xl +dx/2.
          x(2, ntotal + nvirt) = (i-1)*dx + dx/2.
          vx(1, ntotal + nvirt) = 0.
	  vx(2, ntotal + nvirt) = 0.
        enddo

	do i = 1, nvirt
	 p(ntotal + i) = 1000.*9.8*(h_swl - x(2,ntotal + i))
c      rho (ntotal + i)=1000.
       rho (ntotal + i)=1000.*(1+7*9.81*(h_swl 
     &  - x(2,ntotal + i))/(100*sqrt(9.81*h_swl)**2))**(1./7)
c         rho (ntotal + i)=1000.*(1+7*p(ntotal + i)/
c     & (1000.*(100.*sqrt(9.81*h_swl)**2)))**(1/7)
	 mass(ntotal + i) = 1000. * dx * dx
	 u(ntotal + i) = 357.1
	 itype(ntotal + i) = -2
	 hsml(ntotal + i) = 1.*dx
        enddo
        
      endif   
      
      

      write(virtnumber,* ) nvirt
      string_name = 'ZONE I='//trim(adjustl(virtnumber))//' F=POINT'
      
      if (mod(itimestep,save_step).eq.0) then
        open(1,file="data\vp_xv0.dat")

       write(1,*)'TITLE="initital distribution  of boundary particles"'
       write(1,*)'VARIABLES="X","Y","VX","VY","density","pressure"'
       write(1,*) string_name

        do i = ntotal + 1, ntotal + nvirt         
          write(1,1001)  (x(d, i), d=1,dim), (vx(d, i), d = 1, dim),              
     &                rho(i),p(i)                              
        enddo       
1001    format( 6(2x, e16.8))

        close(1)
      endif 

      !if (mod(itimestep,print_step).eq.0) then
      !  if (int_stat) then
      !   print *,' >> Statistics: Virtual boundary particles:'
      !   print *,'          Number of virtual particles:',NVIRT
      !  endif     
      !endif

      end